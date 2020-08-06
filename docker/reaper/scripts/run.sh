#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /c3/bin/libos.sh
. /c3/bin/liblog.sh

START_COMMAND=("/usr/local/bin/cassandra-reaper")

info "** Starting Daemon **"
if am_i_root; then
    exec gosu "$DAEMON_USER" "${START_COMMAND[@]}"
else
    exec "${START_COMMAND[@]}"
fi
