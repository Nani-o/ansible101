# 01 - Fichier d'inventaire

## Présentation

Afin de pouvoir travailler avec Ansible, nous avons besoin d'un fichier d'inventaire qui va venir lister les noeuds distants sur lesquels nous pourrons interagir. Le fichier d'inventaire est un simple fichier `TOML`, les sections sont des groupes Ansible et chaque ligne est un host qui peut être accompagné de variables.

Voici un exemple de fichier d'inventaire :

```ini
[group1]
host1   ansible_host=1.1.1.1
host2   ansible_host=2.2.2.2

[group2]
host3   ansible_host=3.3.3.3
```

> Plus d'informations sur les inventaires Ansible : https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html

## Exercice

A partir des informations mises à disposition dans l'introduction, rédigez un fichier pour nos machines comme suit :
  * Rédigez votre fichier d'inventaire dans `./inventory`
  * La machine ansible appartient au groupe `controller`
  * Les machines node[1-3] appartiennent au groupe `web`

Pour rappel la liste des machines :

| Host       | ip           |
| ---------- |:------------:|
| ansible    | 10.0.101.123 |
| node1      | 10.0.101.10  |
| node2      | 10.0.101.20  |
| node3      | 10.0.101.30  |

Vous pouvez maintenant utiliser les commandes pour lister les hosts :
```bash
ansible@ansible ~/ansible101 $ ansible web -i inventory --list-hosts
  hosts (3):
    node1
    node2
    node3
ansible@ansible ~/ansible101 $ ansible web,ansible -i inventory --list-hosts
  hosts (4):
    node1
    node2
    node3
    ansible
```

<div align=center >
  <a href="./00-Introduction.md">Précédent</a> |
  <a href="./02-Configuration.md">Suivant</a>
</div>
