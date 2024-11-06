#!/usr/bin/env bash
set -ex

run_platform=$(echo "$platform" | awk '{print tolower($0)}')
command_args="run $run_platform"
command_args="$command_args --api-key $api_key"
command_args="$command_args --application $application"
command_args="$command_args --test-application $test_application"
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

if [ -n "$system_image" ]; then
  if [ "$run_platform" = "android" ]; then
    command_args="$command_args --system-image $system_image"
  else
    echo "Error: The --system-image parameter is not supported for iOS."
    exit 1
  fi
fi

if [ -n "$output" ]; then
	command_args="$command_args --output $output"
fi

if [ -n "$filter_file" ]; then
	command_args="$command_args --filter-file $filter_file"
fi

if [ -n "$device" ]; then
	command_args="$command_args --device $device"
fi

if [ -n "$xcode_version" ]; then
  if [ "$run_platform" = "ios" ]; then
    command_args="$command_args --xcode-version $xcode_version"
  else
    echo "Error: The --xcode-version parameter is not supported for Android."
    exit 1
  fi
fi

if [ -n "$xctestplan_filter_file" ]; then
  if [ "$run_platform" = "ios" ]; then
    command_args="$command_args --xctestplan-filter-file $xctestplan_filter_file"
  else
    echo "Error: The --xctestplan-filter-file parameter is not supported for Android."
    exit 1
  fi
fi

if [ -n "$xctestplan_target_name" ]; then
  if [ "$run_platform" = "ios" ]; then
    command_args="$command_args --xctestplan-target-name $xctestplan_target_name"
  else
    echo "Error: The --xctestplan-target-name parameter is not supported for Android."
    exit 1
  fi
fi

if [[ $OSTYPE == 'darwin'* ]]; then
	echo 'macOS agents preinstall marathon-cloud cli via brew'
	marathon-cloud $command_args
elif [[ $OSTYPE == 'linux'* ]]; then
	echo 'using docker image $docker_image to pull the latest marathon-cloud cli version'
	docker pull $docker_image
	docker run -v "$(pwd)":/work --rm $docker_image $command_args
fi
