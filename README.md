[![Build Status](https://ci.matthewbrown.io/api/badges/mnbbrown/hello/status.svg)](https://ci.matthewbrown.io/mnbbrown/hello)

**hello** is a simple web application that is used to test continuous integration and deployment. 
See `.drone.yml` for drone build, publish, deploy and notify CI steps.

Run it on CoreOS with the following service file.
`SERVICE_NAME` and `SERVICE_TAGS` are used for [webproxy](https://github.com/mnbbrown/webproxy) support.
```
[Unit]
Description=hello
After=consul.service
Requires=consul.service

[Service]
User=core
ExecStartPre=-/usr/bin/docker pull registry.matthewbrown.io/mnbbrown/hello:latest
ExecStartPre=-/usr/bin/docker kill hello
ExecStartPre=-/usr/bin/docker rm hello
ExecStart=/usr/bin/sh -c "/usr/bin/docker run --rm --name hello \
        -e "SERVICE_TAGS=web" \
        -e "SERVICE_NAME=hello" \
        --dns=$(docker inspect consul | jq -r '.[0].NetworkSettings.IPAddress') \
        registry.matthewbrown.io/mnbbrown/hello"
ExecStop=/usr/bin/docker kill hello

[Install]
WantedBy=multi-user.target
```
