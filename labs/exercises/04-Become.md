# 04 - Elevation de privilèges

## Présentation

L'exercice précédent nous a fait utiliser le flag `-b/--become`, ce flag permet de demander une élévation de privilèges. Par défaut les commandes que vous effectuez sont exécutées avec votre utilisateur courant, à savoir `ansible`, essayons par exemple la commande suivante :

```bash
ansible -m copy -a "content='Bienvenue sur {{ inventory_hostname }}\n' dest=/etc/motd" web
```

Vous vous retrouvez avec cette erreur :

```bash
node1 | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "checksum": "d6a3dd4e4741951af34f73af949f538c4b9bbb47",
    "msg": "Destination /etc not writable"
}
[...]
```

Comme mentionné ici, nous n'avons pas les droits nécessaires pour écrire dans le dossier `/etc`, en utilisant le flag `-b/--become`, on instruit ansible :
  * D'utiliser une méthode d'élévation de privilège, `sudo` par défaut, on peut spécifier une autre méthode grâce à `--become-method`
  * vers un utilisateur avec privilèges, `root` par défaut, on peut spécifier un autre utilisateur grâce à `--become-user`

## Exercice

Réexécutez la commande pour qu'elle s'exécute avec l'utilisateur root :

```console
$ ansible -m copy -a "content='Bienvenue sur {{ inventory_hostname }}\n' dest=/etc/motd" web -b
node1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "checksum": "6b428fbbd7718a445b2e4184621aed4a58b77358",
    "dest": "/etc/motd",
    "gid": 0,
    "group": "root",
    "md5sum": "9dbab2b01561f1320b5509ed1fc0369e",
    "mode": "0644",
    "owner": "root",
    "size": 20,
    "src": "/home/ansible/.ansible/tmp/ansible-tmp-1571928453.6924605-126702763770382/source",
    "state": "file",
    "uid": 0
}
[...]
```

L'output des commandes ansible est jaune, tandis que l'on peut voir `CHANGED` dans le rapport de chaque host. Exécutez de nouveau la commande :

```console
$ ansible -m copy -a "content='Bienvenue sur {{ inventory_hostname }}\n' dest=/etc/motd" web -b
node1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "checksum": "d6a3dd4e4741951af34f73af949f538c4b9bbb47",
    "dest": "/etc/motd",
    "gid": 0,
    "group": "root",
    "mode": "0644",
    "owner": "root",
    "path": "/etc/motd",
    "size": 20,
    "state": "file",
    "uid": 0
}
[...]
```

Cette fois-ci on constate que l'output de la commande est verte et le mot clé associé à l'état de sortie du module est maintenant `SUCCESS`. On voit ici le caractère idempotent des modules ansible (avec quelques exceptions), un module n'effectuera de changements que si nécessaire, il n'est donc pas dangereux de réexécuter plusieurs fois la même commande.

<div align=center >
  <a href="./03-Ping.md">Précédent</a> |
  <a href="./05-Modules.md">Suivant</a>
</div>
