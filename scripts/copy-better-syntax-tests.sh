#!/bin/bash

cd $(dirname "$0")
cd ..

rm -rf .tmp

COMMIT="f28b10c92497425f1477011e16a6cc1265b3afe7"

git clone https://github.com/jeff-hykin/better-shell-syntax .tmp/better-shell-syntax

cd .tmp/better-shell-syntax

git checkout $COMMIT

cd ../../

cp -r .tmp/better-shell-syntax/language_examples .tmp/cases

cd .tmp/cases

for filename in *.sh; do mv $filename better-shell-syntax-${filename%.*}.sh; done;
rm *.yaml

cd ../../

cp -a .tmp/cases/. test/cases/