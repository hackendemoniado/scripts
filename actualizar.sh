#!/bin/bash
# -*- ENCODING: UTF-8 -*-
sudo dnf update -y > /tmp/update.txt
fechahoy=$(date +"%d-%m-%Y")
tar -zcvf backupsupdate.$fechahoy.tar.gz /tmp/update.txt
cp backupsupdate.$fechahoy.tar.gz /backupsscripts/backups_comandoupdate
rm -rf backupsupdate.$fechahoy.tar.gz
rm -rf /tmp/update.txt
