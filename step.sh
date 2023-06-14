#!/usr/bin/env bash
set -ex

marathon-cloud -api-key "$API_KEY" -apk "$BITRISE_APK_PATH" -testapk "$BITRISE_TEST_APK_PATH"
