#!/bin/sh

# スクリプトがエラーで停止するように設定
set -e

# --- Variable definitions ---
# Variables are not required if you don't need to pin specific versions.
# We'll install the latest versions from the repository using dnf.
# If you need specific versions, specify them in the dnf command.
# Example: dnf -y install ansible-core-2.16.7-1.el9
# ANSIBLE_VERSION="2.16.7"
# ANSIBLE_LINT_VERSION="6.22.1"

# --- Pre-checks ---
# Check if running with root privileges
if [ "${EUID:-${UID}}" -ne 0 ]; then
    echo "Warning: This script must be run with root privileges." >&2
    exit 1
fi

# Check if OS is CentOS Stream 9
if ! grep -q "CentOS Stream release 9" /etc/redhat-release; then
    echo "Warning: This script is intended for execution on CentOS Stream 9." >&2
    exit 1
fi

# --- Package management and installation ---
echo "INFO: Updating package cache."
dnf makecache

echo "INFO: Updating system to the latest state."
dnf -y update

echo "INFO: Installing EPEL repository."
# For CentOS Stream 9, the 'crb' repository must be enabled
dnf config-manager --set-enabled crb
dnf -y install epel-release epel-next-release

echo "INFO: Installing Git."
dnf -y install git

echo "INFO: Installing Ansible core package."
# Ansible package is provided under the name 'ansible-core'
dnf -y install ansible-core

echo "INFO: Installing Ansible Lint."
# ansible-lint is officially recommended to be installed via Python's pip
# It can also be installed with dnf, but pip is better for the latest version
dnf -y install ansible-lint


# --- Installation verification ---
echo "----------------------------------------"
echo "INFO: Installation completed. Checking version information."
echo ""
echo "Git version:"
git --version
echo ""
echo "Ansible version:"
ansible --version
echo ""
echo "Ansible Lint version:"
ansible-lint --version
echo "----------------------------------------"
