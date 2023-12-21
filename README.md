# Conduit

ブログプラットフォームを作る[RealWorld](https://github.com/gothinkster/realworld/tree/main)というOSSのプロジェクトがあります。これは実在するものと同じ機能を持つサイトを作成することで、学習したいフレームワークの技術を習得することを目的とするプロジェクトです。

そのRealWorldに則り、Medium.comのクローンサイトである[Conduit](https://demo.realworld.io/#/)をRuby on Railsで作成したという内容です。

本リポジトリは、株式会社ユーブルが運営するサービス「アプレンティス」における学習の一環で作成したものになります。

## Conduitとは
Medium.comは、ユーザーがログインをして記事を投稿するサイトです。

Conduitはそんなサイトのクローンとして作成するので、ユーザーの登録、ログイン/ログアウト機能、記事の投稿機能などが求められます。

## 本リポジトリについて
Dockerで作成したRuby on Railsアプリとなります。

ルート直下にはdockerfile, compose.ymlが存在し、rails serverはdocker-composeコマンドで起動することになります。

その他はrails newで作成した通常のRailsアプリの構成と変わりません。

## 使用技術
- Ruby 3.2.2
  - Ruby on Rails 7.0.4,3
  - sqlite3 1.6.1

## 実装

### 実装したもの
- ユーザーの登録/表示
- 永続セッションを用いたログイン/ログアウト
- 記事の投稿/表示/編集/削除

### 実装していないもの
- フレンドリーフォワーディング
- ユーザーの編集と削除
- タグ
- お気に入り
- フォロー
- 記事へのコメント

## 起動方法
こちらのリポジトリを`git clone`で取得してから、以下のコマンドを実行してください。

```
docker-compose up -d
docker-compose exec web bash
```