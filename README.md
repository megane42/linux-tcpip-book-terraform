# これは何

書籍「Linuxで動かしながら学ぶTCP/IPネットワーク入門」に書かれている実験を行うための EC2 を構築する terraform です。

**個人が非公式に作成したもの** であり、書籍の内容に対する動作の完全性は保証されていません。また、原作者様・出版社様とは一切関係ありません。

# 作られるもの

- VPC
- EC2 インスタンス (書籍で紹介された環境構築が実施済み)
- セキュリティグループ (特定の IP アドレスからの ssh だけを許可)

# 使用方法

- 作成される EC2 キーペアを手動で登録しておく
- terraform をインストールした端末上で下記を実行する

```sh
cp    locals.tf.sample locals.tf
emacs locals.tf

terraform init
terraform plan
terraform apply

ssh -i ~/.ssh/id_rsa ubuntu@[ec2_public_ip]
```

# cloud-init 実行ログの確認方法

- ec2 インスタンス上で下記を実行する

```
tail -f /var/log/cloud-init-output.log
```
