FROM ubuntu:16.04

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y systemd systemd-cron \
                          sudo iproute2 \
                          libffi-dev libssl-dev \
                          python3 python3-pip python3-dev \
                          ruby locales curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount \
    systemd-logind.service getty.service getty.target

RUN pip3 install ansible testinfra pytest Pygments \
    && gem install mdless

COPY docker/setup.yml /tmp/
COPY labs /tmp/labs
COPY workdir /tmp/workdir

RUN ansible-playbook /tmp/setup.yml -e "image=controller" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt -y autoremove

RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.UTF-8

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
