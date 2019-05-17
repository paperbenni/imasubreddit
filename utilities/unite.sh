#!/bin/bash
for folder in ./*; do
    if ! ls "$folder"/; then
        continue
    fi
    pushd folder
    cat *.txt >> ../train.txt
    popd
done
cat train.txt | grep -v 'https' | egrep -v '\[deleted\]'
