#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)

pb heroku/title

pb rclone/login
pb rclone


rcloud reddit
rclogin reddit sia imasubreddit

cd "$HOME"
while :; do
    mkdir data
    touch data/"$REDDIT.txt"
    python3 redditscraper.py
    DATE=$(date +%Y%m%d_%H%M%S)
    mv data "$DATE"
    rupl "$DATE"
    rm -rf $DATE
    echo "exited"
    sleep 5m
done
