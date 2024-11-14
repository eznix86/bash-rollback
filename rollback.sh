#!/bin/bash

set -u
set -e

_doRoll() {
    set +e
    local WHAT=("$@")
    local failed_rollbacks=()

    for ((i = ${#WHAT[@]} - 1; i >= 0; i--)); do
        echo "Executing rollback:"
        echo "${WHAT[i]//^/  }"
        if ! eval "${WHAT[i]}"; then
            echo "WARNING: Rollback command failed:"
            echo "${WHAT[i]//^/  }"
            failed_rollbacks+=("${WHAT[i]}")
        fi
    done

    if [ ${#failed_rollbacks[@]} -ne 0 ]; then
        echo "ERROR: Some rollbacks failed. Manual intervention needed:"
        for cmd in "${failed_rollbacks[@]}"; do
            echo "Failed command: $cmd"
        done
        return 1
    fi
}

_ROLLBACK=()

rb() {
    local cmd
    if [ $# -eq 1 ]; then
        cmd="$1"
    else
        cmd="$(cat)"
    fi
    _ROLLBACK+=("$cmd")
}

rollback() {
    _doRoll "${_ROLLBACK[@]}"
    exit 1
}

trap 'if [ $? -ne 0 ]; then rollback; fi' EXIT
