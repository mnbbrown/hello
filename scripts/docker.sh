#!/bin/bash
set -e
cd /var/cache/drone/src/github.com/mnbbrown/hello

wrapdocker > /dev/null 2>&1 &
sleep 5
docker build -t registry.matthewbrown.io/mnbbrown/hello:$GIT_COMMIT -f ./Dockerfile .
docker push registry.matthewbrown.io/mnbbrown/hello:$GIT_COMMIT
