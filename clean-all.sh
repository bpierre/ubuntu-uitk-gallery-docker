#!/bin/sh

DOCKER_IMAGE="bpierre/ubuntu-uitk-gallery"

echo 'Clean containers...'
docker rm $(docker ps -a | awk '/uitk_/ {print $1}')

echo 'Clean images...'
docker rmi  $DOCKER_IMAGE
