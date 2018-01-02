FROM alpine
MAINTAINER Ansi Zhang <zhangansi@gmail.com>

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="MIT" \
      org.label-schema.name="ansiyeah/docker-autossh" 

CMD ["/entrypoint.sh"]
ADD ./entrypoint.sh  /entrypoint.sh
RUN chmod 750    /entrypoint.sh

ENV \
    TERM=xterm \
    AUTOSSH_LOGFILE=/dev/stdout \
    AUTOSSH_GATETIME=30         \
    AUTOSSH_POLL=10             \
    AUTOSSH_FIRST_POLL=30       \
    AUTOSSH_LOGLEVEL=1

RUN apk update && \
    echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --update autossh@testing && \
    rm -rf /var/lib/apt/lists/*