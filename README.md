<img alt="Docker Cloud Build Status" src="https://img.shields.io/docker/cloud/build/nanio/ansible101">

# ansible101
An ansible workshop that runs in docker.

## Introduction
This repository contains a script that will setup an interactive workshop environment in Docker. With the command `lab` you will be able to navigate through the different exercises and asks for an interactive correction that will check if you passed or not.

## Prerequisite
The only thing you need to run this workshop is Docker, so you need to :
  * Have Docker installed and running
  * Have an user that is able to run `docker` commands

If it's not the case, head to this [link](https://docs.docker.com/v17.09/engine/installation/) and choose the correct way to install docker depending on your OS.

## Starting
Once all prerequisite are met, you can then clone this repo and start the workshop :

```bash
$ git clone https://github.com/Nani-o/ansible101/
$ cd ansible101
$ ./ansible101 start
```
This script will deploy 4 containers, `1 controller` in which you'll be automatically connected, and from where you gonna do this workshop. And also `3 nodes` on which you gonna execute Ansible to solve exercises.

A `lab` command is at your disposal in the controller container in order to navigate the workshop (`lab help` to see all available commands).

The exercises are directly displayed in your terminal using `mdless`, but you can read the [markdown version](./labs/exercises) in your viewer of choice.

If for whatever reason you are disconnected from the workshop, you can login again with `./ansible101 start`.
