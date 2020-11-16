#!/bin/bash

LOG_FILE="/opt/backup_scripts/mybook_backup.log"

# simple rsync backup from primary usb drive to backup
echo "========== $(date) ==========" >> $LOG_FILE

echo "Backing up mybook $(date)" >> $LOG_FILE

# copy the files to the mounted remote drive using rsync
rsync -auv --exclude-from='/opt/backup_scripts/exclude_files.txt' /media/mybook/ /media/elements/mybook_backup/ >> $LOG_FILE

echo "Done backing up mybook $(date)" >> $LOG_FILE

echo "" >> $LOG_FILE
