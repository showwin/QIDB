# QIDB
[![Circle CI](https://circleci.com/gh/showwin/QIDB/tree/master.svg?style=svg)](https://circleci.com/gh/showwin/QIDB/tree/master)
[![Coverage Status](https://coveralls.io/repos/github/showwin/QIDB/badge.svg?branch=master)](https://coveralls.io/github/showwin/QIDB?branch=master)


# 開発環境

```
$ docker-compose Build
$ docker-compose up
```

localhost:3000 にアクセスするとWebアプリケーションを見ることができる。


# デプロイ方法
CircleCI から capistrano を使ってサーバーにデプロイしている。  
`qidb` の鍵が登録してあり、その鍵を使ってサーバーにSSHしてデプロイしている。
