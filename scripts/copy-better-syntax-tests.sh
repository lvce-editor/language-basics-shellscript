#!/bin/bash

cd $(dirname "$0")
cd ..

rm -rf .tmp

COMMIT="f28b10c92497425f1477011e16a6cc1265b3afe7"
NAME="better-shell-syntax"
TEST_PATH="language_examples"

git clone https://github.com/jeff-hykin/$NAME .tmp/$NAME

cd .tmp/$NAME

git checkout $COMMIT

cd ../../

cp -r .tmp/$NAME/$TEST_PATH .tmp/cases

cd .tmp/cases

for filename in *.sh; do mv $filename $NAME-${filename%.*}.sh; done;
rm *.yaml

cd ../../

cp -a .tmp/cases/. test/cases/