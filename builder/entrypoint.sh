#!/bin/bash

# you can find this in toml file
APP_NAME=$1
BINARY_NAME="app"
SHARED_DIRECTORY="/app/bin"
WORKING_DIRECTORY="/app"

echo "changing to work directory"
cd ${WORKING_DIRECTORY}

echo "clearing the shared directory"
rm -rf ${SHARED_DIRECTORY}/*

echo "project is being built"
cargo build --release

echo "moving the binary from one directory to another"
mv target/release/${APP_NAME} ${SHARED_DIRECTORY}/${BINARY_NAME}