FROM ubuntu:focal AS base

WORKDIR /usr/local/bin

# prevent apt from asking for input
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS ansible

ARG TAGS
RUN addgroup --gid 1000 normaluser
RUN adduser --gecos normaluser --uid 1000 --gid 1000 --disabled-password normaluser
USER normaluser
WORKDIR /home/normaluser

FROM ansible
COPY . .
CMD ["sh", "-c", "ansible-playbook ${TAGS:+--tags $TAGS} playbook.yaml"]