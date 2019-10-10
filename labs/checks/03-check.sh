#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

if [[ ! -f "${WORKDIR}/ansible.cfg" ]]; then
    test_status "Le fichier ${WORKDIR}/ansible.cfg est bizarrement absent" 1
    exit 1
fi

if [[ ! -f "${WORKDIR}/inventory" ]]; then
    test_status "Le fichier ${WORKDIR}/inventory est bizarrement absent" 1
    exit 1
fi

cd "${WORKDIR}/"
ansible node3 -m ping >/dev/null 2>&1
test_status "Python installé sur node3" "$?"
