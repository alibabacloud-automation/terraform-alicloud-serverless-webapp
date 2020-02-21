#!/bin/bash

timeout=${2}
while [[ ${timeout} -gt 0 ]]
do
    HTTP_CODE=`curl -w %{http_code} -s -o /dev/null ${1}`
    echo "waiting for the application is ready and current http code is ${HTTP_CODE} ..."
    if [[ ${HTTP_CODE} -eq 200 ]]; then
        exit 0
    fi
    sleep 10
    timeout=$(( ${timeout} - 10 ))
done
exit 1
