#!/bin/bash

# This still needs to be tested these additions must be on the same line and not a new line
# This must be ran first and reboot
printf %s " cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" >> /boot/cmdline.txt
sudo shutdown -r 5