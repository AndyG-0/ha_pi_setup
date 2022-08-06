#!/bin/bash

# create crontab
# add job to crontab
# write out current crontab
crontab -l > mycron

# echo new cron into cron file
echo "30 3 * * * apt-get update && apt-get -y upgrade" >> mycron

# install new cron file
crontab mycron
rm mycron
