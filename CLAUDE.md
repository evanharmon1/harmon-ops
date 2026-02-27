# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

harmon-ops is a personal developer operations repository. It serves two purposes:
1. **Developer environment bootstrapping** - Automated setup of new macOS/Linux/Windows machines
2. **Dotfiles & configuration** - Central repository for shell configs, IDE settings, and system customizations

All scripts are designed to be **idempotent** (safe to re-run).

### Companion Repository

Infrastructure-as-code (Terraform, Ansible, Docker Compose services, cloud-init) lives in the separate **[harmon-infra](https://github.com/evanharmon1/harmon-infra)** repository. harmon-ops handles dev environment setup and dotfiles; harmon-infra handles homelab infrastructure provisioning and service deployment. The two repos reference each other — e.g., harmon-infra's Windows/WSL Docker setup docs point to `os/win/` in this repo for OS-level setup scripts.

## Common Commands

### Task Runner (go-task)
```bash
task validate     # Runs pre-commit hooks + npm checks (eslint, prettier)
task check        # Runs eslint and prettier checks
task fix          # Auto-format with eslint + prettier
task security     # Runs secrets scanning (pattern detection + whispers) + SAST (Snyk)
task secrets      # Runs secret scanning only (pattern detection + whispers)
task preCommit    # Runs pre-commit hooks only
task sast         # Runs Snyk dependency and code scans (composite of sast-dependencies + sast-code)
task bootstrap    # Installs Homebrew and Python
task install      # Runs brew bundle and pip install
task vBumpPatch   # Bump patch version, tag, and create GitHub release
task vBumpMinor   # Bump minor version, tag, and create GitHub release
task vBumpMajor   # Bump major version, tag, and create GitHub release
task ghReleaseInit # Initialize first GitHub release (v0.0.1)
task bunchAdd     # Move Bunch file to iCloud and symlink back
task obsidianAdd  # Move Obsidian note to vault and symlink back
```

### Pre-commit
```bash
pre-commit run --all-files    # Run all configured hooks
pre-commit install            # Install git hooks locally
```

### New Project Scaffolding
From `~/dev`: `newProject.sh -n nameOfProject -g gitRepoName`

## Architecture

### Directory Structure

- **`os/`** - OS-specific setup and configuration
  - `mac/` - macOS bootstrap, setup, and update scripts (primary platform)
  - `win/` - Windows setup: `setupWindows.ps1`, `updateWindows.ps1`, `CHECKLIST-WIN.md`
  - `win/wsl/` - WSL2 configuration: `.wslconfig`, `wsl.conf`, `daemon.json`, `sshd_config`, Docker Engine and NVIDIA Container Toolkit install scripts
  - `linux/` - Linux setup (minimal)
  - `docker/` - Docker Compose files (e.g., `n8n-compose/`)
  - `shell/bin/` - Utility scripts symlinked to `~/bin` (`newProject.sh`, `check_for_pattern.sh`, `getSystemInfo.sh`, `geo.sh`, etc.)
  - `shell/chezmoi/` - Chezmoi source of truth for dotfiles (declarative dotfile management)
  - `shell/dotfiles/` - Traditional dotfiles (`.aliases`, `.functions`, `.var`)
  - `shell/bash/` - Bash config (`.bashrc`)
  - `shell/zsh/` - Zsh config (`.zshrc`)
  - `languages/` - Per-language setup scripts (Python, JavaScript, Java)
  - `brew/` - Modular Brewfile templates (`Brewfile.core`, `Brewfile.apps`, `Brewfile.apps.dev`, `Brewfile.apps.gaming`, `Brewfile.apps.homelab`, `Brewfile.apps.work`, `Brewfile.optional`, `BrewfileSuperset`)
  - `git/` - Global git configuration (`.gitconfig`, `.gitignore_global`)
  - `IDEs/vscode/` - VS Code setup and settings
- **`machines/`** - Per-machine configs and Brewfiles
  - `EvansMacBookPro/`, `mac-server/`, `MacMini2014/`, `MacMini2018/`, `sharons-mac-mini/` - Mac machines
  - `contraption/`, `tars/` - Windows 11 Pro PCs (with WSL2 Docker)
  - `unraidContraption/`, `unraidMachina/` - Unraid servers
- **`infra/`** - Legacy/placeholder infrastructure configs (e.g., Pi-hole config for contraption)
- **`test/`** - Whispers secret detection config
- **`docs/`** - Additional documentation
- **`.meta/`** - Project metadata (Bunch files, Obsidian notes)

### Dotfile Management

Two complementary systems:
- **Chezmoi** (`os/shell/chezmoi/`) - Declarative source of truth for shell dotfiles, stored in this repo
- **Mackup** - Backs up shell dotfiles and Mac app preferences to iCloud

### Mac Setup Flow

The macOS setup follows a layered workflow, run from `os/mac/`:
1. **`bootstrapMac.sh`** - Initial setup (hostname, Xcode CLI tools, Homebrew install, copy Brewfile)
2. **`setupMac.sh`** - Full environment setup (brew bundle, directories, languages, fonts, oh-my-zsh, mackup restore)
3. **`updateMac.sh`** - Ongoing maintenance (brew update/upgrade, chezmoi, language updates, cleanup)
4. **`configureMacSettings.sh`** - macOS system preferences via terminal commands

Run with caffeinate to prevent sleep: `caffeinate -disu zsh -x ./setupMac.sh 2>&1 | tee -a ~/.log/setupMac.sh.log`

### Windows Setup Flow

Windows setup scripts live in `os/win/`:
1. **`CHECKLIST-WIN.md`** - Manual steps (BIOS, drivers, Windows settings)
2. **`setupWindows.ps1`** - PowerShell setup script (package installation, configuration)
3. **`updateWindows.ps1`** - Ongoing maintenance

WSL2 configuration in `os/win/wsl/`:
- **`wsl.conf`** / **`.wslconfig`** - WSL2 distro and global settings (mirrored networking, resource limits)
- **`daemon.json`** - Docker Engine configuration (overlay2, NVIDIA runtime, BuildKit, address pools, log rotation)
- **`sshd_config`** - SSH server config (port 2222 to avoid Windows intercepting port 22)
- **`installDockerEngine.sh`** - Installs Docker Engine CE in WSL2 (not Docker Desktop)
- **`installNvidiaContainerToolkit.sh`** - Installs NVIDIA Container Toolkit for GPU workloads

Machine-specific Windows checklists also exist under `machines/<hostname>/CHECKLIST-WIN.md`.

### Machine-Specific Configuration

Each machine gets a directory under `machines/<hostname>/` containing its Brewfile and/or checklist. The `os/brew/BrewfileSuperset` serves as the master template from which machine-specific Brewfiles are derived.

## CI/CD

GitHub Actions workflows in `.github/workflows/`:
- **validate.yml** - Runs pre-commit and npm checks on pull requests
- **security.yml** - Runs pattern detection, whispers secret scanning, and Snyk SAST on pull requests
- **build.yaml** - Runs Node.js build test on PRs and pushes to main
- **release.yml** - Auto-bumps patch version and creates GitHub release on pushes to main

Note: Legacy `.yaml` versions of validate and security workflows also exist alongside the updated `.yml` versions.

## Linting and Validation

Pre-commit hooks handle all linting (`.pre-commit-config.yaml`):
- **shell-lint** (`pre-commit-shell`) - Shell script linting via ShellCheck (severity: error, excludes SC3037/SC2148)
- **Black** - Python formatting
- **Terraform** - fmt, docs, checkov, infracost (vestigial — no `.tf` files in this repo; Terraform code lives in harmon-infra)
- **Ansible-lint** - Playbook validation (vestigial — no Ansible playbooks in this repo; Ansible code lives in harmon-infra)
- **yamllint** - YAML linting
- General checks: YAML, JSON, TOML, XML validation; private key detection; merge conflict markers; no direct commits to main branch

Additional linting via `package.json`:
- **ESLint** and **Prettier** - JavaScript/general formatting

## Key Tools

- **Homebrew + brew bundle** - Package management via modular Brewfiles
- **mackup** - Backs up and restores app configs/dotfiles via iCloud
- **chezmoi** - Declarative dotfile management (source of truth in `os/shell/chezmoi/`)
- **copier** - Project templating (`.copier-answers.yml`)
- **mise** - Runtime version management
- **whispers** - Secret/credential detection
- **Snyk** - Dependency and code vulnerability scanning
- **go-task** - Task runner (`Taskfile.yml`)
