# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

harmon-ops is a personal developer operations and homelab infrastructure repository. It serves three purposes:
1. **Developer environment bootstrapping** - Automated setup of new macOS/Linux/Windows machines
2. **Homelab infrastructure** - Documentation, diagrams, and IaC for personal infrastructure
3. **Dotfiles & configuration** - Central repository for shell configs, IDE settings, and system customizations

All scripts are designed to be **idempotent** (safe to re-run).

## Common Commands

### Task Runner (go-task)
```bash
task validate     # Runs pre-commit hooks on all files, then snyk
task security     # Runs pattern detection, whispers secret scanning, then snyk
task snyk         # Runs snyk vulnerability scan on Python requirements
```

### Pre-commit
```bash
pre-commit run --all-files    # Run all configured hooks
pre-commit install            # Install git hooks locally
```

### Setup Prerequisites
```bash
brew install go-task/tap/go-task
brew install pre-commit        # or: pip install pre-commit
```

### New Project Scaffolding
From `~/dev`: `newProject.sh -n nameOfProject -g gitRepoName`

## Architecture

### Directory Structure

- **`os/`** - OS-specific setup and configuration (README.md references this as `osConfig/`)
  - `mac/` - macOS bootstrap, setup, and update scripts (primary platform)
  - `linux/`, `win/` - Less-developed platform support
  - `shell/bin/` - Utility scripts symlinked to `~/bin`
  - `languages/` - Per-language setup scripts (Python, JavaScript, Java, etc.)
  - `brew/BrewfileSuperset` - Master Homebrew package template
  - `git/` - Global git configuration
  - `IDEs/` - IDE setup (VS Code)
- **`machines/`** - Per-machine configs and Brewfiles
  - Machine-specific directories (e.g., `EvansMacBookPro/`, `MacMini2014/`) with Brewfiles
- **`test/`** - Whispers secret detection config
- **`docs/`** - Additional documentation

### Mac Setup Flow

The macOS setup follows a layered workflow, run from `os/mac/`:
1. **`bootstrapMac.sh`** - Initial setup (hostname, Xcode CLI tools, Homebrew install, copy Brewfile)
2. **`setupMac.sh`** - Full environment setup (brew bundle, directories, languages, fonts, oh-my-zsh, mackup restore)
3. **`updateMac.sh`** - Ongoing maintenance (brew update/upgrade, language updates, cleanup)
4. **`configureMacSettings.sh`** - macOS system preferences via terminal commands

Run with caffeinate to prevent sleep: `caffeinate -disu zsh -x ./setupMac.sh 2>&1 | tee -a ~/.log/setupMac.sh.log`

### Machine-Specific Configuration

Each machine gets a directory under `machines/<hostname>/` containing its Brewfile and checklist. The `os/brew/BrewfileSuperset` serves as the master template from which machine-specific Brewfiles are derived.

## CI/CD

GitHub Actions workflows in `.github/workflows/`:
- **validate.yaml** - Runs pre-commit on pull requests
- **security.yaml** - Runs pattern detection and whispers secret scanning

## Linting and Validation

Pre-commit hooks handle all linting (`.pre-commit-config.yaml`):
- **ShellCheck** - Bash script linting (severity: error)
- **Black** - Python formatting
- **Terraform** - fmt, docs, checkov, infracost
- **Ansible-lint** - Playbook validation
- General checks: YAML, JSON, TOML, XML validation; private key detection; merge conflict markers; no direct commits to main branch

## Key Tools

- **mackup** - Backs up and restores app configs/dotfiles via iCloud
- **Homebrew + brew bundle** - Package management via Brewfiles
- **whispers** - Secret/credential detection
- **Snyk** - Dependency vulnerability scanning
