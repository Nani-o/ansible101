# 02 - Fichier de configuration

## Présentation

Le fichier de configuration Ansible permet de définir le comportement d'Ansible dans un fichier ini. Par défaut ansible charge le fichier ansible.cfg dans le dossier courant, il est une bonne pratique de le placer à la racine d'un projet et d'exécuter les commandes depuis cette même racine.

Vous pouvez voir qu'un fichier ansible.cfg a déjà été créé pour vous, vous pouvez inspecter son contenu :

```bash
$ cat ansible.cfg
[defaults]
stdout_callback = yaml
connection = smart
timeout = 60
deprecation_warnings = False
host_key_checking = False
retry_files_enabled = False
```

Il s'agit ici uniquement de paramètres afin d'améliorer l'utilisation d'ansible, on peut aussi y placer des paramètres afin d'éviter d'avoir à les placer sur la ligne de commande.

> Vous trouverez la liste complètes des valeurs possible ici : https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-configuration-settings-locations

## Exercice

Dans l'exercice précèdent, nous avons utilisé le flag `-i` afin d'indiquer le path vers notre dossier d'inventaire.

Ajoutez une entrée au fichier `ansible.cfg` avec comme clé `inventory` et comme valeur le chemin vers notre fichier d'inventaire.

> Lorsque le projet est pensé pour être exécuter depuis la racine, il convient d'utiliser des chemins relatifs pour la portabilité.

Vous pouvez maintenant réexécuter les commandes de l'exercice précèdent sans le flag `-i` :

```bash
ansible@ansible ~/ansible101 $ ansible web --list-hosts
  hosts (3):
    node1
    node2
    node3
ansible@ansible ~/ansible101 $ ansible web,ansible --list-hosts
  hosts (4):
    node1
    node2
    node3
    ansible
```
<div align=center >
  <a href="./01-Inventaire.md">Précédent</a> |
  <a href="./03-Ping.md">Suivant</a>
</div>
