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

# TODO: check user and permission stuff between docker and ansible

FROM base
COPY . .
CMD ["./run.sh"]
