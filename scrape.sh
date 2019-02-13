#!/bin/bash

if [ -z "$MEGAUSER" ]; then
    MEGAUSER='reddittest@protonmail.com'
fi

if [ -z "$MEGAPASSWORD" ]; then
    MEGAPASSWORD='ycssGxxdacd-RT5P_labBE0T0xtG0Nnznx0'
fi

pushd ~/.config/rclone
sed -i -e 's/'"megauser"'/'"$MEGAUSER"'/g' rclone.conf
sed -i -e 's/'"megapassword"'/'"$MEGAPASSWORD"'/g' rclone.conf
popd

cd "$HOME"
while :; do
    mkdir data
    python3 redditscraper.py
    DATE=$(date +%Y%m%d_%H%M%S)
    mv data "$DATE"
    rclone copy ./"$DATE" mega:"$DATE"
    rm -rf $DATE
    echo "exited"
    sleep 5m
done
