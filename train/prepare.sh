#!/bin/bash

cd ~/
git clone --recursive https://github.com/paperbenni/nmt-chatbot
cd nmt-chatbot
pip3 install -r requirements.txt
cd new_data
rm *
cd ..
