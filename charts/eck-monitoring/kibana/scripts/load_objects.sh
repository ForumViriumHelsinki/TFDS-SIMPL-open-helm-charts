﻿#!/bin/bash

mkdir -p /mnt/ilm
LOG_FILE="/mnt/ilm/load_ilm.tmp"

#Loading ILMs

declare -A ilm_policies=(
    ["business-ilm"]="/usr/share/logstash-beats/ilm/business-ilm.json"
    ["technical-ilm"]="/usr/share/logstash-beats/ilm/technical-ilm.json"
    ["logstash-monitoring-ilm"]="/usr/share/logstash-mon/ilm/logstash-monitoring-ilm.json"
    ["metricbeat-ilm"]="/usr/share/metricbeat/ilm/metricbeat-ilm.json"
    ["filebeat-ilm"]="/usr/share/filebeat/ilm/filebeat-ilm.json"
    ["heartbeat-ilm"]="/usr/share/heartbeat/ilm/heartbeat-ilm.json"
    ["metricbeat-hpa-ilm"]="/usr/share/metricbeat/ilm/metricbeat-hpa-ilm.json"
    ["traces-apm.traces-default_policy"]="/usr/share/apm-server/ilm/traces-apm.traces-default_policy.json"
    ["metrics-apm.app_metrics-default_policy"]="/usr/share/apm-server/ilm/metrics-apm.app_metrics-default_policy.json"
)


echo "Starting loading logstash beats ILMs objects..."
for x in "${!ilm_policies[@]}"
do
    file_path="${ilm_policies[$x]}"
    i=1
    echo "Starting loading ILM: $x"
    while :
    do
        echo "Attempt no. $i to load ILM"
        curl -k -Ss  -u elastic:${ELASTIC_PASSWORD}  -X PUT  https://${RELEASE_NAME}-elasticsearch-es-http:9200/_ilm/policy/$x  -H 'Content-Type: application/json' -H 'kbn-xsrf: true' -d @"$file_path" > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [ "`cat $LOG_FILE | awk -F\"\\\"\" '{print $2}'`" = "acknowledged" ]
        then
                echo "ILM $x has been loaded successfully."
                break
        fi
        i=`expr $i + 1`
        sleep 5
    done
done

#Loading templates
echo "Starting loading templates..."
for x in business-template technical-template metricbeat-hpa-template filebeat-monitoring-template
do
    i=1
    echo "Starting template $x"
    while :
    do
        echo "Attempt no. $i to load template"
        curl -k -Ss  -u elastic:${ELASTIC_PASSWORD}  -X PUT  https://${RELEASE_NAME}-elasticsearch-es-http:9200/_index_template/$x  -H 'Content-Type: application/json' -H 'kbn-xsrf: true' -d @/mnt/templates/$x-log.json > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [ "`cat $LOG_FILE | awk -F\"\\\"\" '{print $2}'`" = "acknowledged" ]
        then
                echo "Teamplte $x has been loaded successfully."
                break
        fi
        i=`expr $i + 1`
        sleep 5
    done
done

