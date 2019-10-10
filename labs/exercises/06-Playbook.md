# 06 - Playbooks

## Présentation

Jusqu'à présent nous avons pu constater le fonctionnement d'Ansible, vous savez désormais chercher un module dans la documentation et l'exécuter sur une ou des machines de votre inventaire avec un jeu de paramètre. Toute la puissance d'Ansible vient de sa capacité d'orchestration et la possibilité d'automatiser des séquences de tâches complexes potentiellement sur plusieurs noeuds à la fois.

Un playbook n'est rien de plus qu'un "script" ansible, il respecte une syntaxe particulière et est écrit en `YAML`.

Ce qu'il faut savoir sur un playbook :
  * Il commence par `---` et se termine par `...`
  * Pas de tabulation, uniquement des espaces
  * L'indentation en `YAML` est syntaxique
  * Il contient un ou plusieurs `Plays`
  * Voici une liste non exhaustive des composantes d'un `Play` :
    * `name:` le nom du play
    * `hosts:` les hôtes de l'inventaire utilisés pour ce `Play`
    * `become:` utilisation ou non de l'élévation de privilège
    * `tasks:` la liste des tâches à exécuter
    * `vars:` la définition de variables attachées à ce playbook
    * `roles:` la liste de rôles à exécuter

> INFO : Les notions de variables et rôles sont abordées plus tard

Voici un example de playbook :

```yaml
---
- name: MySQL installation        # Notre premier play débute ici avec son nom
  hosts: databases                # Il s'exécute sur les hôtes du groupe databases
  become: True                    # On passera root comme avec un -b
  tasks:                          # Notre liste de tâches à exécuter
    - name: Install mysql package # Le nom de la tâche
      apt:                        # Le module de la tâche
        name: mysql-server        # Les paramètres du module comme spécifié dans la doc du module
        state: present

    - name: Deploy mysql configuration
      copy:
        src: "my.cnf"
        dest: "/etc/my.cnf"
        owner: root
        group: root
        mode: 0644

- name: PHP installation          # On peut avoir plusieurs plays dans un seul playbook
  hosts: web
[...]
...
```

## Exercice

A partir de ces informations, dans le dossier `playbooks` écrire le playbook `apache.yml` :
  * Il s'exécutera sur les machines du groupe `web`
  * Une élévation de privilèges est nécessaire
  * On aura une tâche avec le module `apt` pour installer le package `apache2`
  * Un fichier `index.html` se trouve dans le dossier playbooks
    * Utiliser le module `copy` pour le déployer dans le dossier `/var/www/html`
    * L'utilisateur et le groupe propriétaire du fichier est `www-data`
  * Enfin avec le module `service` s'assurer que le service `apache2` est démarré et enabled au démarrage

> Aidez-vous des exemples ainsi que de la documentation des modules pour écrire le playbook

Vous pouvez valider la syntaxe de votre playbook avec la commande `ansible-playbook` :

```bash
ansible-playbook playbooks/apache.yml --syntax-check
```

Puis l'exécuter :

```bash
ansible-playbook playbooks/apache.yml
```

Vous pouvez vous assurer que le service apache est bien démarré et sert votre fichier en exécutant :

```
curl http://node1
```

<div align=center >
  <a href="./05-Modules.md">Précédent</a> |
  <a href="./07-Variables.md">Suivant</a>
</div>
