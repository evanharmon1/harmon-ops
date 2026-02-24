# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

harmon-ops is a personal developer operations repository. It serves two purposes:
1. **Developer environment bootstrapping** - Automated setup of new macOS/Linux/Windows machines
2. **Dotfiles & configuration** - Central repository for shell configs, IDE settings, and system customizations

All scripts are designed to be **idempotent** (safe to re-run).

## Common Commands

### Task Runner (go-task)
```bash
task validate     # Runs pre-commit hooks + npm checks (eslint, prettier)
task security     # Runs secrets scanning (pattern detection + whispers) + SAST (Snyk)
task preCommit    # Runs pre-commit hooks only
task sast         # Runs Snyk dependency and code scans
task bootstrap    # Installs Homebrew and Python
task install      # Runs brew bundle and pip install
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
  - `linux/`, `win/` - Less-developed platform support
  - `shell/bin/` - Utility scripts symlinked to `~/bin`
  - `shell/chezmoi/` - Chezmoi source of truth for dotfiles (declarative dotfile management)
  - `shell/dotfiles/` - Traditional dotfiles (`.aliases`, `.functions`, `.var`)
  - `languages/` - Per-language setup scripts (Python, JavaScript, Java)
  - `brew/` - Modular Brewfile templates (`Brewfile.core`, `Brewfile.apps`, `Brewfile.apps.dev`, `Brewfile.apps.gaming`, `Brewfile.apps.homelab`, `Brewfile.apps.work`, `Brewfile.optional`, `BrewfileSuperset`)
  - `git/` - Global git configuration (`.gitconfig`, `.gitignore_global`)
  - `IDEs/vscode/` - VS Code setup and settings
- **`machines/`** - Per-machine configs and Brewfiles
  - Machine-specific directories (e.g., `EvansMacBookPro/`, `mac-server/`, `MacMini2014/`) with Brewfiles and checklists
- **`test/`** - Whispers secret detection config
- **`docs/`** - Additional documentation
- **`.meta/`** - Project metadata (Bunch files)

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

### Machine-Specific Configuration

Each machine gets a directory under `machines/<hostname>/` containing its Brewfile and checklist. The `os/brew/BrewfileSuperset` serves as the master template from which machine-specific Brewfiles are derived.

## CI/CD

GitHub Actions workflows in `.github/workflows/`:
- **validate.yml** - Runs pre-commit and npm checks on pull requests
- **security.yml** - Runs pattern detection, whispers secret scanning, and Snyk SAST on pull requests
- **build.yaml** - Runs Node.js build test on PRs and pushes to main
- **release.yml** - Auto-bumps patch version and creates GitHub release on pushes to main

Note: Legacy `.yaml` versions of validate and security workflows also exist alongside the updated `.yml` versions.

## Linting and Validation

Pre-commit hooks handle all linting (`.pre-commit-config.yaml`):
- **ShellCheck** - Bash script linting (severity: error)
- **Black** - Python formatting
- **Terraform** - fmt, docs, checkov, infracost
- **Ansible-lint** - Playbook validation
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
