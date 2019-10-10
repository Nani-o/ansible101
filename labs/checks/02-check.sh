#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

if [[ ! -f "${WORKDIR}/ansible.cfg" ]]; then
    test_status "Le fichier ${WORKDIR}/ansible.cfg est bizarrement absent" 1
    exit 1
fi

cd "${WORKDIR}/"

HOST_LIST_WITHOUT_INVENTORY_FLAG=$(ansible all --list-hosts 2>&1)
echo $HOST_LIST_WITHOUT_INVENTORY_FLAG | grep -q 'No inventory was parsed'
[[ "$?" == "0" ]] && RC="1" || RC="0"
test_status "Inventaire spécifié sans utiliser '-i INVENTAIRE'" "$RC"
