from colour.temperature import CCT_to_xy_Kang2002
from colour.models import xy_to_XYZ, XYZ_to_RGB
from colour.notation import RGB_to_HEX
import subprocess
import re
import numpy as np

def main():
    redshift_status = subprocess.run('redshift -p'.split(), check=False, capture_output=True, encoding='utf-8').stdout
    match = re.search('.*temperature: ([0-9]+)', redshift_status)
    temp = match.group(1)

    xy = CCT_to_xy_Kang2002(int(temp))
    xyz = xy_to_XYZ(xy)
    illuminant_XYZ = np.array([0.34570, 0.35850])
    illuminant_RGB = np.array([0.31270, 0.32900])
    XYZ_to_RGB_matrix = np.array(
        [[3.24062548, -1.53720797, -0.49862860],
         [-0.96893071, 1.87575606, 0.04151752],
         [0.05571012, -0.20402105, 1.05699594]]
    )
    rgb = XYZ_to_RGB(xyz, illuminant_XYZ, illuminant_RGB, XYZ_to_RGB_matrix)
    hex = RGB_to_HEX(rgb)
    print(f'<span foreground="{ hex }">{ temp[0:2] }K</span>', sep='', end='', flush=True)
if __name__ == '__main__':
    main()
