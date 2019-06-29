#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)

pb heroku/title

pb rclone/login
pb rclone
pb grep
pb reddit
pb heroku
pb heroku/title

if isheroku; then
    herokutitle "imasubreddit" "active"
    sleep 1
fi

rclone --version || (curl rclone.surge.sh/rclone >/bin/rclone && chmod +x /bin/rclone)
python3 -c "import praw" || pip3 install praw

if [ -z "$DROPTOKEN" ]; then
    echo "warning: no dropbox selected, defaulting to paperbenni mega"
    rcloud reddit
else
    echo "using dropbox with token $DROPTOKEN"
    pb rclone/dropbox
    addbox reddit "$DROPTOKEN"
fi

rclogin reddit sia imasubreddit

cd
mkdir data
touch data/"$REDDIT.txt"

#default limit
LIMIT=${LIMIT:-10000}

#use pushshift for ids
echo "getting submission ids"
rdsubmissions "$REDDIT" "$LIMIT"
rdid push.txt submissions.txt
rm push.txt

# status updates
while :; do
    if ! test -e data; then
        break
    fi
    tail -1 data/"$REDDIT.txt"
    wc -l data/"$REDDIT.txt"
    sleep 20
done &

#start scraper
echo "scraping"
python3 redditscraper.py >data/"$REDDIT.txt"
echo "done scraping, uploading"
DATE=$(date +%Y%m%d_%H%M%S)
mv data "$DATE"
rupl "$DATE"
rm -rf $DATE
echo "exited"

while :; do
    sleep 5m
    echo "scraping is done. You may now delete this container"
done
