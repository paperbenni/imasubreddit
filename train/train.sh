#!/usr/bin/env bash
cd setup
python3 prepare_data.py
cd ..
python3 train.py
