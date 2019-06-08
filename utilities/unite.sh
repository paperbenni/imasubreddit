#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)
pb grep

mkdir temp
mv * temp/
cd temp
cat * >> ../train.txt
cd ..

regexfilter train.txt 'https' '^.{,4}$' '\[deleted\]' '^!' ':;:!' '\[removed\]'

cat train.txt | egrep -o ':;:.*' > train2.to
cat train.txt | egrep -o '.*:;:' > train2.from

sed -i -e 's/:;://g' train2.to
sed -i -e 's/:;://g' train2.from

shuf -n 100 train2.to > tst2012.to
shuf -n 100 train2.from > tst2012.from
cp tst2012.from tst2013.from
cp tst2012.to tst2013.to

grep -Fvxf tst2012.to train2.to > train.to
grep -Fvxf tst2012.from train2.from > train.from
rm train2.to train2.from
