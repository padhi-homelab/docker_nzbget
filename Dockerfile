FROM padhihomelab/alpine-base:edge AS nzbget-build

ARG NZBGET_VERSION=21.0
ARG NZBGET_SHA_512=af8f346b00cb13f33ce9c04c028effae0ae84e3909410619eddb0d89a895fcbeb1458177cee22991bbe5308a83759aa097dbc6c2398c385518e520a6bfeb647c

ADD https://github.com/nzbget/nzbget/archive/v${NZBGET_VERSION}.tar.gz \
    /tmp/nzbget.tar.gz

RUN cd /tmp \
 && echo "${NZBGET_SHA_512}  nzbget.tar.gz" > nzbget.tar.gz.sha512 \
 && sha512sum -c nzbget.tar.gz.sha512 \
 && tar xvzf nzbget.tar.gz \
 && mv nzbget-${NZBGET_VERSION} nzbget \
 && cd nzbget \
 && apk add --no-cache --update \
            build-base \
            libxml2-dev \
            openssl-dev \
            zlib-dev \
 && ./configure --disable-curses \
 && make \
 && mkdir -p /app/nzbget \
 && make prefix=/app/nzbget install
 

FROM padhihomelab/alpine-base:3.12_0.19.0_0.2

COPY --from=nzbget-build \
     /app/nzbget/bin/nzbget \
     /usr/bin/nzbget
COPY --from=nzbget-build \
     /app/nzbget/share/nzbget/webui \
     /nzbget/webui
COPY --from=nzbget-build \
     /app/nzbget/share/nzbget/nzbget.conf \
     /nzbget/webui/nzbget.conf.template

COPY nzbget.conf        /
COPY nzbget-server.sh   /usr/local/bin/nzbget-server
COPY setup-volume.sh    /etc/docker-entrypoint.d/

RUN chmod +x /usr/bin/nzbget \
             /usr/local/bin/nzbget-server \
             /etc/docker-entrypoint.d/setup-volume.sh \
 && apk add --no-cache --update \
            libxml2 \
            libssl1.1 \
            p7zip \
            unrar \
            zlib


EXPOSE 8080
VOLUME [ "/config", "/data", "/downloads/complete", "/downloads/incomplete" ]

CMD [ "nzbget-server" ]

HEALTHCHECK --start-period=10s --interval=30s --timeout=5s --retries=3 \
        CMD ["wget", "--tries", "5", "-qSO", "/dev/null",  "http://localhost:6789/"]
