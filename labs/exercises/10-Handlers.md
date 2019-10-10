# 10 - Handlers

## Présentation

On a parfois besoin d'exécuter une tâche seulement suite à un évènement ayant entrainé une modification. On peut marquer des tâches avec le mot clé `notify` afin de déclencher un `handler`lorsqu'une modification est apportée.

Un exemple courant d'utilisation de handlers est le redémarrage d'un service suite à une modification de configuration par exemple :

```yaml
---
- hosts: all
  become: True
  tasks:
    - name: "Copy sshd_config"
      copy:
        src: "sshd_config"
        dest: "/etc/"
      notify:                           # On peut spécifier plusieurs handlers sur une même tâche
        - restart sshd                  # On spécifie le nom du handler exact
  handlers:
    - name: "restart sshd"              # Il est donc obligatoire de spécifier un nom à un handler
      service:
        name: "sshd"
        state: restarted
...
```
> Plus d'informations sur les handlers : https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#handlers-running-operations-on-change

## Exercice

Vous trouverez un playbook `vhost.yml` qui déploie le fichier vhost apache `000-default.conf` sur les machines du groupe web :
  * Ajoutez un `handler` qui redémarre le service `apache2`
  * Ajoutez un `notify` à la tâche de copie qui déclenchera le `handler`

Vous pouvez valider votre modification en modifiant le port d'écoute du vhost du fichier `000-default.conf` :
```
Listen 80
<VirtualHost *:80>
[...]
```

Vous devriez ensuite être capable de faire une requête sur ce port :
```
curl http://node1:PORT
```

Une fois que vos tests sont ok, redéployez le vhost sur le port `8080` pour valider l'exercice.

<div align=center >
  <a href="./09-Loops.md">Précédent</a> |
  <a href="./11-Templates.md">Suivant</a>
</div>
