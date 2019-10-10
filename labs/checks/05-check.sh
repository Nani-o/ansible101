#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

for host in node1 node2 node3
do
    run_testinfra_tests $host 05
    test_status "Présence du package htop sur $host" "$?"
done
