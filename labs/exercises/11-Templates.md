# 11 - Templates

## Présentation

Nous allons continuer à explorer les possibilités offertes par les variables dans Ansible, il est possible via Ansible d'écrire des fichiers de template Jinja2. Le module le permettant se nomme tout simplement [template](https://docs.ansible.com/ansible/latest/modules/template_module.html) et permet de générer et déployer un fichier à partir d'un fichier de template local.

Voyons immédiatement un exemple de fichier de template, à partir de ce fichier de variables :

```yaml
dns_nameservers:
  - 172.16.100.127
  - 172.16.100.128
dns_search_domains:
  - local
  - company.com
```

On pourrait écrire un fichier de template pour `/etc/resolf.conf` :

```yaml
{% for nameserver in dns_nameservers %}    # Ici on boucle sur notre liste
nameserver {{ nameserver }}                # On peut remplacer
{% endfor %}
search{% for search_domain in dns_search_domains %} {{ search_domain }}{% endfor %}
```

Que l'on exécuterait à partir de ce fichier de playbook :

```yaml
---
- hosts: web
  become: True
  tasks:
    - name: "Deploy resolv.conf"
      template:
        src: "resolv.conf.j2"
        dest: "/etc/resolv.conf"
...
```

Qui générerait le fichier resolv.conf suivant :

```
nameserver 172.16.100.127
nameserver 172.16.100.128
search local company.com
```

## Exercice

Le but de l'exercice va être de déployer un `prompt` différent sur chacune de nos machines. Vous trouverez un playbook qui déploie actuellement un fichier `.bash_profile` statique :
  * Créez des `host_vars` dans l'inventaire de tel manière que :
    * `node1` a une variable `color` avec pour valeur `blue`
    * `node2` a une variable `color` avec pour valeur `magenta`
    * `node3` a une variable `color` avec pour valeur `cyan`
  * Templatisez le fichier `.bash_profile`, on souhaite variabiliser la couleur du host (à savoir green actuellement) avec la variable `color`
  * Modifiez le playbook `prompt.yml` de façon à utiliser le module `template` plutôt que `copy`

Vous pouvez vérifier votre déploiement en vous connectant en ssh sur chaque noeud.

<div align=center >
  <a href="./10-Handlers.md">Précédent</a> |
  <a href="./12-Roles.md">Suivant</a>
</div>
