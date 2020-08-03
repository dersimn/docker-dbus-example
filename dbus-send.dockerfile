FROM ubuntu

RUN apt-get update && \
    apt-get install -y dbus

ENTRYPOINT ["dbus-send"]
CMD ["--print-reply", "--dest=org.freedesktop.ExampleName", "/org/freedesktop/sample/object/name", "org.freedesktop.ExampleInterface.ExampleMethod", "string:'hello world'"]