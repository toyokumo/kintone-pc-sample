Print Creator sample for kintone SI
===================

概要
------------

サイボウズの [kintone](https://kintone.cybozu.com/jp/) と
サイボウズスタートアップスの [プリントクリエイター](https://pc.kintoneapp.com/)
の連携をカスタマイズするためのサンプルになります.

サンプルには, 以下の3つの機能が実装されている.
1と2は通常のプリントクリエイターと同じ機能になる.

1. レコード詳細ページから1枚のPDFを出力
2. レコード一覧から検索条件にマッチするレコードを500件までPDF出力
3. レコード一覧からチェックしたレコードのみPDF出力

インストール
------------

### Node(v0.10)のインストール

[Node.js](http://nodejs.org/)をインストールしておく必要がある.

#### Mac

``` {.bash}
  brew install node
```

brewを使っていない場合は, [これ](http://qiita.com/is0me/items/475fdbc4d770534f9ef1)
とかを参考にインストールしてください.

[nodebrew](https://github.com/hokaccha/nodebrew)を使ってバージョン管理を行いたい場合は,
[ここ](http://qiita.com/Kackey/items/b41b11bcf1c0b0d76149#mac%E7%B7%A8)とかを参考に
してください.

#### Windows

WindowsでNode.jsを利用する場合, [nodist](https://github.com/marcelklehr/nodist)が便
利です[これ](http://qiita.com/Kackey/items/b41b11bcf1c0b0d76149#windows%E7%B7%A8)
とかを参考にインストールしてください.
インストール後は, 以下のコマンドでnodeのバージョンをv0.10.35にしてください.

``` {.bash}
  nodist + v0.10.35
  nodist v0.10.35
```

※Windowsの場合, node-sassのインストールでエラーが起きる場合があります.
node-sassを先にインストールしてからnpm installすると解決する場合があります.

### 依存ライブラリのインストール

依存ライブラリは npm を用いて管理されている.

``` {.bash}
  npm install
```

以上で依存ライブラリがインストールされる.


### 主な利用ライブラリ

主に以下のライブラリを利用している.

- [CoffeeScript](http://coffeescript.org/)
- [Gulp](http://gulpjs.com/)
- [Browserify](http://browserify.org/)
- [bootstrap](http://getbootstrap.com)
- [Font Awesome](http://fontawesome.io/)
- [Vue.js](http://vuejs.org/)
- [lodash](https://lodash.com/)
- [Superagent](http://visionmedia.github.io/superagent/)


使い方
------------

### 初期設定

以下のconfigファイルを編集する必要がある.

```
    src/print-creator/config.coffee
```

appCodeにプリントクリエイターのアプリコードを設定してください.

cssにビルド後のprint-creator.cssのURLを設定してください.
kintoneに直接設定する場合は, nullを設定してください.

### JavaScriptやSASSのビルド

Gulp タスクが幾つか用意されている.

#### ビルド

ビルドするためには

``` {.bash}
  npm run build
```

を実行する. これを実行する前に `npm install` を行って依存ライブラリが正しくインストールして
おく必要がある.

ビルド元ファイルは `src` 以下にある. ビルド後のファイルは基本的に `web` 以下に出力される.

#### Watch

開発時に, ファイルの変更を検知して, ビルド + ライブリロードなどといったことを自動的に行ってく
れるタスクが用意されている.

監視プロセスを立ち上げるためには以下のコマンドを実行する.

``` {.bash}
  npm run watch
```

### Dropboxの利用

開発にはDropboxを利用すると便利です.

gulp/jsConfig.jsとgulp/cssConfig.jsのdestDirにDropbox内のディレクトリを設定してくださ
い.

src/print-creator/config.coffeeのcssにDropboxで共有したprint-creator.cssのURLを設定
してください.

kintoneにDropboxで共有したprint-creator.jsを設定すると, 修正が数秒でkintoneに反映される
ようになります.

推奨ツール
------------

### エディタ

HTML, CSS, JavaScript, Sass, CoffeeScriptなどの開発には,
[WebStorm](https://www.jetbrains.com/webstorm/)
をオススメする.

Macの場合は, brew caskでもインストールできる.

### バージョン管理

Gitでのバージョン管理には,[SourceTree](http://sourcetreeapp.com/)
をオススメする.

git flowに関する機能が組み込まれており, 本プロジェクトに適している.

ライセンス
------------

MIT