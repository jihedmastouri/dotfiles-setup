# Auto Setup

_New Pc? No prob!_

Using `ansible` and `docker` to spin up my Linux work environment.

## Prerequisites

- Ansible
- Docker
- Make

## Usage

```sh
make build && make run
```

## Ansible Tags

- `core`: essential system packages and tools
- `dev`: development languages and tools
- `flatpak`
- `gui`
- `config`
- `install`

> Check out my dotfiles' [repo](https://github.com/jihedmastouri/dotfiles) (aka configs).
