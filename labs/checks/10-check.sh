#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

cd "${WORKDIR}/"
run_testinfra_tests web 10.1
test_status "Apache écoute sur le port 8080" "$?"
