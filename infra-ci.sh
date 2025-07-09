#!/bin/sh

# スクリプトがエラーで停止するように設定
set -e

# --- 変数定義 ---
# 特定のバージョンを固定する必要がなければ、変数は不要です。
# dnfでリポジトリから最新版をインストールします。
# もし特定のバージョンが必要な場合は、dnfコマンドでバージョンを指定してください。
# 例: dnf -y install ansible-core-2.16.7-1.el9
# ANSIBLE_VERSION="2.16.7"
# ANSIBLE_LINT_VERSION="6.22.1"

# --- 事前チェック ---
# ルート権限で実行されているか確認
if [ "${EUID:-${UID}}" -ne 0 ]; then
    echo "警告: このスクリプトはroot権限で実行する必要があります。" >&2
    exit 1
fi

# OSがCentOS Stream 9であるか確認
if ! grep -q "CentOS Stream release 9" /etc/redhat-release; then
    echo "警告: このスクリプトはCentOS Stream 9での実行を想定しています。" >&2
    exit 1
fi

# --- パッケージ管理とインストール ---
echo "INFO: パッケージキャッシュを更新します。"
dnf makecache

echo "INFO: システムを最新の状態に更新します。"
dnf -y update

echo "INFO: EPELリポジトリをインストールします。"
# CentOS Stream 9では 'crb' リポジトリを有効にする必要があります
dnf config-manager --set-enabled crb
dnf -y install epel-release epel-next-release

echo "INFO: Gitをインストールします。"
dnf -y install git

echo "INFO: Ansibleのコアパッケージをインストールします。"
# Ansibleパッケージは'ansible-core'という名前で提供されています
dnf -y install ansible-core

echo "INFO: Ansible Lintをインストールします。"
# ansible-lintはPythonのpip経由でのインストールが公式で推奨されています
# dnfでもインストール可能ですが、最新版を使いたい場合はpipが良いでしょう
dnf -y install ansible-lint


# --- インストール確認 ---
echo "----------------------------------------"
echo "INFO: インストールが完了しました。バージョン情報を確認します。"
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
