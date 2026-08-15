#!/usr/bin/env bash
# Hot-reload loop for the gym-coach native Android app.
#
# Watches the app's Kotlin source tree; on each save rebuilds the debug APK
# and copies it to a well-known location that the running app observes via
# FileObserver. The app then self-installs via PackageInstaller.Session and
# re-launches MainActivity — no manual tap required.
#
# Requirements:
#   - inotifywait (apt install inotify-tools)
#   - adb is NOT required; this script talks directly to /sdcard inside PRoot
#
# Usage:
#   ./scripts/hotreload.sh            # watch + build loop
#   ./scripts/hotreload.sh --once     # single build, no watching
#
# State:
#   - $PROJECT/app/android/app/build/outputs/apk/debug/app-debug.apk (built)
#   - /sdcard/Android/data/com.gymcoach.gym_coach/files/gym-coach-update.apk
#     (copied; app picks up from here)
#
# Feedback loop: ~10-30 s per change, depending on what Gradle has to redo.

set -euo pipefail

PROJECT="/root/git/gym-coach"
ANDROID_DIR="$PROJECT/app/android"
APK_SRC="$ANDROID_DIR/app/build/outputs/apk/debug/app-debug.apk"
# Where the running app's UpdateObserverService listens. PRoot shares the
# kernel network stack with Android app processes, so loopback works.
RELOAD_HOST="127.0.0.1"
RELOAD_PORT="${HOTRELOAD_PORT:-9876}"
WATCH_ROOTS=(
    "$ANDROID_DIR/app/src/main"
    "$ANDROID_DIR/app/src/test"
)
DEBOUNCE_MS="${HOTRELOAD_DEBOUNCE_MS:-500}"
LOG="$PROJECT/scripts/hotreload.log"

: > "$LOG"

log() {
    printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$*" | tee -a "$LOG"
}

run_build() {
    local started_at elapsed
    started_at=$(date +%s)
    log "=== gradle assembleDebug ==="
    if ! (cd "$ANDROID_DIR" && ./gradlew :app:assembleDebug --console=plain --no-daemon \
            -q 2>&1 | tee -a "$LOG"); then
        log "!!! build failed — keeping previous APK in place"
        return 1
    fi
    elapsed=$(( $(date +%s) - started_at ))
    log "build ok in ${elapsed}s ($(du -h "$APK_SRC" | awk '{print $1}'))"
}

publish_apk() {
    log "publishing -> $RELOAD_HOST:$RELOAD_PORT ($(du -h "$APK_SRC" | awk '{print $1}'))"
    python3 - "$APK_SRC" "$RELOAD_HOST" "$RELOAD_PORT" <<'PY' 2>&1 | tee -a "$LOG"
import socket, struct, sys
path, host, port = sys.argv[1], sys.argv[2], int(sys.argv[3])
with open(path, 'rb') as f:
    data = f.read()
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.settimeout(15)
s.connect((host, port))
s.sendall(struct.pack('>I', len(data)))
s.sendall(data)
s.shutdown(socket.SHUT_WR)
# Read status byte the app sends back (1 byte: 0=ok, 1=err).
try:
    resp = s.recv(1)
    if resp == b'\x00':
        print('app accepted upload')
    else:
        print('app rejected upload')
except socket.timeout:
    print('no ack from app (install may still proceed)')
s.close()
PY
    log "published."
}

build_and_publish() {
    if run_build; then
        publish_apk
    fi
}

if [[ "${1:-}" == "--once" ]]; then
    build_and_publish
    exit $?
fi

log "hotreload.sh watching: ${WATCH_ROOTS[*]}"
log "debounce: ${DEBOUNCE_MS}ms — Ctrl+C to stop"

# Graceful shutdown on SIGINT/SIGTERM.
trap 'log "stopping (signal)"; exit 0' INT TERM

# -r: recursive; -m: monitor (never exit); --include: regex on relative path
inotifywait -q -m -r \
    -e close_write -e create -e delete -e move \
    --include '\.kt$' \
    "${WATCH_ROOTS[@]}" 2>>"$LOG" |
while read -r dir events file; do
    # Drop IDE noise: only react to files under app/src/.
    case "$dir" in
        */app/src/*) : ;;
        *) continue ;;
    esac
    log "change: $dir$file [$events]"

    # Debounce: collapse a burst of saves into one build.
    # Inotify's stdbuf is line-buffered here so we can drain the pipe.
    while read -r -t "$(awk "BEGIN{print ${DEBOUNCE_MS}/1000}")" _; do :; done 2>/dev/null || true

    build_and_publish
done