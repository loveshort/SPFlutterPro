#!/bin/bash
set -euo pipefail

ROOT_DIR="/Users/macmini/Documents/MyInfo/SPFlutterPro"
IOS_DIR="$ROOT_DIR/ios"
ANDROID_DIR="$ROOT_DIR/android"
LOG_DIR="$ROOT_DIR/.fastlane-logs"
mkdir -p "$LOG_DIR"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

# iOS dev upload to Pgyer (uses fastlane dev)
(
  cd "$IOS_DIR"
  echo "[iOS] fastlane dev starting..."
  if command -v bundle >/dev/null 2>&1; then
    bundle exec fastlane dev 2>&1 | tee "$LOG_DIR/ios_dev_$(date +%Y%m%d_%H%M%S).log"
  else
    fastlane dev 2>&1 | tee "$LOG_DIR/ios_dev_$(date +%Y%m%d_%H%M%S).log"
  fi
) &
IOS_PID=$!

# Android debug upload to Pgyer
(
  cd "$ANDROID_DIR"
  echo "[Android] fastlane debug_pgyer starting..."
  if command -v bundle >/dev/null 2>&1; then
    bundle exec fastlane debug_pgyer 2>&1 | tee "$LOG_DIR/android_debug_pgyer_$(date +%Y%m%d_%H%M%S).log"
  else
    fastlane debug_pgyer 2>&1 | tee "$LOG_DIR/android_debug_pgyer_$(date +%Y%m%d_%H%M%S).log"
  fi
) &
ANDROID_PID=$!

wait $IOS_PID || IOS_STATUS=$?
wait $ANDROID_PID || ANDROID_STATUS=$?

IOS_STATUS=${IOS_STATUS:-0}
ANDROID_STATUS=${ANDROID_STATUS:-0}

echo "[Summary] iOS status: $IOS_STATUS, Android status: $ANDROID_STATUS"

if [[ "$IOS_STATUS" -ne 0 || "$ANDROID_STATUS" -ne 0 ]]; then
  echo "At least one build failed. See logs in $LOG_DIR" >&2
  exit 1
fi

echo "Both builds finished successfully. Logs in $LOG_DIR"


