#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)
pb ngrok
cd /root
git clone https://github.com/paperbenni/imasubreddit.git
cd imasubreddit
bash install.sh
bash train/prepare.sh
mv /content/* /root/nmt-chatbot/new_data/
cd /root
clear
curl "https://raw.githubusercontent.com/paperbenni/colab/master/colab.sh" | bash &
chmod +x /root/imasubreddit/train/train.sh
/root/imasubreddit/train/train.sh &>/dev/null &

while :; do
    if pgrep python; then
        echo "training"
        getgrok http
        getgrok https
    else

        echo "not training"
        echo "something went wrong or you need to manually start training"
    fi
    sleep 10
done
