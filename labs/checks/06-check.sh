#!/bin/bash

SCRIPT_PATH="$(dirname $0)"
source "${SCRIPT_PATH}/check.sh"

if [[ ! -d "${WORKDIR}/playbooks" ]]; then
    test_status "Le dossier ${WORKDIR}/playbooks est absent" 1
    exit 1
fi

if [[ ! -f "${WORKDIR}/playbooks/apache.yml" ]]; then
    test_status "Le fichier ${WORKDIR}/playbooks/apache.yml est absent" 1
    exit 1
fi

cd "${WORKDIR}/"
ansible-playbook playbooks/apache.yml --syntax-check >/dev/null 2>&1
test_status "apache.yml - Syntax Check" "$?"

run_testinfra_tests web 06.1
test_status "apache2 correctement installé sur web" "$?"

run_testinfra_tests web 06.2
test_status "Fichier /var/www/html/index.html déployé sur web" "$?"

run_testinfra_tests web 06.3
test_status "Permissions sur le fichier /var/www/html/index.html sur web" "$?"

run_testinfra_tests web 06.4
test_status "Service apache2 correctement démarré et enabled sur web" "$?"
