#!/usr/bin/env bash

# Load Generic Libraries
. /c3/bin/libfs.sh
. /c3/bin/liblog.sh
. /c3/bin/libos.sh
. /c3/bin/libvalidations.sh

# Functions

########################
# Configure libnss_wrapper so Daemon commands work with a random user.
# Globals:
#   DAEMON_*
# Arguments:
#   None
# Returns:
#   None
#########################
enable_nss_wrapper() {
  if ! getent passwd "$(id -u)" &> /dev/null && [ -e "$NSS_WRAPPER_LIB" ]; then
    debug "Configuring libnss_wrapper..."
    export LD_PRELOAD="$NSS_WRAPPER_LIB"
    # shellcheck disable=SC2155
    export NSS_WRAPPER_PASSWD="$(mktemp)"
    # shellcheck disable=SC2155
    export NSS_WRAPPER_GROUP="$(mktemp)"
    echo "$DAEMON_USER:x:$(id -u):$(id -g):C3 Daemon:$DAEMON_DIR:/bin/false" > "$NSS_WRAPPER_PASSWD"
    echo "$DAEMON_USER:x:$(id -g):" > "$NSS_WRAPPER_GROUP"
  fi
}
