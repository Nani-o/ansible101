# 05 - Modules

## Présentation

Nous avons déjà découvert deux modules, il en existe des centaines et il est possible d'écrire ses propres modules. Vous pouvez voir la liste des différents modules inclus dans Ansible ainsi que leur documentation à cette [adresse](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html). Il est également possible d'utiliser la commande `ansible-doc` comme ceci :

```console
$ ansible@ansible ~/ansible101 $ ansible-doc -l           # Permet de lister les modules ansible
$ ansible@ansible ~/ansible101 $ ansible-doc <module>     # Affichier la documentation d'un module
```

## Exercice

En utilisant la documentation :
  * Trouvez le module qui permet d'installer des packages via `APT`
  * Installez le package `htop` en version `latest` sur les machines du groupe web
  * On souhaite également mettre à jour le cache d'`apt`, trouvez et utilisez l'option le permettant
  * Il faut utiliser le flag `-a` pour passer les paramètres au module comme ceci :
    `ansible -m module -a "param1=value1 param2=value2" host`

Une fois terminé vous pouvez vérifier en effectuant :
```console
$ ansible@ansible ~/ansible101 $ ssh node3 -t "htop"
# Appuyez sur q pour quitter
```
<div align=center >
  <a href="./04-Become.md">Précédent</a> |
  <a href="./06-Playbook.md">Suivant</a>
</div>
