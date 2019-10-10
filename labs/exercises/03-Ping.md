# 03 - Ping Pong

## Présentation

Le principe même d'Ansible est d'envoyer un script contenant les instructions que l'on souhaite faire effectuer à notre cible, puis en récolter les résultats. Le module le plus basique d'Ansible est le module `ping` qui va simplement s'assurer que l'hôte est accessible via son type de connexion (ssh par défaut, mais il en existe d'autre comme docker) mais également qu'il est en capacité d'exécuter des modules Ansible, à savoir la présence d'un interpréteur Python. Ce sont les deux seuls prérequis à l'utilisation d'Ansible sur une machine cible, avoir un accès à la machine et Python.

La commande `ansible` que nous avons utilisée tout à l'heure, permet d'exécuter de manière unitaire des modules Ansible depuis la ligne de commande, contrairement à un playbook (un script ansible en quelque sorte). Pour cela il faut utiliser le flag `-m` afin de spécifier à ansible le module que l'on souhaite utiliser, dans notre cas `ping`, des paramètres supplémentaires peuvent être passés au module via le flag `-a` mais ce n'est pas le cas du module `ping`.

```console
$ ansible -m module -a "param1=value1 param2=value2" host
```

Exécutez la commande :

```console
ansible@ansible ~/ansible101 $ ansible -m ping web
 [WARNING]: No python interpreters found for host node3 (tried ['/usr/bin/python', 'python3.7', 'python3.6', 'python3.5', 'python2.7', 'python2.6', '/usr/libexec/platform-
python', '/usr/bin/python3', 'python'])

node3 | FAILED! => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "module_stderr": "Shared connection to 10.0.101.30 closed.\r\n",
    "module_stdout": "/bin/sh: 1: /usr/bin/python: not found\r\n",
    "msg": "The module failed to execute correctly, you probably need to set the interpreter.\nSee stdout/stderr for the exact error",
    "rc": 127
}
node1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
node2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

On s'aperçoit que python est absent de la machine `node3`, nous pourrions nous connecter en ssh et installer le package `python3`, nous pouvons aussi utiliser le module `raw` d'ansible qui ne nécessite pas python afin de le faire à distance.

## Exercice

Afin de remédier à cette situation, effectuez une commande Ad-Hoc pour installer python à partir des informations suivantes :
  * Utilisez le module `raw` dont la documentation est disponible ici : https://docs.ansible.com/ansible/latest/modules/raw_module.html
  * Utilisez le flag `-a` afin de fournir la commande à exécuter, à savoir : `apt -y update ; apt -y install python3`
  * Utilisez le flag `-b` permettant l'élévation de privilège en root (sudo password-less est déjà configuré sur les machines, pas besoin de saisir de mot de passe)
  * La commande doit être appliquée à l'host `node3`
  * Utilisez la commande `ansible --help` si besoin

Une fois python3 installé, vous devriez être en mesure de ping le node3 :
```bash
ansible@ansible ~/ansible101 $ ansible -m ping node3
node3 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
<div align=center >
  <a href="./02-Configuration.md">Précédent</a> |
  <a href="./04-Become.md">Suivant</a>
</div>
