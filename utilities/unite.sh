#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)
pb grep

mkdir temp
mv * temp/
cd temp
cat * >>../train.txt
cd ..

echo "removing duplicate lines"
sort -u train.txt >train2.txt
echo "shuffling lines"
shuf <train2.txt >train.txt
rm train2.txt

echo "removing long lines"
sed -i -E '/:;:.{850}/d' train.txt
sed -i -E '/.{850}:;:/d' train.txt

echo "removing unusable lines by regex"
regexfilter train.txt 'https' '^.{,4}$' '\[deleted\]' '^!' ':;:!' '\[removed\]'

echo "splitting files"
egrep -o 'pb:;:pb.*' <train.txt >train2.to
egrep -o '.*pb:;:pb' <train.txt >train2.from

echo "removing prefixes"
sed -i -e 's/pb:;:pb//g' train2.to
echo "removing suffixes"
sed -i -e 's/pb:;:pb//g' train2.from

echo "extracting testing data"
tail -n 100 train2.from >tst2012.from
tail -n 100 train2.to >tst2012.to

echo "shortening training data"
head -n -100 train2.to >train.to
head -n -100 train2.from >train.from
rm train2.to train2.from

echo "duplicating files"
cp tst2012.from tst2013.from
cp tst2012.to tst2013.to
