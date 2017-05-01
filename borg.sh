REPOSITORY=/mnt/synology

# Backup all of /home and /var/www except a few
# excluded directories
sudo borg create -v -s -p                          \
    $REPOSITORY::'{hostname}-{now:%Y-%m-%d}'    \
    / \
    -e '/dev/*'                  \
    -e '/proc/*'    \
    -e '/sys/*' \
    -e '/tmp/*' \
    -e '/run/*' \
    -e '/mnt/*' \
    -e '/media/*' \
    -e '/lost+found' \
# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machine's archives also.s
boudo borg prune -v --list $REPOSITORY --prefix '{hostname}-' \
    --keep-daily=7 --keep-weekly=4 --keep-monthly=6
