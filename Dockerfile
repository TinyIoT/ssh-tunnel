FROM ubuntu:20.04

RUN apt update && \
    apt -y install openssh-server
# RUN apt -y install fail2ban

RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash limited

COPY LICENSE .

COPY sshd_config.append .
RUN cat sshd_config.append >> /etc/ssh/sshd_config 


VOLUME /home/limited/.ssh
EXPOSE 8022

# -d run in attached mode
# -e log everything to stderr
ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]
