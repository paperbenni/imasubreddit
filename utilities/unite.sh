#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)
pb grep

mkdir temp
mv * temp/
cd temp
cat * >>../train.txt
cd ..

sort -u train.txt > train2.txt
cat train2.txt | shuf > train.txt
rm train2.txt

regexfilter train.txt 'https' '^.{,4}$' '\[deleted\]' '^!' ':;:!' '\[removed\]'

cat train.txt | egrep -o 'pb:;:pb.*' >train2.to
cat train.txt | egrep -o '.*pb:;:pb' >train2.from

sed -i -e 's/pb:;:pb//g' train2.to
sed -i -e 's/pb:;:pb//g' train2.from

tail -n 100 train2.from >tst2012.from
tail -n 100 train2.to >tst2012.to

head -n -100 train2.to >train.to
head -n -100 train2.from >train.from
rm train2.to train2.from

cp tst2012.from tst2013.from
cp tst2012.to tst2013.to
