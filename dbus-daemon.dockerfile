FROM ubuntu

RUN apt-get update && \
    apt-get install -y dbus

COPY daemon.conf /daemon.conf

ENTRYPOINT ["dbus-daemon", "--config-file", "/daemon.conf"]