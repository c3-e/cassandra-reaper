#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /c3/bin/libos.sh
. /c3/bin/libdaemon.sh

# Configure libnss_wrapper
enable_nss_wrapper

# Ensure daemon user and group exist when running as 'root'
am_i_root && ensure_user_exists "$DAEMON_USER" "$DAEMON_GROUP"

exec "$@"
