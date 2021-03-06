#!/bin/bash
# Stop all containers
docker stop $(docker ps -a -q)
# Delete all containers
docker rm -v $(docker ps -a -q)
# Delete all images
docker rmi -f $(docker images -q)
