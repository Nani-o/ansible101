#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

cd "${WORKDIR}/"
run_testinfra_tests node1 08.1
test_status "Installation conditionnelle de MySQL sur node1" "$?"

run_testinfra_tests node2 08.1
test_status "Installation conditionnelle de MySQL sur node2" "$?"

run_testinfra_tests node3 08.1
test_status "Installation conditionnelle de MySQL sur node3" "$?"
