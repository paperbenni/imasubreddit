#!/bin/bash
for folder in ./*; do
    if ! ls "$folder"/; then
        continue
    fi
    pushd folder
    cat train.from >> ../train.from
    cat train.to >> ../train.to
    popd
done
