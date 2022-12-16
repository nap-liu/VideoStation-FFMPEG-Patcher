#!/bin/bash

#########################
# VARS
#########################

pid=$$
stderrfile="/tmp/gstreamer.stderr"
logfile="/tmp/gstreamer.log"

#########################
# UTILS
#########################

function log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$1] $2" >> $logfile
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
  info "========================================[end gst-launch $pid]"
  newline
  # rm -f "$stderrfile"
  exit 1
}

#########################
# ENTRYPOINT
#########################

trap endprocess SIGTERM
trap handle_error ERR

newline
info "========================================[start gst-launch $pid]"
info "DEFAULT_ARGS: $*"

export LD_LIBRARY_PATH=/var/packages/VideoStation/target/lib/patch/lib/
export GST_PLUGIN_PATH=/var/packages/VideoStation/target/lib/patch/plugins/

/var/packages/VideoStation/target/bin/gst-launch-1.0.orig "$@" 2>> $stderrfile

