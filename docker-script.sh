#!/bin/bash
set -e
docker image ls
docker run -d --name solar-system \
-e MONGO_URI=$MONGO_URI \
-e MONGO_USERNAME=$MONGO_USERNAME \
-e MONGO_PASSWORD=$MONGO_PASSWORD \
$DOCKERS_USERNAME/solar-system:$GITHUB_SHA
sleep 10
docker ps -a
docker logs solar-system
export DOCKER_CONTAINER_ID=$(docker ps -q -f name=solar-system)
docker exec "$DOCKER_CONTAINER_ID" npm test 
wget -q -O  127.0.0.1:3000/live | grep "Server is live"