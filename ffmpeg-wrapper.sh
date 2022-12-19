#!/bin/bash

#########################
# VARS
#########################

pid=$$
stderrfile="/tmp/ffmpeg.stderr"
logfile="/tmp/ffmpeg.log"

echo '' > stderrfile;
echo '' > logfile;

#########################
# UTILS
#########################

function log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$pid] [$1] $2" >> $logfile
}
function newline() {
  echo "" >> $logfile
}
function info() {
  log "INFO" "$1"
}

function handle_error() {
  log "ERROR" "Error on line $(caller)"
  endprocess
}

function endprocess() {
  info "========================================[end ffmpeg $pid]"
  newline
  kill -TERM $child 2>/dev/null
#   rm -f "$stderrfile"
  exit 1
}

#########################
# ENTRYPOINT
#########################

trap endprocess SIGTERM
trap handle_error ERR

newline
info "========================================[start ffmpeg $pid]"
info "DEFAULT_ARGS: $*"

/var/packages/ffmpeg/target/bin/ffmpeg "$@" <&0 2> $stderrfile &
child=$!
info "ffmpeg pid: $child"
wait $child
