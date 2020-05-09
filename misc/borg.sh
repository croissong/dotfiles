REPOSITORY=/mnt/synology
name=${1:-'{now:%Y-%m-%d}'}
# Backup all of /home and /var/www except a few
# excluded directories
borg create -v -s -p                          \
    $REPOSITORY::"{hostname}-$name"    \
    / \
    -e '/dev/*'                  \
    -e '/proc/*'    \
    -e '/sys/*' \
    -e '/tmp/*' \
    -e '/run/*' \
    -e '/mnt/*' \
    -e '/media/*' \
    -e '/lost+found'
# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machine's archives also.s
borg prune -v --list $REPOSITORY --prefix '{hostname}-' \
    --keep-daily=7 --keep-weekly=4 --keep-monthly=6
