# 09 - Loops

## Présentation

Un autre élément important dans la constitution d'un playbook est la possibilité d'écrire des boucles. On peut ainsi exécuter plusieurs fois une tâche avec un jeu de paramètres différents :

```yaml
- hosts: web
  tasks:

# La manière la plus simple d'utiliser une loop est de lui passer une liste
    - name: "Create groups"
      group:
        name: "{{ item }}"       # La variable de boucle est item
        state: "present"
      loop:
        - group1
        - group2

# On peut également passer une liste de dictionnaires
    - name: "Assign file permissions"
      file:
        path: "{{ item.path }}"  # On peut accéder aux éléments du dictionnaire en utilisant un point
        group: "{{ item.group }}"
      loop:
        - path: "/path/to/file1"
          group: "group1"
        - path: "/path/to/file2"
          group: "group2"
```

> Plus d'infos sur les `loops` [ici](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html)

## Exercice

Vous trouverez le playbook `playbooks/user.yml` qui déploie actuellement un utilisateur unique, adaptez le en utilisant une `loop` pour déployer les utilisateurs suivants :
  * `user1` avec l'uid `2001`
  * `user2` avec l'uid `2002`
  * `user3` avec l'uid `2003`

Exécutez ensuite le playbook.

<div align=center >
  <a href="./08-Conditionals.md">Précédent</a> |
  <a href="./10-Handlers.md">Suivant</a>
</div>
