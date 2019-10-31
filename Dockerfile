FROM keinos/alpine

LABEL maintainer=https://github.com/KEINOS/
RUN \
    set -e && \
    cd ~/ && \
    apk --no-cache add curl && \
    URL_DOWNLOAD=$(curl -s https://ngrok.com/download | grep linux-arm.zip | grep -oE 'http(s?)://[0-9a-zA-Z/.-]+') && \
    curl --silent --head $URL_DOWNLOAD | grep '200 OK' && \
    curl -o ngrok.zip $URL_DOWNLOAD && \
    unzip ngrok.zip && \
    mv ngrok /usr/local/bin/ && \
    chmod +x /usr/local/bin/ngrok && \
    ngrok --version && \
    rm -rf ngro*
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
HEALTHCHECK --interval=5m --timeout=15s --start-period=10s --retries=3 CMD [ 'curl http://localhost:4040/ | grep Found' ]
