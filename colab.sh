#!/usr/bin/env bash
cd /root
git clone https://github.com/paperbenni/imasubreddit.git
cd imasubreddit
bash install.sh
bash train/prepare.sh
cd ..

curl "https://raw.githubusercontent.com/paperbenni/colab/master/colab.sh" | bash
