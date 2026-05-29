#!/bin/bash

LOG_FILE="/mnt/ilm/load_ilm.tmp"

#Loading ILMs

echo "Starting loading objects..."
for x in business-ilm technical-ilm
do
    i=1
    echo "Starting loading ILM: $x"
    while :
    do
        echo "Attempt no. $i to load ILM"
        curl -k -Ss  -u elastic:${ELASTIC_PASSWORD}  -X PUT  https://${RELEASE_NAME}-elasticsearch-es-http:9200/_ilm/policy/$x  -H 'Content-Type: application/json' -H 'kbn-xsrf: true' -d @/usr/share/logstash/ilm/logstash-$x.json > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [[ `cat $LOG_FILE | awk -F"\"" '{print $2}'` == "acknowledged" ]]
        then
                echo "ILM $x has been loaded successfully."
                break
        fi
        i=`expr $i + 1`
        sleep 5
    done
done

#Loading templates

for x in business-template technical-template
do
    i=1
    echo "Starting template $x"
    while :
    do
        echo "Attempt no. $i to load template"
        curl -k -Ss  -u elastic:${ELASTIC_PASSWORD}  -X PUT  https://${RELEASE_NAME}-elasticsearch-es-http:9200/_index_template/$x  -H 'Content-Type: application/json' -H 'kbn-xsrf: true' -d @/mnt/ilm/charts/kibana/templates/$x-log.json > $LOG_FILE
        echo "Response:"
        cat $LOG_FILE
        echo -e "\n--------"
        if [[ `cat $LOG_FILE | awk -F"\"" '{print $2}'` == "acknowledged" ]]
        then
                echo "Teamplte $x has been loaded successfully."
                break
        fi
        i=`expr $i + 1`
        sleep 5
    done
done

if [[ ${MINIMAL_STACK} == true ]]
    then
    echo "Minimal stack enabled, executing rollover for metricbeat data stream..."
    i=1
    while :
    do
        echo "Attempt no. $i to rollover data stream"
        echo -n "Checking if metricbeat-ilm policy exists ... "
        /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XGET https://${RELEASE_NAME}-elasticsearch-es-http:9200/_ilm/policy/metricbeat-ilm > $LOG_FILE
        if [[ `cat $LOG_FILE | awk -F"\"" '{print $2}'` == "metricbeat-ilm" ]]
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
fi

if [[ ${MINIMAL_STACK} == true ]]
    then
    echo "Minimal stack enabled, executing rollover for filebeat data stream..."
    i=1
    while :
    do
        echo "Attempt no. $i to rollover data stream"
        echo -n "Checking if filebeat-ilm policy exists ... "
        /usr/bin/curl -Ss -k -u elastic:${ELASTIC_PASSWORD} -XGET https://${RELEASE_NAME}-elasticsearch-es-http:9200/_ilm/policy/filebeat-ilm > $LOG_FILE
        if [[ `cat $LOG_FILE | awk -F"\"" '{print $2}'` == "filebeat-ilm" ]]
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
fi


