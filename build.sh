#!/bin/bash

repo_name=${REPOSITORY_NAME}
current_working_dir=$(pwd)
app_image_name=${APP_IMAGE_NAME}

docker rmi $app_image_name

docker build --no-cache --build-arg REPOSITORY_NAME=$repo_name -t builder -f ./builder/Dockerfile ./builder

# we don't want to run this container in detach mode
docker run -m 2g --memory-reservation=512m --cpus=2 --cpu-shares=2000 -v $current_working_dir/bin:/app/bin/ --name builder_app builder

docker rm builder_app
docker rmi builder

echo "APP IMAGE NAME: $app_image_name"

docker build -t $app_image_name -f ./app/Dockerfile ./bin