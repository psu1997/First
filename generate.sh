#!/bin/bash

#LIST: Make a commitid list that you want to generate patches through it.
#REPO: The REPO directory.
#PATCH: Generated patches will put in here.

LIST=$1
REPO=$2
PATCH=$3

i=0

cd ${REPO}

cat ${LIST} | while read line
do
    i=`expr $i + 1`
    name=`git format-patch ${line} -1`
    mv ${name} ${PATCH}/$(printf "%04d" "${i}")-${name#*-}
done
