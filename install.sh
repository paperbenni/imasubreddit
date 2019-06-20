#!/usr/bin/env bash
echo "installing imasubreddit binaries"
GITRAW="https://raw.githubusercontent.com/paperbenni/imasubreddit/master/train"
pushd /bin
curl $GITRAW/prepare.sh > imaprepare
curl $GITRAW/train.sh > imatrain
chmod +x imaprepare imatrain
popd
