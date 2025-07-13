# インフラCI実践ガイドのDockerオンリーバージョン（Nested VM未使用）

## 概要

このプロジェクトは、インフラCI実践ガイドのDockerベース実装です。ネストされた仮想マシンを使用せず、Dockerコンテナを利用してCI/CDパイプラインを構築します。

## CentOS 7 EOL対応について

CentOS 7は2024年6月30日にEnd of Lifeを迎えたため、以下の代替イメージを使用します：

- **デフォルト**: AlmaLinux 8 (`.gitlab-ci.yml`)

## 前提条件

- GitLab Runner（Dockerエグゼキューター）
- Docker環境
