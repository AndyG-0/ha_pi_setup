#!/bin/bash

# simple rsync backup from primary usb drive to backup
echo "========== $(date) ==========" >> mybook_backup.log


echo "Backing up mybook $(date)" >> mybook_backup.log

# copy the files to the mounted remote drive using rsync
rsync -auv --exclude-from='/opt/backup_scripts/exclude_files.txt' /media/mybook/ /media/elements/mybook_backup/ >> mybook_backup.log

echo "Done backing up mybook $(date)" >> mybook_backup.log

echo "" >> mybook_backup.log
