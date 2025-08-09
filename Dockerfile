FROM ubuntu:noble AS base

WORKDIR /usr/local/bin

# prevent apt from asking for input
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential ca-certificates && \
	update-ca-certificates && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
	ansible-galaxy collection install community.general

# TODO: check user and permission stuff between docker and ansible

FROM base
COPY . .
RUN ansible-playbook ./playbook.yaml --check
CMD [""]
