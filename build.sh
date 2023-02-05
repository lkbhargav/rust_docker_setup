#!/bin/bash

repo_name=${REPOSITORY_NAME}
current_working_dir=$(pwd)
app_image_name=${APP_IMAGE_NAME}
repo_link=${REPOSITORY_LINK}
branch_to_clone=${BRANCH_TO_CLONE}

docker rmi $app_image_name

docker build \
  --no-cache \
  --build-arg REPOSITORY_NAME=$repo_name \
  --build-arg REPOSITORY_LINK=$repo_link \
  --build-arg BRANCH_TO_CLONE=$branch_to_clone \
  -t builder \
  -f ./builder/Dockerfile ./builder

# we don't want to run this container in detach mode to make sure everything happens synchronously
docker run \
  -m 2g --memory-reservation=512m \
  --cpus=2 --cpu-shares=2000 \
  -v $current_working_dir/bin:/app/bin/ \
  --name builder_app builder

docker rm builder_app
docker rmi builder

docker build -t $app_image_name -f ./app/Dockerfile ./bin