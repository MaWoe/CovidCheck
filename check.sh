#!/bin/bash

BASE=$(dirname $(realpath $0))
OUTPUT_DIR="$BASE/log";
CURRENT_RESULT="log/result.txt"
LOG="log.html"

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
  echo
  echo "Usage: $0 <orderNo>  <birth: yyyy-mm-dd>  <zipCode>"
  echo
  exit 1
fi

cd ${BASE}

if [ -d ${OUTPUT_DIR} ]; then
    rm -rf ${OUTPUT_DIR}/*
else
    mkdir ${OUTPUT_DIR}
fi

echo >> ${LOG}
date +'<h2>%Y-%m-%d %H:%M:%S</h2>' >> ${LOG}
echo "<p>" >> ${LOG}
robot --outputdir ${OUTPUT_DIR} -v orderNo:$1 -v birth:$2 -v zipCode:$3 ./test.robot
echo >> ${LOG}

MATCHES=$(grep -oE 'Ergebnis: *[^ ]+' ${CURRENT_RESULT});
if [ $? == 0 ] ; then
    RESULT=$(echo ${MATCHES} | sed -r 's/^.*Ergebnis: *([^ ]+).*$/\1/g')
    exitCode=0
else
    RESULT="No result yet"
    exitCode=1
fi
echo ${RESULT} >> ${LOG}
echo "</p>" >> ${LOG}

echo "Result: $RESULT"
exit ${exitCode};
