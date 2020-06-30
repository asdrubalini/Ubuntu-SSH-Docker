FROM ubuntu:20.04

RUN apt update -y
RUN apt upgrade -y

RUN apt install sudo -y

RUN useradd -ms /bin/bash user
RUN usermod -aG sudo user

WORKDIR /home/user

RUN echo "user:password" | chpasswd

RUN apt install openssh-server -y

RUN mkdir /var/run/sshd
RUN chmod 0755 /var/run/sshd

# Change ssh port
RUN sed -i "s/#Port 22/Port 2222/" /etc/ssh/sshd_config

CMD ["/usr/sbin/sshd", "-D"]
