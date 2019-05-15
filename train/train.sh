#!/bin/bash

cd ~/
git clone --recursive https://github.com/daniel-kukiela/nmt-chatbot
cd nmt-chatbot
pip3 install -r requirements.txt
cd setup
python3 prepare_data.py
cd ..
python3 train.py
