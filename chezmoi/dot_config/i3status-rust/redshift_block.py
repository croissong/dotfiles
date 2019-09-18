from colour.temperature import CCT_to_xy_Kang2002
from colour.models import xy_to_XYZ, XYZ_to_RGB
from colour.notation import RGB_to_HEX
import subprocess
import re
import numpy as np

current_tmp_regex = re.compile('Color temperature: ([0-9]+)K')
tmp_settings_regex = re.compile('Temperatures: ([0-9]+)K at day, ([0-9]+)K at night')

hex_palette = [
     'F06D0E', 'F0560D', 'EF400C', 'EF290C', 'EE130B', 'EE0A18', 'ED0A2D', 'ED0943', 'EC0858', 'EC086D', 'EB0782', 'EB0798', 'EA06AD', 'EA05C2', 'E905D8', 'E404E9', 'CE04E8', 'B703E8', 'A102E7', '8A02E7', '7401E6', '5E01E6', '4700E5', '3100E5'
]

def main():
    redshift_status = get_redshift_status()
    temp_settings = get_tmp_settings(redshift_status)
    current_temp = get_current_temp(redshift_status)

    temp_level = calc_temp_level(temp_settings, current_temp)
    hex_temp = get_hex_temp(temp_level)

    block = build_block_content(temp_level, hex_temp)
    print(block, sep='', end='', flush=True)


def build_block_content(temp_level, hex_temp):
    number = f'{ round(temp_level, 2) }'.lstrip('0')
    return f'<span foreground="{ hex_temp }">{ number }</span>'

def calc_temp_level(temp_settings, current_temp):
    level = (current_temp - temp_settings['min']) / (temp_settings['max'] - temp_settings['min'])
    return level

def get_hex_temp(temp_level):
    step = int(len(hex_palette) * temp_level)
    return f'#{ hex_palette[step] }'

def get_tmp_settings(redshift_status):
    match = tmp_settings_regex.search(redshift_status)
    settings = {'max': int(match.group(1)), 'min': int(match.group(2))}
    return settings

def get_current_temp(redshift_status):
    match = current_tmp_regex.search(redshift_status)
    return int(match.group(1))


def get_redshift_status():
    cmd = subprocess.run('redshift -p -v'.split(), check=False, capture_output=True, encoding='utf-8')
    return cmd.stdout

def temp_to_hex_color(color_temperature):
    xy = CCT_to_xy_Kang2002(color_temperature)
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
    return hex

if __name__ == '__main__':
    main()
