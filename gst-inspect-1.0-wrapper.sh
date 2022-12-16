#!/bin/bash

export LD_LIBRARY_PATH=/var/packages/VideoStation/target/lib/patch/lib/
export GST_PLUGIN_PATH=/var/packages/VideoStation/target/lib/patch/plugins/

/var/packages/VideoStation/target/bin/gst-inspect-1.0.orig "$@"

