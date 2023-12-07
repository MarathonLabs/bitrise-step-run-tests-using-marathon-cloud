#!/usr/bin/env bash
set -ex

command_args=" -api-key $API_KEY -app $application -testapp $test_application -platform $platform -system-image $system_image -isolated $isolated"

if [ -n "$os_version" ]; then
    command_args="$command_args -os-version $os_version"
fi

if [ -n "$link" ]; then
    command_args="$command_args -link $link"
fi

if [ -n "$run_name" ]; then
    command_args="$command_args -name $run_name"
fi

if [[ $OSTYPE == 'darwin'* ]]; then
  echo 'macOS agents preinstall marathon-cloud cli via brew'
  marathon-cloud $command_args
elif [[ $OSTYPE == 'linux'* ]]; then
  echo 'using docker image $docker_image to pull the latest marathon-cloud cli version'
  docker pull $docker_image
  docker run -v "$(pwd)":/work --rm $docker_image $command_args
fi
