#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

cd "${WORKDIR}/"
run_testinfra_tests node1 07.1
test_status "Pt1 - Définition de la variable env pour node1" "$?"

run_testinfra_tests node1 07.2
test_status "Pt1 - Définition de la variable bdd_engine pour node1" "$?"

run_testinfra_tests node2 07.1
test_status "Pt1 - Définition de la variable env pour node2" "$?"

run_testinfra_tests node2 07.2
test_status "Pt1 - Définition de la variable bdd_engine pour node2" "$?"

run_testinfra_tests node3 07.1
test_status "Pt1 - Définition de la variable env pour node3" "$?"

run_testinfra_tests node3 07.2
test_status "Pt1 - Définition de la variable bdd_engine pour node3" "$?"

run_testinfra_tests web 07.3
test_status "Pt2 - Contentu du fichier motd sur les machines du groupe web" "$?"
