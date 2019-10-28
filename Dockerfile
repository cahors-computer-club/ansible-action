FROM alpine:latest

MAINTAINER Quentin POIRIER <quentin.poirier@opus-solutions.eu>

ENV PYTHONUNBUFFERED=1

RUN echo "===> Installing sudo to emulate normal OS behavior..." && \
    apk --update add sudo && \
    echo "===> Adding Python runtime..." && \
    apk --update add python3 openssl ca-certificates && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    apk --update add --virtual build-dependencies python3-dev openssl-dev build-base libffi-dev && \
    python3 --version && \
    pip3 --version && \
    pip3 install --upgrade cffi && \
    echo "===> Installing Ansible..." && \
    pip3 install ansible && \
    echo "===> Installing handy tools (not absolutely required)..." && \
    pip3 install --upgrade pycrypto pywinrm && \
    apk --update add sshpass openssh-client rsync && \
    echo "===> Removing package list..." && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    echo "===> Adding hosts for convenience..." && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
