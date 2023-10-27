#!/bin/bash

cd $(dirname "$0")
cd ..

rm -rf .tmp

REPO="https://github.com/jeff-hykin/better-shell-syntax"
COMMIT="7220287a2e40d5909f346ebdc913a67c39f1927c"
TEST_PATH="language_examples"

git clone $REPO .tmp/better-shell-syntax

cd .tmp/better-shell-syntax

git checkout $COMMIT

cd ../../

cp -r .tmp/better-shell-syntax/$TEST_PATH .tmp/cases

cd .tmp/cases

for filename in *.sh; do mv $filename better-shell-syntax-${filename%.*}.sh; done;
rm *.yaml

cd ../../

cp -a .tmp/cases/. test/cases/