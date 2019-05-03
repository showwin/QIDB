# QIDB
[![Circle CI](https://circleci.com/gh/showwin/QIDB/tree/master.svg?style=svg)](https://circleci.com/gh/showwin/QIDB/tree/master)
[![Coverage Status](https://coveralls.io/repos/github/showwin/QIDB/badge.svg?branch=master)](https://coveralls.io/github/showwin/QIDB?branch=master)


# 開発環境構築

```
$ git clone git@github.com:showwin/QIDB.git
$ cd QIDB
$ docker-compose Build
$ docker-compose up
```

localhost:3000 にアクセスするとWebアプリケーションを見ることができる。

# テスト実行

```
# Docker 起動後
$ docker exec -it qidb_qidb_1 /bin/bash
$ bundle exec rspec --color --require spec_helper
```


# デプロイ方法
CircleCI から capistrano を使ってサーバーにデプロイしている。  
`qidb` の鍵が登録してあり、その鍵を使ってサーバーにSSHしてデプロイしている。
