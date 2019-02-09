#!/bin/bash

pushd ~/.config/rclone
sed -i -e 's/'"megauser"'/'"$MEGAUSER"'/g' rclone.conf
sed -i -e 's/'"megapassword"'/'"$MEGAPASSWORD"'/g' rclone.conf
popd

cd "$HOME"
while :; do
    mkdir data
    python3 redditscraper
    DATE=$(date)
    mv data "$DATE"
    rclone copy "$DATE" mega:"$DATE"
    rm -rf $DATE
    sleep 10m
done
