#!/usr/bin/env bash
echo "installing imasubreddit binaries"
GITRAW="https://raw.githubusercontent.com/paperbenni/imasubreddit/master/train"
pushd /bin
curl $GITRAW/prepare.sh > imaprepare
curl $GITRAW/train.sh > imatrain
echo "cd /root/nmt-chatbot && python3 inference.py" > imatalk
echo "zip -r /root/nmt-chatbot /content/nmt-chatbot.zip" > imasave
chmod +x imaprepare imatrain imatalk imasave
popd
