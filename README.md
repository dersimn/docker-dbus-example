
    docker build -t dbus-daemon -f dbus-daemon.dockerfile .
    docker build -t dbus-monitor -f dbus-monitor.dockerfile .
    docker build -t dbus-send -f dbus-send.dockerfile .

    docker network create --driver bridge dbus

    docker run -d --name dbus-daemon --network dbus dbus-daemon
    docker inspect dbus-daemon | grep IPAddress

    docker run \
        -e DBUS_SESSION_BUS_ADDRESS="tcp:host=<IP FROM INSPECT COMMAND>,port=6667,family=ipv4" \
        --network dbus \
        dbus-monitor

In a seperate terminal window run:

    docker run \
        -e DBUS_SESSION_BUS_ADDRESS="tcp:host=<IP FROM INSPECT COMMAND>,port=6667,family=ipv4" \
        --network dbus \
        dbus-send

or

    docker run \
        -e DBUS_SESSION_BUS_ADDRESS="tcp:host=<IP FROM INSPECT COMMAND>,port=6667,family=ipv4" \
        --network dbus \
        dbus-send \
        --print-reply --dest=org.foo.bar /org/foo/sample/object/name org.foo.ExampleInterface.ExampleMethod string:'bar'