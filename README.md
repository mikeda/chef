Overview
========

自宅サーバ管理用のchef設定です

* chef-soloを想定。専用ユーザからsudo実行
* CentOS6 & EPEL
* role、nodeもgit管理
* 汎用性より実用性
* 他人の使い勝手よりオレの使い勝手

Repository Directories
======================

使ってるディレクトリはこれだけ(他のは整理予定)

* `cookbooks/` - Cookbook
* `roles/` - ロール
* `nodes/` - ノード
* `solo/` - chef-solo関連
