#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

cd "${WORKDIR}/"
run_testinfra_tests node1 11.1
test_status "bash_profile déployé avec la bonne couleur pour node1" "$?"

run_testinfra_tests node2 11.1
test_status "bash_profile déployé avec la bonne couleur pour node2" "$?"

run_testinfra_tests node3 11.1
test_status "bash_profile déployé avec la bonne couleur pour node3" "$?"
