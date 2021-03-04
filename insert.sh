#!/bin/bash

LIST=$1
PATCH=$2
BACKUP_PATCH=$3

if [ ! -d `dirname ${LIST}` ]; then
    echo "There are not list dir!"
fi

if [ ! -d ${BACKUP_PATCH} ]; then
    mkdir ${BACKUP_PATCH}
fi

cp ${PATCH}/backport-* ${BACKUP_PATCH}

cd ${PATCH}
cat ${LIST} | while read INFO
do
    COMMIT_ID=`echo ${INFO} | awk '{print $1}'`
    REF=`echo ${INFO} | awk '{print $2}'`
    NAME=`grep -r ${COMMIT_ID} | awk -F ":" '{print $1}'`
    sed -ri "/^Subject:/ a\ \nConflict: NA \nReference: ${REF}\n" ${NAME%:*}
done

echo "Insert succseful"
