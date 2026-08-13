#!/bin/bash
set -e
docker image ls
docker run -d --name solar-system \
 -p 3000:3000 \
-e MONGO_URI=$MONGO_URI \
-e MONGO_USERNAME=$MONGO_USERNAME \
-e MONGO_PASSWORD=$MONGO_PASSWORD \
$DOCKERS_USERNAME/solar-system:$GITHUB_SHA
sleep 10
docker ps -a
docker logs solar-system
export DOCKER_CONTAINER_ID=$(docker ps -q -f name=solar-system)
export IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' solar-system)
echo $IP
echo testing image url using wget
wget -q -o http://127.0.0.1:3000/live | grep live