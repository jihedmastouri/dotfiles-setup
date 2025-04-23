TAGS := $(TAGS)

PHONY: install-docker-fedora
install-docker-fedora:
	@sudo dnf upgrade -y --refresh
	@sudo dnf update -y
	@sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine
	@sudo dnf -y install dnf-plugins-core
	@sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	@sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	@sudo systemctl enable --now docker

PHONY: install-docker-ubuntu
install-docker-ubuntu:
	@for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
	@sudo apt-get update
	@sudo apt-get install ca-certificates curl
	@sudo install -m 0755 -d /etc/apt/keyrings
	@sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	@sudo chmod a+r /etc/apt/keyrings/docker.asc
	@echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	@sudo apt-get update
	@sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

PHONY: build
build:
	@docker build -t ansible-docker .

PHONY: run
run:
	@docker run -it --rm \
  		--privileged \
  		-e TAGS="$(TAGS)" \
  		ansible-docker