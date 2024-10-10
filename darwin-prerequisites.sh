#!/usr/bin/env bash

################################################################################
# Script: darwin_prerequisites.sh
# Description: This script sets up the prerequisites for running Ansible on macOS,
#              including the installation of Xcode Command Line Tools, Homebrew,
#              pipx, and Ansible, along with additional dependencies. Provides
#              visual feedback during the installation process.
# Author: apppv
# Date: 12.09.2024
# Last Modified: 08.10.2024
# Version: 0.2.0
################################################################################

set -euo pipefail

function print_good() {
    echo -e "\x1B[01;32m[✅]\x1B[0m $1"
}

function print_error() {
    echo -e "\x1B[01;31m[❌]\x1B[0m $1"
}

function print_info() {
    echo -e "\x1B[01;34m[💡]\x1B[0m $1"
}

# Check if Xcode Command Line Tools are already installed
if ! xcode-select -p &>/dev/null; then
    print_info "Installing Xcode Command Line Tools"
    xcode-select --install
    printf "\e[1;34mPress any key once the installation is complete...\e[0m\n"
    read -r -n 1
else
    print_good "Xcode Command Line Tools are already installed"
fi

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)" # Add Homebrew to the shell path
    print_good "Homebrew installed successfully"
else
    print_good "Homebrew is already installed"
fi

# Install pipx using Homebrew
if ! command -v pipx &>/dev/null; then
    print_info "Installing pipx..."
    brew install pipx
    sudo pipx ensurepath --global
    print_good "pipx installed successfully"
else
    print_good "pipx is already installed"
fi

# Install Ansible through pipx
if ! pipx list | grep -q 'ansible'; then
    print_info "Installing Ansible..."
    pipx --global install --include-deps ansible
    pipx --global inject --include-apps ansible argcomplete watchdog
    print_good "Ansible installed successfully"
else
    print_good "Ansible is already installed"
fi

echo 'export PATH="$PATH:$HOME/.local/bin"' > ~/.zprofile && echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

############################################
##              End Of File               ##
############################################
