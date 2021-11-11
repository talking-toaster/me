FROM python:3.8-slim-buster

RUN apt install --no-cache git openssh-client && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /

ENTRYPOINT ["/sync.sh"]
