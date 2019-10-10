# 07 - Variables

## Présentation

Afin d'altérer le résultat d'un playbook en fonction de nos besoins et nos machines, il est possible de définir et d'utiliser des variables. Ansible est écrit en python et son moteur de variable est basé autour du moteur de template Jinja2.

Il est possible de définir des variables à 22 niveaux différents dans Ansible et la surcharge des variables suis un ordre précis (consultable [ici](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable)).

Comme expliqué dans la documentation, il n'est pas dans la philosophie d'Ansible de passer son temps à se demander d'où vient la valeur d'une variable, il convient alors d'adopter une stratégie dans le choix de l'endroit où définir ses variables.

Décrivons les endroits les plus communs où définir ses variables dans l'ordre de précédence (du plus faible au plus fort) :
  * **role defaults :** Variables par défauts définies dans un rôle
  * **inventory group_vars :** Variables en fonction du groupe définies dans le dossier d'inventaire
  * **playbook group_vars :** Variables en fonction du groupe définies dans le dossier du playbook
  * **inventory host_vars :** Variables en fonction de l'host définies dans le dossier d'inventaire
  * **playbook host_vars :** Variables en fonction de l'host définies dans le dossier du playbook
  * **role vars :** Variables définies dans le rôle (fichier `role/vars/main.yml`)
  * **extra vars :** Variables passées en argument de command line avec le flag `-e`

Pas mal de notions définies ici sont assez floues, commençons par expliquer le principe de `group_vars` et `host_vars`. Il est possible de créer deux dossiers soit dans le `dossier de playbooks` soit dans le `dossier d'inventaire` afin d'y placer des variables s'appliquant respectivement à un `groupe` ou un `host`.

Concrètement voici un exemple de structure de fichiers d'un projet Ansible :
```
.
├── ansible.cfg ................. Fichier de configuration
├── playbooks ................... Dossier des playbooks
│   ├── playbook.yml ............ Playbook affecté par les group/host vars
│   ├── host_vars ............... Variables en fonction du host
│   │   ├── node1 ............... Dossier de variables pour la machine node1
│   │   │   └── main.yml ........ Tout les fichier du dossier sont chargés
│   │   ├── node2
│   │   │   └── main.yml
│   │   └── node3
│   │       └── main.yml
│   └── group_vars .............. Variables en fonction du groupe
│       ├── web ................. Dossier de variables pour les machines du groupe web
│       │   └── main.yml
│       └── all ................. Dossier spécial avec des variables pour toutes les machines
│           └── main.yml
└── inventory ................... Dossier d'inventaire
    ├── hosts ................... Fichier d'inventaire
    ├── host_vars
    └── group_vars
[...]
```

Il est ainsi possible de créer des jeux variables à destination des machines que l'on souhaite tout en ayant la possibilité de définir des valeurs par défaut saines.

Voyons maintenant à quoi ressemble un fichier de variable, comme vous vous en doutez, il s'agit d'un fichier `yaml` :

```yaml
---
env: "prod"               # On peut définir des strings ...
instance_number: 4        # ... des integers ...
enable_beta: True         # ... des booléens (yes/no True/False true/false) ...
databases:                # ... des listes ...
  - "app1"
  - "app2"
database_creds:           # ... et des dictionnaires.
  login: "root"
  password: "password"
...
```

## Exercice pt1

A partir de ce que l'on vient de voir, mettre en place les variables suivantes :
  * dans les `groups_vars` du dossier `./inventory`, définir la variable `bdd_engine` avec comme valeur `mysql` pour les machines du groupe `web`
  * dans les `host_vars` du dossier `./inventory` :
    * pour la machine `node1` définir la variable `env` à `dev`
    * pour la machine `node2` définir la variable `env` à `dev` ainsi que la variable `bdd_engine` à `mariadb`
    * pour la machine `node3` définir la variable `env` à `prod`

Vous pouvez utiliser la commande suivante afin de vérifier votre solution :
```bash
ansible -m debug -a "var=variable" host
```

> Vous pouvez également utiliser la commande `lab check` qui vous validera la première partie de l'exercice

## Présentation

Nous allons maintenant exploiter les variables que nous avons définies dans notre playbook. Lorsque l'on fait appel à une variable (à une exception près que nous verrons dans le prochain lab), on utilise la syntaxe Jinja, à savoir placer la variable entre doubles accolades : `{{ variable }}`.

Concrètement voici un exemple de playbook faisant usage de variables à divers endroits :

```
---
- hosts: "{{ playbook_target }}"
  tasks:
    - name: "Installing {{ package_name }}"
      apt:
        name: "{{ package_name }}"
        state: "{{ package_state }}"
...
```

Vous pouvez facilement concaténer une variable avec une string de ces deux façons :
  * `{{ variable }}_text`
  * `{{ variable + "_text" }}`

Comme vous pouvez le voir il est possible d'utiliser le moteur jinja pour manipuler les variables, il est possible d'utiliser des fonctions (appelés filter), ou encore d'utiliser des opérateurs logiques.

## Exercice pt2

Dans le dossier `playbooks` vous trouverez deux fichiers, `dev_motd` et `prod_motd`
  * Editez le fichier `playbooks/deploy.yml`, il déploie le fichier à l'origine le fichier `motd`, faites en sorte qu'il déploie l'un de nos fichiers présents en fonction de la variable `env`

Exécutez ensuite le playbook.

<div align=center >
  <a href="./06-Playbook.md">Précédent</a> |
  <a href="./08-Conditionals.md">Suivant</a>
</div>
