#!/bin/bash

cd $(dirname "$0")
cd ..

rm -rf .tmp

REPO="https://github.com/jeff-hykin/better-shell-syntax"
COMMIT="02b319d961f1396b35981139d38c572134806cb5"
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