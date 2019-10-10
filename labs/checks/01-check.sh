#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

if [[ ! -f "${WORKDIR}/inventory" ]]; then
    STATE=1
else
    STATE=0
fi

test_status "Présence du fichier d'inventaire ${WORKDIR}/inventory" $STATE

ALL_HOSTS=$(ansible --list-hosts -i "${WORKDIR}/inventory" all 2>/dev/null)

for host in ansible node1 node2 node3
do
    if [[ "$ALL_HOSTS" == *"$host"* ]]; then
        test_status "Présence de $host dans l'inventaire" 0
        run_testinfra_tests $host 01
        test_status "Appartenance au groupe attendu pour $host" $?
    else
        test_status "Présence de $host dans l'inventaire" 1
        test_status "Appartenance au groupe attendu pour $host" 1
    fi
done
