#!/usr/bin/env bash
echo "installing imasubreddit binaries"
GITRAW="https://raw.githubusercontent.com/paperbenni/imasubreddit/master/train"
pushd /bin
curl $GITRAW/prepare.sh > imaprepare
curl $GITRAW/train.sh > imatrain
echo "cd /root/nmt-chatbot && python3 inference.py" > imatalk
chmod +x imaprepare imatrain imatalk
popd
