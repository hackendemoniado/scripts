#!/bin/bash
# -*- ENCODING: UTF-8 -*-
fechahoy=$(date +"%d-%m-%Y")
tar -zcvf backupshistory.$fechahoy.tar.gz /tmp/history_*
cp backupshistory.$fechahoy.tar.gz /backupsscripts/backups_history
rm -rf backupshistory.$fechahoy.tar.gz
rm -rf /tmp/history_*
