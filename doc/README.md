# QI定義書の仕様書
# 目次
### 0. はじめに
### 1. 要件定義
#### 1.1 QI定義書のDB化
#### 1.2 QI定義書DBのAPI提供
#### 1.3 QI定義書の閲覧機能
#### 1.4 QI定義書の検索システム
### 2. 外部設計
#### 2.1 QI定義書のDB化
#### 2.2 QI定義書DBのAPI提供
#### 2.3 QI定義書の閲覧機能
#### 2.4 QI定義書の検索システム
### 3.内部設計/プログラム設計書
#### 3.1 Model
#### 3.1.1 Definition Model
#### 3.1.2 StringData Model
#### 3.2 Controler
#### 3.2.1 ApplicationController
#### 3.2.2 DefinitionController
#### 3.2.3 HomeController
#### 3.2.4 ApiController
#### 3.2.5 DefinitionApiController
### 4.使用マニュアル(利用者向け)
#### 4.1 QI定義書のDB登録
#### 4.2 QI定義書DBのAPI利用
#### 4.3 QI定義書の閲覧
#### 4.4 QI定義書の検索
### 5.保守マニュアル(開発者向け)
#### 5.1 開発環境
#### 5.2 バージョン管理
#### 5.3 アップデート

# 0. はじめに
本システムは以下、"QIDB"と呼ぶ。
QIDBの利用者には4章の使用マニュアルのみを見るだけで、すべての機能の使い方が理解できるようになっている。  
QIDBの保守に関しては、5章の保守マニュアルを見れば、保守に際して気をつけるべきことが書かれているが、システムの一部を変更する場合には、1~3章を読んで、全体の構造を理解した上で適切な変更を行って頂きたい。  
全体を把握せずに一部のみ変更をすると、変更した人のみが理解できる属人化したプログラムになりやすいので、必ず全体を把握してからシステムの変更をすること。

# 1. 要件定義
QIDBでは以下の4点を開発要件とする。

