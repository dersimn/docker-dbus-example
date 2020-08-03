
    docker build -t dbus-daemon -f dbus-daemon.dockerfile .
    docker build -t dbus-monitor -f dbus-monitor.dockerfile .
    docker build -t dbus-send -f dbus-send.dockerfile .

    docker run -d --name dbus-daemon dbus-daemon
    docker inspect dbus-daemon | grep IPAddress

    docker run \
        -e DBUS_SESSION_BUS_ADDRESS="tcp:host=<IP FROM INSPECT COMMAND>,port=6667,family=ipv4" \
        dbus-monitor

In a seperate terminal window run:

    docker run \
        -e DBUS_SESSION_BUS_ADDRESS="tcp:host=<IP FROM INSPECT COMMAND>,port=6667,family=ipv4" \
        dbus-send

or

    docker run \
        -e DBUS_SESSION_BUS_ADDRESS="tcp:host=<IP FROM INSPECT COMMAND>,port=6667,family=ipv4" \
        dbus-send \
        --print-reply --dest=org.foo.bar /org/foo/sample/object/name org.foo.ExampleInterface.ExampleMethod string:'bar'