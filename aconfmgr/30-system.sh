CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/hooks/clean-cache.hook
CopyFile /etc/pacman.d/hooks/pacdiff.hook 600

CreateLink /etc/localtime /usr/share/zoneinfo/Europe/Berlin

CreateLink /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf

CopyFile /etc/snapper/configs/config 640


CreateLink /etc/containers/certs.d/smarthub-wbench.workbench.telekom.de/user.cert /home/croissong/.ssh/svh/user.crt
CreateLink /etc/containers/certs.d/smarthub-wbench.workbench.telekom.de/user.key /home/croissong/.ssh/svh/userkey.pem
CreateLink /etc/docker/certs.d /home/croissong/.config/containers/certs.d
