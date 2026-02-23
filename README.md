# Harmon Ops
Various scripts, dotfiles, and automation for my developer environment and homelab infrastructure.

[Harmon Ops](https://harmonlab.net)

Author: Evan Harmon

[![Netlify Status](https://api.netlify.com/api/v1/badges/addYourNetlifySiteIdHere/deploy-status)](https://app.netlify.com/sites/harmon-ops/deploys)
[![Validate](https://github.com/evanharmon1/harmon-ops/actions/workflows/validate.yml/badge.svg)](https://github.com/evanharmon1/harmon-ops/actions/workflows/validate.yml)
[![Build](https://github.com/evanharmon1/harmon-ops/actions/workflows/build.yml/badge.svg)](https://github.com/evanharmon1/harmon-ops/actions/workflows/build.yml)
[![Security](https://github.com/evanharmon1/harmon-ops/actions/workflows/security.yml/badge.svg)](https://github.com/evanharmon1/harmon-ops/actions/workflows/security.yml)
[![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)
[![Maintained](https://img.shields.io/badge/maintained%3F-yes-brightgreen.svg?style=flat-square)](https://github.com/evanharmon1/harmon-ops)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/evanharmon1/harmon-ops)
[![Known Vulnerabilities](https://snyk.io/test/github/evanharmon1/harmon-ops/badge.svg?style=flat-square)](https://snyk.io/test/github/evanharmon1/harmon-ops)

## Setup & Installation

### Requirements
- Homebrew
- Python
- [Taskfile](https://taskfile.dev/)

### Bootstrap
Install required software to run other project installers and task runners
`task bootstrap`

### Install
Install required dependencies
`task install`

## Usage
TODO: project usage

### Task Runner
[Taskfile.yaml](./Taskfile.yml)

### Testing

#### Validate
`task validate`

#### Security
`task security`

#### Linting, Formatting, Conventions, Style Guidelines, etc
- .pre-commit-config.yaml
- .shellcheckrc
- .ansible-lint-ignore

### Building, Deploying, & CI/CD

## Todo File
[todo.md](./todo.md)
