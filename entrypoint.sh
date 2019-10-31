#!/bin/sh

echo '- Booting ngrok ...'

[ -n "${AUTHTOKEN_NGROK}" ] || {
    echo 'ERROR: "AUTHTOKEN_NGROK" not set'
    echo 'Env value for auth token of ngrok not set.'
    exit 1
}

HOST_API="${NAME_CONTAINER_LISTEN}:${PORT_CONTAINER_LISTEN}"
REGION_NGROK="${REGION_NGROK:-jp}"
FORMAT_LOG_NGROK="${FORMAT_LOG_NGROK:-json}"

echo "INFO: Target container: ${HOST_API}"

# Sleep 5 sec to wait the target container wakes
sleep 5

echo 'INFO: Target container response header:'
curl --silent --head "http://${HOST_API}/" | grep 200 | grep OK
if [ $? -ne 0 ]; then
    echo 'ERROR: Web API status is not 200'
    echo 'Target container(the Web API container) to expose via ngrok is not running.'
    exit 1
fi

echo 'INFO: Setting auth token of ngrok then run ngrok'
ngrok authtoken $AUTHTOKEN_NGROK && \
ngrok http $HOST_API --region $REGION_NGROK --log-format "${FORMAT_LOG_NGROK}" --log "stdout" > ~/ngrok.log
