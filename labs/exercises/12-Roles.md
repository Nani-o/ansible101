# 12 - Roles

## Présentation

Concluons ce lab par un condensé de tout ce que nous avons vu. Afin de distribuer ainsi que de réunir des playbooks de manière logique, il est possible de créer des "packages" Ansible que l'on nomme rôle.

Il s'agit simplement d'une arborescence de fichier possédant le plus souvent son propre repository. Voici à quoi ressemble cette arborescence :

```
role ....................... Le dossier définit le nom du rôle
├── README.md .............. Il est conseillé d'avoir un README décrivant le rôle et son fonctionnement
├── defaults ............... Contient les valeurs par défaut des variables du rôle, elles sont surchargeables
│   └── main.yml
├── files .................. Contient les fichiers statiques notamment pour le module copy
├── handlers ............... Contient les handlers appelés par le rôle
│   └── main.yml
├── meta ................... Contient des infos sur le rôle et son auteur pour Ansible Galaxy (repo public de rôles)
│   └── main.yml
├── tasks .................. Contient les tâches exécutées par le rôle
│   └── main.yml
├── templates .............. Contient les fichiers templates pour le module template
├── tests .................. Contient les tests, généralement éxécutés par un CI
│   ├── inventory
│   └── test.yml
└── vars ................... Contient les variables du rôle qui ne sont pas destinées à être surchargées
    └── main.yml
```

> Tous ces dossiers sont facultatifs et à utiliser uniquement au besoin, le seul dossier obligatoire est bien évident le dossier de `tasks`.

> Par défaut ansible recherche les rôles dans le `roles` à la racine (au même niveau qu'`ansible.cfg`), il est possible de spécifier un path différent dans le fichier de configuration.

Avant de voir comment on appelle et exécute un rôle, il est à noter que dans le cadre des dossiers `tasks` et `handlers` on parle bien de `fichiers de tâches` et non de `playbook`, il n'y a pas de `play` dans un fichier de tâches, juste des tâches :

```yaml
---
- name: "task 1"
  module:
    arg1: value1
    arg2: value2

- name: "task 2"
  module:
    arg1: value1
    arg2: value2
...
```

On a donc toujours besoin d'un playbook est c'est dans celui-ci où l'on fera appel à notre rôle de cette manière :
```yaml
---
- hosts: web
  become: True
  roles:
    - apache
```

## Exercice

Pour l'exercice final, décrivons un peu plus en détail les éléments qui vous sont fournis :
  * Un dossier `roles` contenant les rôles `apache` et `php`
  * Un dossier `playbooks` contenant :
    * Un fichier `index.php`
    * Un fichier `web.yml` qui exécute les deux rôles `apache` et `php` et déploie le fichier `index.php`

Pour commencer, exécutez le playbook, plusieurs erreurs ont été commises à la fois dans le `playbook` et dans le rôle `php`, corrigez-les.

Une fois les erreurs corrigées, et le playbook exécuté, vous devriez être capable d'afficher la page web :

```console
$ curl http://nodeX
```

On rencontre une erreur puisque notre script `php` tente de se connecter en base de données, nous allons écrire un rôle `mysql` pour corriger cela :
  * Dans le fichier `roles/mysql/tasks/main.yml` on effectuera les tâches suivantes :
    * Installez via le module `apt`, les packages :
      * Le package `mysql-server`
      * Le package `python3-pymysql` pour interagir avec la db
      * Pas besoin de loop, le paramètre `name` d'`apt` accepte les `listes`
    * Démarrez le service via le module `service`
      * `mysql` doit être `started`
      * `mysql` doit être `enabled` au boot
    * Créez des bases de données via le module `mysql_db`
      * Faire une boucle sur la variable `mysql_databases` qui sera une liste contenant les noms des bases à créer
    * Créez des utilisateurs via le module `mysql_user`
      * Faire une boucle sur la variable `mysql_users` qui sera une liste contenant des dictionnaires avec les clés `user`, `password` et `priv`
      * On utilisera la variable priv pour définir les privilèges de l'utilisateur
  * Dans le fichier `roles/mysql/defaults/main.yml` on définira une liste vide `[]` comme valeur par défaut de nos deux variables
  * Ajoutez l'exécution du rôle `mysql` au playbook `app.yml`
  * Créez un inventory `group_vars` pour le groupe web avec les variables suivantes :
    * `mysql_databases` avec pour seul élément de cette liste `app`
    * `mysql_users` avec pour seul élément de cette liste le dictionnaire `{'user': 'appuser', 'password': 'notsosecure', 'priv': 'app.*:SELECT,INSERT,UPDATE,DELETE'}`

Exécutez ensuite le playbook et vérifier que notre script php se connecte correctement à notre base de données :

```console
$ ansible-playbook playbooks/app.yml
[...]
$ curl http://nodeX
```

<div align=center >
  <a href="./11-Templates.md">Précédent</a>
</div>
