# 08 - Conditionals

## Présentation

Il est possible d'exprimer des conditions afin d'exécuter ou non des tâches, pour cela on utilise le mot clé `when` suivi de la condition :

```yaml
---
- hosts: web
  tasks:
    - name: "Install apache2 for Ubuntu"
      apt:
        name: "apache2"
        state: "latest"
      when: "ansible_distribution == 'Ubuntu'"

    - name: "Install httpd for CentOS"
      yum:
        name: "httpd"
        state: "latest"
      when: "ansible_distribution == 'CentOS'"
...
```

> Vous remarquerez que l'on n'utilise pas les doubles accolades `{{ }}` pour spécifier une variable dans une condition, c'est la seule exception à la règle.

> Les conditions utilisent également le moteur Jinja2, vous pouvez trouver plus d'information [ici](https://jinja.palletsprojects.com/en/2.10.x/templates/).

## Exercice

Vous trouverez le playbook `playbooks/mysql.yml` qui contient deux tâches, la première installe le package `mysql-server` tandis que la seconde le supprime. De plus, la variable `local_bdd` a été définie pour vous.
Ajoutez deux conditions au playbook telles que :
  * La tâche d'installation ne s'exécute que lorsque la variable `local_bdd` a pour valeur `True`
  * La tâche de désinstallation ne s'exécute que lorsque la variable `local_bdd` a pour valeur `False`

> Vous pouvez inspecter la valeur de la variable pour chaque host avec la commande `ansible -m debug -a var=local_bdd web`.

Exécutez ensuite le playbook.

<div align=center >
  <a href="./07-Variables.md">Précédent</a> |
  <a href="./09-Loops.md">Suivant</a>
</div>
