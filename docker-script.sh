bin/bash
set -e
docker image ls
docker run -d --name solar-system \
-e MONGO_URI=${{ vars.MONGO_URI }} \
-e MONGO_USERNAME=${{ vars.MONGO_USERNAME }} \
-e MONGO_PASSWORD=${{ secrets.MONGO_PASSWORD }} \
${{ secrets.DOCKER_USERNAME }}/solar-system:${{ github.sha }}
sleep 10
docker ps -a
docker logs solar-system
export DOCKER_CONTAINER_ID=$(docker ps -q -f name=solar-system)
docker exec "$DOCKER_CONTAINER_ID" npm test 
