#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

cd "${WORKDIR}/"
run_testinfra_tests web 09.1
test_status "Présence de l'utilisateur user1" "$?"

run_testinfra_tests web 09.2
test_status "Présence de l'utilisateur user2" "$?"

run_testinfra_tests web 09.3
test_status "Présence de l'utilisateur user3" "$?"
