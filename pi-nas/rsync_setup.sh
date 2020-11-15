#!/bin/bash

# Copy scripts
mkdir /opt/backup_scripts/ && cp ./rsync_backup.sh /opt/backup_scripts/rsync_backup.sh && cp ./exclude_files.txt /opt/backup_scripts/exclude_files.txt

# create crontab
# add job to crontab
# write out current crontab
crontab -l > mycron

# echo new cron into cron file
echo "30 3 * * * /opt/backup_scripts/rsync_backup.sh" >> mycron

# install new cron file
crontab mycron
rm mycron
