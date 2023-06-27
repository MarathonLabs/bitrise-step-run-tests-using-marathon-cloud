#!/usr/bin/env bash
set -ex

if [[ $OSTYPE == 'darwin'* ]]; then
  echo 'macOS agents preinstall marathon-cloud cli via brew'
  marathon-cloud -api-key "$api_key" -app "$application" -testapp "$test_application" -platform "$platform"
elif [[ $OSTYPE == 'linux'* ]]; then
  echo 'using docker image $docker_image to pull the latest marathon-cloud cli version'
  docker pull $docker_image
  docker run -v "$(pwd)":/work --rm $docker_image -api-key "$api_key" -app "$application" -testapp "$test_application" -platform "$platform"
fi

