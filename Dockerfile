FROM python:3.8-alpine

RUN apt install --no-cache git openssh-client && \
  echo "efnflasndfla" >> /etc/ssh/ssh_config

ADD *.sh /

ENTRYPOINT ["/sync.sh"]
