#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)

pb heroku/title

pb rclone/login
pb rclone
pb grep

rcloud reddit
rclogin reddit sia imasubreddit

cd
mkdir data
touch data/"$REDDIT.txt"
echo "scraping"

while :; do
    if ! test -e data; then
        break
    fi
    tail -1 data/"$REDDIT.txt"
    wc -l data/"$REDDIT.txt"
    sleep 10
done &

python3 redditscraper.py >data/"$REDDIT.txt"
echo "done scraping, uploading"
DATE=$(date +%Y%m%d_%H%M%S)
mv data "$DATE"
rupl "$DATE"
rm -rf $DATE
echo "exited"
sleep 5m
