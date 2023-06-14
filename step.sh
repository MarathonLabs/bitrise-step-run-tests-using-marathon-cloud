#!/usr/bin/env bash
set -ex

marathon-cloud -api-key "$api_key" -apk "$BITRISE_APK_PATH" -testapk "$BITRISE_TEST_APK_PATH"
