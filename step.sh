#!/usr/bin/env bash
set -ex

run_platform=$(echo "$platform" | awk '{print tolower($0)}')
command_args="run $run_platform"
command_args="$command_args --api-key $api_key"
command_args="$command_args --application $application"
command_args="$command_args --test-application $test_application"
command_args="$command_args --system-image $system_image"
command_args="$command_args --isolated $isolated"

if [ -n "$os_version" ]; then
	command_args="$command_args --os-version $os_version"
fi

if [ -n "$link" ]; then
	command_args="$command_args --link $link"
fi

if [ -n "$run_name" ]; then
	command_args="$command_args --name $run_name"
fi

if [ -n "$ignore_test_failures" ]; then
	command_args="$command_args --ignore-test-failures $ignore_test_failures"
fi

if [[ $OSTYPE == 'darwin'* ]]; then
	echo 'macOS agents preinstall marathon-cloud cli via brew'
	marathon-cloud $command_args
elif [[ $OSTYPE == 'linux'* ]]; then
	echo 'using docker image $docker_image to pull the latest marathon-cloud cli version'
	docker pull $docker_image
	docker run -v "$(pwd)":/work --rm $docker_image $command_args
fi
