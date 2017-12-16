#!/bin/bash

docker build -t tunneler .

configdir=./etc-ssh
echo 'Running container'
docker run -d --rm --name temptunneler tunneler
echo 'Extracting ssh config file to' ${configdir}
docker cp temptunneler:/etc/ssh ${configdir}
echo 'Stopping container'
docker stop temptunneler
echo 'Done.'
