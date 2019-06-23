#!/usr/bin/env bash
cd /root
git clone https://github.com/paperbenni/imasubreddit.git
cd imasubreddit
bash install.sh
bash train/prepare.sh
python3 train/upload.py
mv /content/* /root/nmt-chatbot/new_data/
cd /root
clear
curl "https://raw.githubusercontent.com/paperbenni/colab/master/colab.sh" | bash
