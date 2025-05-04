#!/usr/bin/env sh

ansible-playbook ${TAGS:+--tags $TAGS} playbook.yaml

