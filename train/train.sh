#!/usr/bin/env bash
if ! [ -e setup ]; then
    cd /root/nmt-chatbot
fi
cd setup
python3 prepare_data.py
cd ..
python3 train.py
