#!/bin/bash
# Per-story screen recording helper for Android CI.
# Usage:
#   android_screen_record.sh start <name> [max_segments]
#   android_screen_record.sh stop  <name> <output_dir>
set -uo pipefail

CMD="${1:?Usage: $0 start|stop <name> ...}"
NAME="${2:?Usage: $0 $CMD <name> ...}"
PID_FILE="/tmp/screenrecord_${NAME}_pid.txt"

case "$CMD" in
  start)
    MAX_SEGMENTS="${3:-10}"
    for i in $(seq 1 "$MAX_SEGMENTS"); do
      adb shell rm -f "/sdcard/${NAME}_part${i}.mp4" 2>/dev/null || true
    done
    (
      for i in $(seq 1 "$MAX_SEGMENTS"); do
        adb shell screenrecord --time-limit 180 "/sdcard/${NAME}_part${i}.mp4" || break
      done
    ) &
    echo $! > "$PID_FILE"
    echo "Recording started: $NAME (pid: $!, max segments: $MAX_SEGMENTS)"
    ;;

  stop)
    OUTPUT_DIR="${3:?Usage: $0 stop <name> <output_dir>}"
    if [ ! -f "$PID_FILE" ]; then
      echo "No recording to stop for $NAME"
      exit 0
    fi

    kill "$(cat "$PID_FILE")" 2>/dev/null || true
    sleep 3

    mkdir -p "$OUTPUT_DIR"

    PULLED=0
    for i in $(seq 1 20); do
      if adb pull "/sdcard/${NAME}_part${i}.mp4" "$OUTPUT_DIR/" 2>/dev/null; then
        PULLED=$((PULLED + 1))
      else
        break
      fi
    done

    if [ "$PULLED" -eq 0 ]; then
      echo "No recording segments found for $NAME"
      rm -f "$PID_FILE"
      exit 0
    fi

    (
      cd "$OUTPUT_DIR"
      for i in $(seq 1 "$PULLED"); do
        echo "file '${NAME}_part${i}.mp4'"
      done > "concat_${NAME}.txt"

      if ffmpeg -y -f concat -safe 0 -i "concat_${NAME}.txt" \
           -c copy "recording_${NAME}.mp4" 2>/dev/null; then
        for i in $(seq 1 "$PULLED"); do
          rm -f "${NAME}_part${i}.mp4"
        done
        rm -f "concat_${NAME}.txt"
        echo "Recording saved: recording_${NAME}.mp4 ($PULLED segments)"
      else
        echo "ffmpeg concat failed for $NAME; keeping $PULLED raw segments"
      fi
    )

    rm -f "$PID_FILE"
    ;;

  *)
    echo "Unknown command: $CMD"
    echo "Usage: $0 start|stop <name> ..."
    exit 1
    ;;
esac
