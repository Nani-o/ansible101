# 00 - Introduction

Ce lab a pour but de vous familiariser avec Ansible, son mécanisme de module et les commandes Ad-Hoc. Les commandes Ad-Hoc vous permettent d'exécuter des modules Ansible sans écrire de "scripts" Ansible (playbooks).

Afin de vous permettre de vous concentrer sur Ansible et non le déploiement d'un environnement d'apprentissage, les containers dockers suivants ont été déployés :

| Host       | ip           |
| ---------- |:------------:|
| ansible    | 10.0.101.123 |
| node1      | 10.0.101.10  |
| node2      | 10.0.101.20  |
| node3      | 10.0.101.30  |

Vous vous trouvez actuellement dans le container `ansible`, il s'agit d'un noeud avec tout ce qu'il faut pour vous permettre de réaliser les différents exercices. Si jamais vous êtes déconnecté pour une raison ou une autre hors de ce container, vous pouvez revenir là où vous en étiez en réexécutant :

```console
[user@host] - ansible101/ $ ./ansible101 start
```
Dans l'environnement de lab, vous avez à disposition une commande `lab` qui va vous permettre de naviguer à travers les différents exercices. Voici les commandes disponibles :
```console
Description:
  Ce script permet de charger un exercice et l'environnement associé

Usage:
  lab [command]

Available Commands:
  [lab_number]         Charge le lab passé en argument
  help                 Affiche cette aide
  check                Effectue la validation de l'exercice en cours
  status               Affiche le statut et l'énoncé si un exercice est en cours
  next                 Charge l'exercice suivant
  prev                 Charge l'exercice précédent
  list                 Affiche la liste des exercices
```

Vous pouvez afficher cette aide à tout moment avec la commande `lab help`.

Une fois un exercice terminé, vous pouvez valider votre solution en exécutant la commande `lab check`.

Lorsque vous êtes prêt, vous pouvez passer à l'exercice suivant avec la commande `lab next`.

<div align=center >
  <a href="./01-Inventaire.md">Suivant</a>
</div>
