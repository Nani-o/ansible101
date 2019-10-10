FROM ubuntu:16.04

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y systemd systemd-cron \
                          sudo iproute2 \
                          libffi-dev libssl-dev \
                          language-pack-fr \
                          python3 python3-pip python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount \
    systemd-logind.service getty.service getty.target

COPY docker/setup.yml /tmp/

RUN pip3 --no-cache-dir install wheel ansible testinfra pytest \
    && ansible-playbook /tmp/setup.yml -e "image=node" \
    && pip3 uninstall -y wheel ansible testinfra pytest \
    && apt-get remove -y python3-pip python3-dev libffi-dev libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt -y autoremove

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
