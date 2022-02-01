FROM ubuntu:20.04

RUN apt update && \
    apt -y install openssh-server
# RUN apt -y install fail2ban

RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash limited
ENV AUTHORIZED_KEYS=/home/limited/.ssh/authorized_keys

WORKDIR /home
COPY . /home

RUN cat sshd_config.append >> /etc/ssh/sshd_config 

VOLUME /home/limited/.ssh
EXPOSE 8022

ENTRYPOINT ["/home/run.sh"]