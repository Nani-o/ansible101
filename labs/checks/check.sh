#!/bin/bash

TXTRED=$(tput setaf 1)
TXTGREEN=$(tput setaf 2)
TXTBOLD=$(tput bold)
TXTNORMAL=$(tput sgr0)

export WORKDIR="${HOME}/workdir/current"

function test_status {
    TEST="$1"
    STATE="$2"
    if [[ "$2" == "0" ]]; then
        MESSAGE="[${TXTBOLD}${TXTGREEN}OK${TXTNORMAL}] - $TEST"
    else
        MESSAGE="[${TXTBOLD}${TXTRED}KO${TXTNORMAL}] - $TEST"
    fi
    echo -e "${MESSAGE}"
}

function run_testinfra_tests {
    TARGET="$1"
    EXERCISE="$2"
    pytest --hosts="ansible://$TARGET" \
           --ansible-inventory "${WORKDIR}/inventory" \
           --sudo \
           -vvvvv \
           --ssh-config="${HOME}/.labs/ssh_config" \
           "${HOME}/.labs/checks/check.py" \
           -p no:warnings \
           -k "test_${EXERCISE//./_}" >/dev/null 2>&1
    return "$?"
}
