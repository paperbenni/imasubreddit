#!/bin/bash
source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)
pb grep

mkdir temp
mv * temp/
cd temp
cat * >> ../train.txt
cd ..

regexfilter train.txt 'https' '^.{4,200}$' '\[deleted\]' '^!'

cat train.txt | egrep -o ':;:.*' > train.to
cat train.txt | egrep -o '.*:;:' > train.from

sed -i -e 's/:;://g' train.to
sed -i -e 's/:;://g' train.from
