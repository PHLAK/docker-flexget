#!/usr/bin/env sh
set -o errexit -o pipefail

FLEXGET_LOCK_FILE="/etc/flexget/.config-lock"
[ -f ${FLEXGET_LOCK_FILE} ] && rm -f ${FLEXGET_LOCK_FILE}

exec "$@"
