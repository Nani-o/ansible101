#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

cd "${WORKDIR}/"
run_testinfra_tests web 12.1
test_status "MySQL est installé, démarré et enable au boot" "$?"

run_testinfra_tests web 12.2
test_status "L'utilisateur appuser a correctement été créé" "$?"

run_testinfra_tests web 12.3
test_status "La base de données app a correctement été créé" "$?"
