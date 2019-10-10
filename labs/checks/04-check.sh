#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

cd "${WORKDIR}/"
for host in node1 node2 node3
do
    run_testinfra_tests $host 04
    test_status "MOTD correctement déployé sur $host" "$?"
done
