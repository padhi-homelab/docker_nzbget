#!/bin/sh

if ! [ -f "/config/nzbget.conf" ]; then
    cp /nzbget.conf /config/nzbget.conf
fi

if [ -z "${ENTRYPOINT_RUN_AS_ROOT:-}" ]; then
    chown -R $DOCKER_USER:$DOCKER_GROUP /config /data /downloads
fi
