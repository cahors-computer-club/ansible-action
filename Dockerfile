FROM alpine:latest

MAINTAINER Quentin POIRIER <quentin.poirier@opus-solutions.eu>


RUN echo "===> Installing sudo to emulate normal OS behavior..."  && \
    apk --update add sudo                                         && \
    \
    \
    echo "===> Adding Python runtime..."  && \
    apk --update add python3 py3-pip openssl ca-certificates    && \
    apk --update add --virtual build-dependencies \
                python-dev openssl-dev build-base  && \
    pip3 install --upgrade pip3 cffi                            && \
    \
    \
    echo "===> Installing Ansible..."  && \
    pip3 install ansible                && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    pip3 install --upgrade pycrypto pywinrm         && \
    apk --update add sshpass openssh-client rsync  && \
    \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
