FROM alpine:3.12

ARG key

RUN apk add --no-cache \
  openssh \
  git

RUN adduser -D -s /bin/ash git \
  && echo git:12345 | chpasswd

RUN ssh-keygen -A

WORKDIR /home/git

RUN mkdir git-shell-commands \
  && chmod 755 git-shell-commands \
  && export PATH=/home/git/git-shell-commands:$PATH

RUN mkdir .ssh \
  && echo $key > .ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]