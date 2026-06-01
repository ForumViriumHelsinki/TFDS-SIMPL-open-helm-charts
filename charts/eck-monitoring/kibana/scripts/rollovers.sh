﻿#!/bin/bash

mkdir -p /mnt/rollovers
LOG_FILE="/mnt/rollovers/rollovers.tmp"

echo "Executing rollover for metricbeat data stream..."
i=1
while :
do
    echo "Attempt no. $i to rollover data stream"
    echo -n "Checking if metricbeat-ilm policy exists ... "
    /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XGET https://${RELEASE_NAME}-elasticsearch-es-http:9200/_ilm/policy/metricbeat-ilm > $LOG_FILE
    if [ "`cat $LOG_FILE | awk -F\"\\\"\" '{print $2}'`" = "metricbeat-ilm" ]
    then
        echo "yes"
        /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XPOST https://${RELEASE_NAME}-elasticsearch-es-http:9200/metricbeat-${STACK_VERSION}/_rollover > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [[ `cat $LOG_FILE | awk -F"\"" '{print $2}'` == "acknowledged" ]]
        then
                echo "Data stream metricbeat has been rollovered successfully."
                break
        fi
        echo "Rollover not acknowledged, retrying..."
    else
        echo "no"
    fi
    i=`expr $i + 1`
    sleep 5

done


echo "Executing rollover for filebeat data stream..."
i=1
while :
do
    echo "Attempt no. $i to rollover data stream"
    echo -n "Checking if filebeat-ilm policy exists ... "
    /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XGET https://${RELEASE_NAME}-elasticsearch-es-http:9200/_ilm/policy/filebeat-ilm > $LOG_FILE
    if [ "`cat $LOG_FILE | awk -F\"\\\"\" '{print $2}'`" = "filebeat-ilm" ]
    then
        echo "yes"
        /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XPOST https://${RELEASE_NAME}-elasticsearch-es-http:9200/filebeat-${STACK_VERSION}/_rollover > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [[ `cat $LOG_FILE | awk -F"\"" '{print $2}'` == "acknowledged" ]]
        then
                echo "Data stream filebeat has been rollovered successfully."
                break
        fi
        echo "Rollover not acknowledged, retrying..."
    else
        echo "no"
    fi
    i=`expr $i + 1`
    sleep 5
done

echo "Executing rollover for heartbeat data stream..."
i=1
while :
do
    echo "Attempt no. $i to rollover data stream"
    echo -n "Checking if heartbeat-ilm policy exists ... "
    /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XGET https://${RELEASE_NAME}-elasticsearch-es-http:9200/_ilm/policy/heartbeat-ilm > $LOG_FILE
    if [ "`cat $LOG_FILE | awk -F\"\\\"\" '{print $2}'`" = "heartbeat-ilm" ]
    then
        echo "yes"
        /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XPOST https://${RELEASE_NAME}-elasticsearch-es-http:9200/heartbeat-${STACK_VERSION}/_rollover > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [[ `cat $LOG_FILE | awk -F"\"" '{print $2}'` == "acknowledged" ]]
        then
                echo "Data stream heartbeat has been rollovered successfully."
                break
        fi
        echo "Rollover not acknowledged, retrying..."
    else
        echo "no"
    fi
    i=`expr $i + 1`
    sleep 5
done



#Load and rollover apm policies
echo "Starting rolling over apm data streams..."


for y in traces-apm-default
do
    i=1
    echo "Executing rollover for traces data stream $y..."
    echo "Checking if data stream $y exists..."
    /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XGET https://${RELEASE_NAME}-elasticsearch-es-http:9200/_data_stream/$y > $LOG_FILE
    if ! grep -q "\"name\" : \"$y\"" "$LOG_FILE"; then
        echo "Data stream $y does not exist. Skipping rollover and exiting loop."
        break
    fi
    while :
    do
        echo "Attempt no. $i to rollover data stream"
        /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XPOST https://${RELEASE_NAME}-elasticsearch-es-http:9200/$y/_rollover > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [ "`cat $LOG_FILE | awk -F\"\\\"\" '{print $2}'`" = "acknowledged" ]
        then
            echo "Data stream $y has been rollovered successfully."
            break
        fi
        echo "Rollover not acknowledged, retrying..."
        i=`expr $i + 1`
        sleep 5
    done
done

echo "Fetching metrics-apm.app data streams..."
curl -k -Ss -u elastic:${ELASTIC_PASSWORD} -XGET https://${RELEASE_NAME}-elasticsearch-es-http:9200/_data_stream/metrics-apm.app* > $LOG_FILE

DATA_STREAMS=$(grep -o '"name"\s*:\s*"metrics-apm.app[^"]*"' "$LOG_FILE" \
| awk -F'"' '{print $4}')

if [ -z "$DATA_STREAMS" ]; then
echo "No metrics-apm.app data streams found. Exiting."
exit 0
fi

for y in $DATA_STREAMS
do
    i=1
    echo "Executing rollover for data stream $y..."
    while :
    do
        echo "Attempt no. $i to rollover data stream"
        /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XPOST https://${RELEASE_NAME}-elasticsearch-es-http:9200/$y/_rollover > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [ "`cat $LOG_FILE | awk -F\"\\\"\" '{print $2}'`" = "acknowledged" ]
        then
            echo "Data stream $y has been rollovered successfully."
            break
        fi
        echo "Rollover not acknowledged, retrying..."
        i=`expr $i + 1`
        sleep 5
    done
done




