#!/usr/bin/env bash
set -ex

if [[ $OSTYPE == 'darwin'* ]]; then
  echo 'macOS agents preinstall marathon-cloud cli via brew'
  marathon-cloud -api-key "$api_key" -apk "$BITRISE_APK_PATH" -testapk "$BITRISE_TEST_APK_PATH"
elif [[ $OSTYPE == 'linux'* ]]; then
  echo 'using docker image $docker_image to pull the latest marathon-cloud cli version'
  docker pull $docker_image
  docker run -v "$BITRISE_APK_PATH":/work/app.apk -v "$BITRISE_TEST_APK_PATH":/work/appTest.apk --rm $docker_image -api-key "$api_key" -apk ./app.apk -testapk ./appTest.apk 
fi

