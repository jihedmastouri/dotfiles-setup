FROM ubuntu:noble AS base

WORKDIR /usr/local/bin

# prevent apt from asking for input
ENV DEBIAN_FRONTEND=noninteractive

# Install Deps
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

# second stage
FROM base

# Create non-root user
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

# Change ownership to non-root user
RUN chown appuser:appgroup server

# Switch to non-root user
USER appuser

COPY . .

# Validate playbook
RUN ansible-playbook ./playbook.yaml --check

CMD [""]