## 1.1 QI定義書のDB化
* [http://quality-indicator.net/?action=common_download_main&upload_id=54](http://quality-indicator.net/?action=common_download_main&upload_id=54)にあるような定義書をKVSのDBに保存できるシステムを構築する。
* 容易にDBに保存できるように、DBのWebインターフェイスも作成する。


## 1.2 QI定義書DBのAPI提供
* JSON形式で返す、DBのAPIを作成する。
* 提供するAPIは2種類とする。
	* 保存されている定義書をすべて返すもの
	* 指定された指標番号の定義書を1件返すもの

## 1.3 QI定義書の閲覧機能
* DBに保存された定義書を、人間が見やすい形で閲覧できるWebページを作成する


## 1.4 QI定義書の検索システム
* DBに保存された定義書を、フリーワードで検索できるシステムを構築する。
* 検索は特定のカラムに対して行うのではなく、定義書のすべての文字列に対して検索がかかるようにする。

# 2.外部設計

## 2.1 QI定義書のDB化
* DBに定義書を保存するWebインターフェイスには以下のフィールドを作成する。Inputはフォームのタイプ(コンボボックスの場合にはその選択肢)を示し、Typeは期待するデータ型を示す。
	* プロジェクト名
		* Input: [QIP, 済生会, 日本医師会, 全国自治体病院]
		* Type: String
	* 年度
		* Input: [2008, 2009, 2010, 2011, 2012, 2013, 2014]
		* Type: String
	* 指標番号
		* Input: text_field
		* Type: Integer
	* 更新日
		* Input: YYYYMMDD
		* Type: Date
	* 指標群
		* Input: text_field
		* Type: String
	* 名称
		* Input: text_field
		* Type: String
	* 意義
		* Input: text_field
		* Type: String
	* 必要なデータセット
		* Input: [DPC様式1, E/Fファイル, Fファイル, EFファイル]複数選択可能
		* Type: String
	* 定義の要約(分子)
		* Input: text_area
		* Type: String
	* 定義の要約(分母)
		* Input: text_area
		* Type: String
	* 分母の定義(説明)
		* Input: text_area (複数)
		* Type: String
	* 分母の定義(データ)
		* Input: CSVファイル (複数)
		* Type: Array(String)
	* 分子の定義(説明)
		* Input: text_area (複数)
		* Type: String
	* 分子の定義(データ)
		* Input: CSVファイル (複数)
		* Type: Array(String)
	* リスクの調整因子の定義
		* Input: [True(あり), False(なし)]
		* Type: Boolean
	* リスクの調整因子の定義(詳細)
		* Input: text_area
		* Type: String
	* 指標の算出方法(説明)
		* Input: text_field
		* Type: String
	* 指標の算出方法(単位)
		* Input: text_field
		* Type: String
	* 結果提示時の並び順
		* Input: ["desc", "asc"]
		* Type: String
	* 測定上の限界/解釈上の注意
		* Input: text_area
		* Type: String
	* 参考値
		* Input: text_area
		* Type: String
	* 参考資料
		* Input: text_area (複数)
		* Type: String
	* 定義見直しのタイミング
		* Input: text_field
		* Type: String

## 2.2 QI定義書DBのAPI提供
* 2.1で示したそれぞれのデータに対して、

```
{
  "プロジェクト名": "QIP",
  "年度": "2012",
  "指標番号", "0548",
  …
}
```

のように、`Key: Value`の形でJSON形式のデータを作成する。

* APIのURLは`http://example.org/api/v1/definition_api?id=xxxx`の形で提供する。
	* `xxxx`が指標番号の時にはその定義書のJSONデータを返す
	* `xxxx`が`all`の場合にはすべての定義書のJSONデータを返す

## 2.3 QI定義書の閲覧機能
* [http://quality-indicator.net/?action=common_download_main&upload_id=54](http://quality-indicator.net/?action=common_download_main&upload_id=54)にあるように、人間に見やすいレイアウトで定義書を表示する


## 2.4 QI定義書の検索システム
* 検索キーワードをInputとし、その結果の一覧をOutputとする
* 複数のキーワードが与えられた場合にはAND検索を行う
* 検索結果にQI定義書の閲覧ページへのリンクを付ける

# 3.内部設計/プログラム設計書
* KVSのDBにはMongoDBを使用する
* システム全体のフレームワークにはRuby on Railsを使用する

## 3.1 Model
* アプリケーションQIDB内で使用されているモデルに関して説明する。
* 一般的なRailsのMVCモデルに沿った構築をしており、特に特別な使い方はしていない。

## 3.1.1 Definition Model
* QI定義書のモデル
* MongoDBのdefinitions collectionでは、定義書のそれぞれのカラムをKeyとして持つ。
* 各メソッドの説明を以下で行う。

### exist?
* インスタンスの指標番号の定義書がすでにDB内に存在しているかどうかの確認メソッド
	* 存在していれば`true`を返す
	* 存在していなければ`false`を返す

### remove_duplicate
* インスタンスの指標番号の定義書がすでに存在している場合に、そのデータをDBから削除する
* 定義書に変更があり、上書きを行いたい時に使われるメソッド

### set_params(params)
* インスタンスにWebのインターフェイスから入力された情報を適正なJSON形式で持たせるメソッド
* DBに新たなカラムを追加したい場合には、ここを編集する必要がある

### get_datasets(params)
* 「必要なデータセット」に関するデータを適切なJSON形式に組み立てるメソッド

### get_references(params)
* 「参考文献」に関するデータを適切なJSON形式に組み立てるメソッド

### get_definitions(params)
* 「分子の定義」と「分母の定義」に関するデータをJSON形式で組み立て、それを「指標の定義/算出方法」としてJSON形式で返すメソッド

### get_def_data(file)
* 「分子の定義」または「分母の定義」の「データ」の欄で、CSVファイルがアップロードされた場合に、そのCSVファイルを読んで、JSON形式に組み立てるメソッド
* CSVファイルの読み込みには、`CSV`というライブラリを用いている

### create_search_index(params)
* 定義書の検索時に使うDBを構築するためのメソッド
* Webのインターフェイスで入力された文字列をすべてつなげて、それを一つの文字列としてStringDataクラスのcreate_recordメソッドに渡す。

## 3.1.2 StringData Model
* 定義書の検索に用いるためのデータを管理するモデル
* MongoDBのstring_data collectionでは、keyに「指標番号」と「data」の2つを持ち、dataはその指標番号の定義書に現れるすべての文字列をvalueとして保持する。
* 各メソッドの説明を以下で行う。

### self.create_record(id, sdata)
* `{"指標番号": id, data: sdata}`となるJSON形式のレコードを作成する
* `sdata`には、指標番号が`id`である定義書に現れるすべての文字列の情報を保持していることが期待される。

### self.search(params)
* MongoDBのstring_data collectionにアクセスし、`data`のvalueに検索キーワードを含むものの指標番号を取得する
* その指標番号の定義書をMongoDBのdefinition collectionから取り出し、該当する定義書の情報を返す

## 3.2 Controler
* アプリケーションQIDB内で使用されているコントローラーに関して説明する。
* 3.2.1~3.2.3まではRailsのMVCモデルに沿った構築をしているが、3.2.4と3.2.5に関しては、`rails-api`というライブラリを用いてAPIのコントローラーを記述しているため、少し変わったクラスの継承/ファイルの配置を行っている。
* なお、`rails-api`の使い方に関しても、そのライブラリの一般的な使われ方に沿っており、特別な使い方はしていない。

## 3.2.1 ApplicationController
* Rails標準の`ActionController`を継承している。
* セキュリティのCSRF対策は、APIを提供しているため、デフォルトの設定とは異なる。`:null_session`の設定にしてある。

## 3.2.2 DefinitionController
* Application Controllerを継承している。
* 定義書の作成や、表示などに関する動作を担当している。
* 以下に、各メソッドの説明をする。

### show
* 定義書閲覧のページを表示するメソッド
* このメソッドが呼び出される前に、プライベートメソッドの`set_definition`を呼び出し、どの指標番号の定義書が呼び出されたのかクエリを参照して確認している。
* `views/definitions/show.html.erb`をレンダリングする。

### new
* 定義書登録Webインターフェイスを表示するメソッド。
* `views/definitions/new.html.erb`をレンダリングする。

### create
* 定義書を登録するメソッド。
* メソッド内の流れは以下の通りである。
	1. 定義書の情報ををDefinitionクラスのインスタンスに保持させる。
	2. すでにその指標番号がDB内に存在するならそのレコードを削除
	3. 検索用の文字データの保存と定義書の保存が完了すれば 4 へ。完了しなければ 5 へ。
	4. 定義書が正常に保存されたことを示す`view/definitions/success.html.erb`をレンダリング
	5. 定義書登録の画面(`views/definitions/new.html.erb`)をレンダリングする


## 3.2.3 HomeController
* `root_path`を検索用のページにしてあるため、Home Countrollerという名前にしてあるが、担当している役割は定義書の検索のみである。
* 以下に、各メソッドの説明をする。

### index
* 検索用のページ(`views/home/index`)をレンダリングする。

### search
* indexページで検索が行われた場合に呼び出され、検索結果を`@results`に保持して`views/home/index`をレンダリングする。
* indexページでは、`@results`が`nil`でないときのみ、検索結果を表示するようになっている。


## 3.2.4 ApiController
* APIのコントローラーに継承させるために作成したコントローラークラス。
* 中身はApplicationControllerを継承しているだけ。

## 3.2.5 DefinitionApiController
* JSON形式のAPIを提供するコントローラーで、ApiControllerを継承している。
* APIの提供はすべで`index`メソッドで行っている。

### index
* `/api/v1/definition_api?id=xxxx`で与えられるクエリのid部分が`all`かそれ以外かで場合分けをしている。
	* `all`の場合、DBに保存されているすべての定義書データをJSON形式で返す
	* それ以外の場合、idの値をDBのdefinition collectionの`指標番号`のkeyに対して検索をかけ、その結果の一番上のものの定義書データをJSON形式で返す
* 上記による結果が`nil`の場合には`404 not found`のエラーを返す。

# 4.使用マニュアル(説明書)
利用者はこの4章の使用マニュアルを読むだけで、QIDBのシステムが提供する機能をすべて理解できる。都合上スクリーンショットを載せることができないので、文字だけの説明にとどめる。  
サービスが`10.238.83.176`のIPアドレスで提供されていることを前提にして、以下に記述をする。  

## 4.1 QI定義書のDB登録
[http://10.238.83.176/definitions/new](http://10.238.83.176/definitions/new)のURLで提供されるWebインターフェイスを使って、QI定義書の登録ができる。  
[実際の定義書](http://quality-indicator.net/?action=common_download_main&upload_id=54)の内容をフォームに入力して、画面下部の緑色の「作成」ボタンを押すだけで、DBに登録することができる。  
入力に際して注意事項を以下に記す。

* 「必要なデータセット」の項目で、複数のデータセットが必要な場合には、コンボボックス下にある緑色の`+`ボタンを押すことで、コンボボックスを増やすことができる。
	* コンボボックスの内容を`["DPC様式1", "DPC様式1", "E/Fファイル"]`のように重複して選択してしまった場合にも、実際にDBに登録されるのは`["DPC様式1", "E/Fファイル"]`のデータのみである。
* 「指標の定義/算出方法」では分子と分母の定義が複数存在し、かつ、それぞれの定義にはテーブル型のデータが付属してることがある。
	* 複数の定義を入力したい場合には緑色の`+`(定義の追加) というボタンを押すことで、複数の定義を入力することができる。
	* データの入力には、CSVファイルをアップロードする。CSVファイルの中身は以下のようにあるべきである。

```
薬価基準コード7桁, 成分名, 2010, 2012, 2014
3399007, アスピリン, true, true, false
3399100, アスピリン・ダイアルミネート, true, true, false
3999411, オザグレルナトリウム, true, true, false
2190408, アルガトロバン水和物, true, true, false
```

* 「リスク調整因子の定義」の部分では、「あり」を選択することで、その定義の詳細を入力するフォームが現れるので、そちらに入力すれば良い。
* 「測定上の限界/解釈上の注意」や「参考値」などのtext_areaのフィールド(フォーム右下で枠の大きさを変更できるもの)では改行が"改行"として扱われるので、定義書内で改行されている部分はそのままの形で入力すれば良い。


## 4.2 QI定義書DBのAPI利用
* QIDBのAPIは[http://10.238.83.176/api/v1/definition_api?id=0548](http://10.238.83.176/api/v1/definition_api?id=0548)のようなURLで提供される。
* 返されるデータはJSON形式のデータである。
* JSON-LD形式で提供する予定であったが、開発者の"都合"でJSON形式の提供にとどまっている。
* `id=xxxx`の部分で、取得したいデータを指定する
* `xxxx`が`all`という文字列の場合には、DB内に保存されているすべての定義書の情報を取得する
* `xxxx`が`all`以外の、例えば`0548`のような場合には、指標番号が0548の定義書の情報を取得することができる

## 4.3 QI定義書の閲覧
* 定義書は[http://10.238.83.176/definitions/固有のid](http://10.238.83.176/definitions/0548)のようなURLでその内容を閲覧することができる。
* `http://10.238.83.176/definitions/qip/xxxx`の`xxxx`の部分で、閲覧したい定義書のqipの指標番号を指定すれば、qipの番号に紐付けられた定義書が閲覧出来る。

## 4.4 QI定義書の検索
* 定義書の検索機能は[http://10.238.83.176](http://10.238.83.176/)または、4.3の閲覧のページの上部にて行うことができる。
* この検索システムで検索出来る範囲は、定義書に含まれる文字列すべてである。
* キーワードを「大動脈バルーンパンピング法　人工心肺」と入力した場合には「大動脈バルーンパンピング法」と「人工心肺」の文字列が共に含まれるAND検索で行われる。
* 検索結果の太字部分、例えば`指標群: 脳卒中　整理番号: 0548`の部分をクリックすることで、その定義書の閲覧ページへ移動することができる。

## 4.5 QI定義書の編集
* 変更者と変更メッセージ必須
*

## 4.6 QI定義書のpdf出力
* 定義書の閲覧ページの下部のpdfというリンクを押すと、pdf化された定義書の情報が開かれる。
* 分母の定義や分子の定義において、登録された薬剤テーブルは、テーブル名のみの表示となっている。(2015/03/20現在)

## 4.7 QI定義書のCSV出力

## 4.7 QI定義書登録時のCSV入力(デプロイ時のみ使用)
* デプロイ時に、定義書の骨子となるデータ(プロジェクト/指標群/定義書表題/分母/分子/意義)を一括で取り込む機能である。
* 取り込みの様式は、csv ファイルで、文字コードは utf-8 である。
* ファイルの中身は以下のように、列名とカラムが並んでいるべきである。

```
qip,指標群,定義書表題,分母,分子,意義
123,呼吸器系,~症例の割合,~の症例,~の症例,人助け
54,...
```
# 5.保守マニュアル(開発者向け)
## 5.1 開発環境
QIDBに使用している、ソフトウェアとそのバージョン等を記載する。

### ハードウェア系
* IP: 10.238.83.176
* OS: CentOS release 6.6 (Final) / Linux version 2.6.32-504.1.3.el6.x86_64
* CPU: Intel(R) Xeon(R) CPU E5-2420 0 @ 1.90GHz の 1コア
* RAM: 512MB ~ 2048MB (可変)

### Webサーバー
* Apache 2.2.15 (Unix)
* Phusion Passenger version 4.0.56

### アプリケーション関連
* ruby 2.1.5p273 (rbenvにてインストール)
* rbenv 0.4.0-129-g7e0e85b
* gem 2.4.5
* MongoDB shell version: 2.6.6
* Rails 4.1.7
	* Railsで使用しているgemのバージョンは`/var/www/QIDB/`で`$ bundle list`により確認可能。

### サーバー環境
* `/etc/sysconfig/iptables`にて通信を許すポートを制限
* `/etc/httpd/conf/httpd.conf`の最下部にApacheとPassengerを連携するための設定を記述
* `/etc/httpd/conf.d/passenger.conf`にPassengerの設定を記述
* MongoDBとApacheはサーバー再起動後も自動的に立ち上げるように設定済み(のはず)
* ユーザアカウントはrootとitoとhayakawaがある(2015/03/23現在)。rootのパスワードは共用PCのパスワードと同様である。

## 5.2 バージョン管理
* バージョン管理はGitで行っている
* ソースコードは[伊藤のGitHub](https://github.com/showwin/QIDB)においてあり、開発の流れとしては以下が望ましい。
	1. GitHubからローカルにcloneして開発をする
	2. バグが無いことを確認して、`git@github.com:showwin/QIDB.git`にpush
	3. 10.238.83.176のサーバーに入って、`/var/www/QIDB/`でpull(rootアカウントでpullしないこと)
	4. アカウントをrootに変更して、`$ service httpd restart`でapacheを再起動してデプロイ完了


## 5.3 アップデート
脆弱性がないアプリケーションを保つために、5.1で示したソフトウェアは常に最新のバージョンを使用することが望ましい。  
しかし、Railsの(メジャーアップデートの)バージョンを上げるとアプリケーションが動かなくなることがあるので、マイナーアップデートのみの適用が望ましい。現状は4.1.7を使用しているので、4.1.x系のアップデートは常に取り入れ、4.2.xにはアップデートしない方がよい。  

使用しているgemに関しても、できるだけ最新のバージョンを使用することが望ましいが、`1.2.3`から`2.0.0`などのメジャーアップデートの場合には、アプリケーションが動かなくなることがあるので、
Rails自身を含めたgemのアップデートの際にはgitで別branchを切ってから作業をするのがよい。
