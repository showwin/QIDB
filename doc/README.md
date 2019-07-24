# QI定義書の仕様書
# 目次
### 0. [はじめに](https://github.com/showwin/QIDB/blob/master/doc/README.md#0-はじめに-1)
### 1. [要件定義](https://github.com/showwin/QIDB/blob/master/doc/README.md#1-要件定義-1)
#### 1.1 [QI定義書のDB化](https://github.com/showwin/QIDB/blob/master/doc/README.md#11-qi定義書のdb化-1)
#### 1.2 [QI定義書DBのWevAPI提供](https://github.com/showwin/QIDB/blob/master/doc/README.md#12-qi定義書dbのapi提供)
#### 1.3 [QI定義書の閲覧機能](https://github.com/showwin/QIDB/blob/master/doc/README.md#13-qi定義書の閲覧機能-1)
#### 1.4 [QI定義書の検索システム](https://github.com/showwin/QIDB/blob/master/doc/README.md#14-qi定義書の検索システム-1)
### 2. [外部設計](https://github.com/showwin/QIDB/blob/master/doc/README.md#2外部設計)
#### 2.1 [QI定義書のDB化](https://github.com/showwin/QIDB/blob/master/doc/README.md#21-qi定義書のdb化-1)
#### 2.2 [QI定義書DBのWebAPI提供](https://github.com/showwin/QIDB/blob/master/doc/README.md#22-qi定義書dbのwebapi提供-1)
#### 2.3 [QI定義書の閲覧機能](https://github.com/showwin/QIDB/blob/master/doc/README.md#23-qi定義書の閲覧機能-1)
#### 2.4 [QI定義書の検索システム](https://github.com/showwin/QIDB/blob/master/doc/README.md#24-qi定義書の検索システム-1)
### 3.[内部設計/プログラム設計書](https://github.com/showwin/QIDB/blob/master/doc/README.md#3内部設計プログラム設計書-1)
#### 3.1 [Model](https://github.com/showwin/QIDB/blob/master/doc/README.md#31-model-1)
#### 3.1.1 [Definition Model](https://github.com/showwin/QIDB/blob/master/doc/README.md#311-definition-model-1)
#### 3.1.2 [ChangeLog Model](https://github.com/showwin/QIDB/blob/master/doc/README.md#312-changelog)
#### 3.2 [Controler](https://github.com/showwin/QIDB/blob/master/doc/README.md#32-controler-1)
#### 3.2.1 [ApplicationController](https://github.com/showwin/QIDB/blob/master/doc/README.md#321-applicationcontroller-1)
#### 3.2.2 [DefinitionController](https://github.com/showwin/QIDB/blob/master/doc/README.md#322-definitioncontroller-1)
#### 3.2.3 [HomeController](https://github.com/showwin/QIDB/blob/master/doc/README.md#323-homecontroller-1))
#### 3.2.4 [ApiController](https://github.com/showwin/QIDB/blob/master/doc/README.md#324-apicontroller-1)
#### 3.2.5 [DefinitionApiController](https://github.com/showwin/QIDB/blob/master/doc/README.md#325-definitionapicontroller-1)
#### 3.3 [Form](https://github.com/showwin/QIDB/blob/master/doc/README.md#33-form-1)
#### 3.3.1 [DefinitionForm](https://github.com/showwin/QIDB/blob/master/doc/README.md#331-definitionform-1)
### 4.[使用マニュアル(利用者向け)](https://github.com/showwin/QIDB/blob/master/doc/README.md#4使用マニュアル説明書)
#### 4.1 [QI定義書のDB登録](https://github.com/showwin/QIDB/blob/master/doc/README.md#41-qi定義書のdb登録-1)
#### 4.2 [QI定義書DBのWebAPI利用](https://github.com/showwin/QIDB/blob/master/doc/README.md#42-qi定義書dbのapi利用-1)
#### 4.3 [QI定義書の閲覧](https://github.com/showwin/QIDB/blob/master/doc/README.md#43-qi定義書の閲覧-1)
#### 4.4 [QI定義書の検索](https://github.com/showwin/QIDB/blob/master/doc/README.md#44-qi定義書の検索-1)
#### 4.5 [QI定義書の編集](https://github.com/showwin/QIDB/blob/master/doc/README.md#45-qi定義書の編集-1)
#### 4.6 [QI定義書のpdf出力](https://github.com/showwin/QIDB/blob/master/doc/README.md#46-qi定義書のpdf出力-1)
#### 4.7 [QI定義書のCSV出力](https://github.com/showwin/QIDB/blob/master/doc/README.md#47-qi定義書のcsv出力-1)
#### 4.8 [QI定義書登録時のCSV入力](https://github.com/showwin/QIDB/blob/master/doc/README.md#48-qi定義書登録時のcsv入力デプロイ時のみ使用-1)
### 5.[保守マニュアル(開発者向け)](https://github.com/showwin/QIDB/blob/master/doc/README.md#5保守マニュアル開発者向け-1)
#### 5.1 [開発環境](https://github.com/showwin/QIDB/blob/master/doc/README.md#51-開発環境-1)
#### 5.2 [開発手順](https://github.com/showwin/QIDB/blob/master/doc/README.md#52-バージョン管理-1)
#### 5.3 [アップデート](https://github.com/showwin/QIDB/blob/master/doc/README.md#53-アップデート-1)
#### 5.4 [Docker 開発環境](https://github.com/showwin/QIDB/blob/master/doc/README.md#54-docker-開発環境)

# 0. はじめに
本システムは以下、"QIDB"と呼ぶ。
QIDBの利用者には4章の使用マニュアルのみを見るだけで、すべての機能の使い方が理解できるようになっている。  
QIDBの保守に関しては、5章の保守マニュアルを見れば、保守に際して気をつけるべきことが書かれているが、システムの一部を変更する場合には、1~3章を読んで、全体の構造を理解した上で適切な変更を行って頂きたい。  
全体を把握せずに一部のみ変更をすると、変更した人のみが理解できる属人化したプログラムになりやすいので、必ず全体を把握してからシステムの変更をすること。

# 1. 要件定義
QIDBでは以下の4点を開発要件とする。

## 1.1 QI定義書のデータベース化
* [http://quality-indicator.net/?action=common_download_main&upload_id=54](http://quality-indicator.net/?action=common_download_main&upload_id=54)にあるような定義書をデータベースに保存できるシステムを構築する。
* 容易にデータベースに保存できるように、Webインターフェイスを作成する。
* WebインターフェイスからはQI定義書の作成/編集/複製/削除を行うことができる。
  * ただし、上記の操作を行うには権限が必要であり、事前にBasic認証を行う必要がある。

## 1.2 QI定義書DBのAPI提供
* JSON形式で返す、DBのWebAPIを作成する。
* 提供するAPIは2種類とする。
	* 保存されている定義書をすべて返すもの
	* 指定された指標番号の定義書を1件返すもの

## 1.3 QI定義書の閲覧機能
* DBに保存された定義書を、人間が見やすい形で閲覧できるWebページを作成する。
* QI定義書をPDFファイルに変換し、そのファイルをダウンロードをすることができる。


## 1.4 QI定義書の検索システム
* DBに保存された定義書を、フリーワードで検索できるシステムを構築する。
* 検索は特定のカラムに対して行うのではなく、定義書のすべての文字列に対して検索する。


# 2.外部設計

## 2.1 QI定義書のDB化
* DBに定義書を保存するWebインターフェイスには以下のフィールドを作成する。Inputはフォームのタイプ(セレクトボックスの場合にはその選択肢)を示し、Typeは期待するデータ型を示す。
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
	* 指標群(英語)
		* Input: text_field
		* Type: String
	* 指標の表示順
		* Input: text_field
		* Type: String
	* 名称
		* Input: text_field
		* Type: String
	* 名称(英語)
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
	* 定義の要約(分子)(英語)
		* Input: text_area
		* Type: String
	* 定義の要約(分母)
		* Input: text_area
		* Type: String
	* 定義の要約(分母)(英語)
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
	* リスクの調整因子の定義(データ)
		* Input: CSVファイル (複数)
		* Type: Array(String)
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
	* 測定上の限界/解釈上の注意(データ)
		* Input: CSVファイル (複数)
		* Type: Array(String)
	* 参考値
		* Input: text_area
		* Type: String
	* 参考資料
		* Input: text_area (複数)
		* Type: String
	* 参考資料(データ)
		* Input: CSVファイル (複数)
		* Type: Array(String)
	* 定義見直しのタイミング
		* Input: text_field
		* Type: String
	* 指標タイプ
		* Input: text_field
		* Type: String
	
## 2.2 QI定義書DBのWebAPI提供
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

* WebAPIのエンドポイントは`/api/v1/definitions`であり、パラメータとして`id`と`project`を受け取る。
	* 例えば、`/api/v1/definitions?project=qip&id=5`の場合には、QIPの定義書の指標番号が5の定義書のJSONデータを返却する。
	* パラメータが与えられない場合には、すべての定義書のデータをJSON型で返却する。

## 2.3 QI定義書の閲覧機能
* [http://quality-indicator.net/?action=common_download_main&upload_id=54](http://quality-indicator.net/?action=common_download_main&upload_id=54)にあるように、人間に見やすいレイアウトで定義書を表示する
* `/:project/:id/sheet.pdf` から定義書のPDFファイルをダウンロードすることができる。
	* 例えば、`:project` には `qip`、`:id`には`64`といった値が入る。
* 複数の定義書をまとめて1つのPDFとしてダウンロードしたい場合には、`/definitions/select`のWebインターフェイスからPDF化したい定義書を選択してPDFを出力させる。

## 2.4 QI定義書の検索システム
* 検索キーワードをInputとし、その結果の一覧をOutputとする
* 複数のキーワードが与えられた場合にはAND検索を行う
* 検索結果にQI定義書の閲覧ページへのリンクを付ける

# 3.内部設計/プログラム設計書
* KVSのDBにはMongoDBを使用する
* システム全体のフレームワークにはRuby on Railsを使用する
* 一般的なRailsのフォルダ構成に加えて、formsディレクトリを加えている。
  * FormクラスはWebのフォームから送られてくるデータが複数のテーブルに紐付く場合、コントローラがその処理をするには責務が大きすぎるため、コントローラとモデルの間を仲介する役割をもつものである。

## 3.1 Model
* アプリケーションQIDB内で使用されているモデルに関して説明する。

## 3.1.1 Definition Model
* QI定義書のモデル
* MongoDBのdefinitions collectionでは、定義書のそれぞれのカラムをKeyとして持つ。
* 各メソッドの説明を以下で行う。

### search_by_prjt_and_id
プロジェクト名と定義書のIDから合致する定義書を探すスコープ。

### active
* 有効な定義書のみを返すスコープ。
* DB内で論理削除(soft delete)を行っているため、Webページに表示するデータはこのスコープを通さないと、削除された定義書や古いバージョンの定義書も含まれてしまう。

### find_by_project
* プロジェクト名から合致する定義書を探すスコープ。

### find_by_year
* その年度で有効な定義書を探すスコープ。

### find_duplicates
* プロジェクト名と指標番号の組み合わせで、すでにその組み合わせが使われているものの集合を探すメソッド。
* 定義書を作成/更新するときに、上書きすることになる定義書を探すためにに用いる。

### remove_duplicate
* インスタンスの指標番号の定義書がすでに存在している場合に、そのデータをDBから削除する
* 定義書に変更があり、上書きを行いたい時に使われるメソッド

### make_public
* 定義書を有効にするメソッド
* フォームでデータを入力した後に、上書きしますか？と聞かれている段階ではDBにフォームの内容は保存されているが、公開用のフラグ(=論理削除フラグ)が立っていないため、ユーザが「上書きする」とした時点でこのメソッドが呼ばれて、定義書が閲覧可能になる。

### save_with_log!
* 定義書を保存すると同時に、編集履歴にもレコードを追加するメソッド

### save_draft_with_log
* make_public のメソッドで説明したように、フォームでデータが入力された後に公開フラグを立てないでDBにデータを保存するときにこのメソッドを使用する。

### save_draft!
* 定義書を非公開(もしくは削除)にするメソッド

### update_log_id
* 定義書の更新履歴をたどるためのlog_idを更新するメソッド。

### init_params
* DefinitionFormを入力として、各情報をインスタンス変数にする。

### search
* 検索キーワードの文字列を含む定義書を探すメソッド。

### read_csv
* CSVの読み込みメソッド

## 3.1.2 ChangeLog
* 定義書の更新履歴を管理するモデル

### set_params
* 初期化

### make_public
* ログを公開状態にする

### save_draft!
* ログを非公開状態(=削除)にする

## 3.2 Controler
* アプリケーションQIDB内で使用されているコントローラーに関して説明する。
* 3.2.1~3.2.3まではRailsのMVCモデルに沿った構築をしているが、3.2.4と3.2.5に関しては、`rails-api`というライブラリを用いてAPIのコントローラーを記述しているため、少し変わったクラスの継承/ファイルの配置を行っている。
* なお、`rails-api`の使い方に関しても、そのライブラリの一般的な使われ方に沿っており、特別な使い方はしていない。

## 3.2.1 ApplicationController
* Rails標準の`ActionController`を継承している。
* セキュリティのCSRF対策は、APIを提供しているため、デフォルトの設定とは異なる。`:null_session`の設定にしてある。

### authenticate
* Basic認証をしたかどうかの判定。していなければトップページにリダイレクト。

### admin?
* 管理者ユーザならば`true`を返す

### format_query_keywords
* 検索キーワードの全角スペースを半角スペースに変換するメソッド。

## 3.2.2 DefinitionController
* Application Controllerを継承している。
* 定義書の作成や、表示などに関する動作を担当している。
* 以下に、各メソッドの説明をする。

### show
* 定義書閲覧のページを表示するメソッド
* このメソッドが呼び出される前に、プライベートメソッドの`set_definition`を呼び出し、どの指標番号の定義書が呼び出されたのかクエリを参照して確認している。
* `views/definitions/show.html.erb`をレンダリングする。

### show_en
* 定義書閲覧の日本語英語混合ページを表示するメソッド
* show メソッドと同様の処理で、`views/definitions/show_en.html.erb`をレンダリングする。


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

### confirm
* 定義書の上書きに同意した時にこのメソッドが呼ばれる
* 定義書を公開状態にして、successへリダイレクト

### success
* 定義書の登録が完了したことを表示するページをレンダリング

### edit
* 指標の編集ページをレンダリングする

### duplicate
* 指標を複製するページをレンダリングする。
* 定義書を作成するときに新規作成をしたのか、複製で作成したのかを判断する必要があるため、`@definitoin_flg`を定義している。

### destroy
* 定義書の削除を行う

### upload
* 定義書をCSVからインポートするときに、CSVをアップロードするフォームを表示する

### import
* CSVから定義書のデータを読み込む

### search
* `/:project/:id`のURLから呼ばれた時に、それに該当する定義書を検索して表示する

### search_pdf
* `/:project/:id/sheet.pdf`のURLが呼ばれた時に、それに該当する定義書を検索して、pdfメソッドにリダイレクトすることで、その定義書のPDFを出力する。

### search_en
* `/:project/:id/en`のURLが呼ばれた時に、それに該当する定義書を検索して日本語英語混在のページを表示する

### pdf
* 定義書のPDFファイルを出力する。
* HTMLからPDFの変換を行っていて、`wkhtmltopdf`のライブラリを使用している。

### select
* 複数のPDFを出力するときに、どの定義書を出力するのか選択するフォームを表示する

### pdfs
* 複数の定義書を1つのPDFファイルで出力する。
* やっていることは、複数の定義書を表示するHTMLを作って、それをPDFに変換しているだけ。


## 3.2.3 HomeController
* `root_path`を検索用のページにしてあるため、Home Countrollerという名前にしてあるが、担当している役割は定義書の検索のみである。
* 以下に、各メソッドの説明をする。

### index
* 検索用のページ(`views/home/index`)をレンダリングする。

### login
* ここにアクセスすることで、管理者権限を得ることができる。
* なお、アプリケーションサーバーへリバースプロキシをしている、Webサーバー側(Nginx)でこのエンドポイントへのアクセスにBasic認証をかけている。

### logout
* 管理者をやめる

### search
* indexページで検索が行われた場合に呼び出され、検索結果を`@results`に保持して`views/home/index`をレンダリングする。
* indexページでは、`@results`が`nil`でないときのみ、検索結果を表示するようになっている。

### output_csv
全ての定義書をCSV化して出力する

## 3.2.4 ApiController
* APIのコントローラーに継承させるために作成したコントローラークラス。
* 中身はApplicationControllerを継承しているだけ。

## 3.2.5 DefinitionApiController
* JSON形式のAPIを提供するコントローラーで、ApiControllerを継承している。
* APIの提供はすべで`index`メソッドで行っている。

### index
* エンドポイントは`/api/v1/definitions`であり、パラメータとして`id`と`project`を受け取る。
	* 例えば、`/api/v1/definitions?project=qip&id=5`の場合には、QIPの定義書の使用番号が5の定義書のJSONデータを返却する。
	* パラメータが与えられない場合には、すべての定義書のデータをJSON型で返却する。
* 上記による結果が`nil`の場合には`404 not found`のエラーを返す。

## 3.3 Form
* アプリケーションQIDB内で使用されているFormに関して説明する。
* 3 にも書いたように、FormクラスはWebのフォームから送られてくるデータが複数のテーブルに紐付く場合、コントローラがその処理をするには責務が大きすぎるため、コントローラとモデルの間を仲介する役割をもつものである。

## 3.3.1 DefinitionForm
### initialize
* フォームから送られてきたデータを適切なデータ構造にして、インスタンス変数に格納する。
* 以下で説明しないメソッドは単にフォームからのデータをDBに保存するために適切なデータ構造に変換しているメソッドである

### log_id
* 定義書の変更ログを管理するためのidを取得する。
* 新しく作成するものであれば、Definition.countとして、既存のlog_idと重複しない値を作成する

### def_data
* CSVファイルをアップロードするフォームで使用するメソッド。
* CSVファイルが新しく更新された場合にはそのCSVのデータを読み、既存のデータをそのまま使う場合には既存のデータをDBから探してくる

### def_data_fileaname
* `def_data` のメソッドと同様。
* こちらは、CSVファイルのデータではなく、ファイル名を同じプロセスで取得する。

### fetch_saved_data
* `def_data`でこのメソッドが呼ばれる。
* DBに保存されているデータまたはファイル名を取得するメソッド。

### read_csv_data
* `def_data`でこのメソッドが呼ばれる。
* アップロードされたCSVのデータを読み込む。
* SJISでエンコードされたCSVのファイルのみに対応している。
* SJISで読み込んだデータはUTF-8に変換されてDBに保存される。

### search_index
* 定義書の検索をするときに用いるインデックスを作成するメソッド。
* 定義書に含まれる文字列を全て結合させている。


# 4.使用マニュアル(説明書)
利用者はこの4章の使用マニュアルを読むだけで、QIDBのシステムが提供する機能をすべて理解できる。都合上スクリーンショットを載せることができないので、文字だけの説明にとどめる。  

## 4.1 QI定義書のDB登録
[/login](http:///qi.med.kyoto-u.ac.jp/login)からBasic認証を行い、管理者権限を得る。
[/definitions/new](http://qi.med.kyoto-u.ac.jp/definitions/new)で提供されるWebインターフェイスを使って、QI定義書の登録ができる。  
定義書の内容をフォームに入力して、画面下部の緑色の「作成」ボタンを押すと、DBに定義書を登録することができる。  
入力に際して注意事項を以下に記す。

* 「必要なデータセット」の項目で、複数のデータセットが必要な場合には、セレクトボックス下にある緑色の`+`ボタンを押すことで、セレクトボックスを増やすことができる。
	* セレクトボックスの内容を`["DPC様式1", "DPC様式1", "E/Fファイル"]`のように重複して選択してしまった場合にも、実際にDBに登録されるのは`["DPC様式1", "E/Fファイル"]`のデータのみである。
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

* 「リスク調整因子の定義」の部分では、「あり」を選択することで、その定義の詳細を入力するフォームが現れるので、詳細情報を入力する必要があれば、そちらに入力する。
* 「測定上の限界/解釈上の注意」や「参考値」などのtext_areaのフィールド(フォーム右下で枠の大きさを変更できるもの)では改行が"改行"として扱われるので、定義書内で改行されている部分はそのままの形で入力する。
* 「指標の表示順」は `xx_xx` (`x` は 0~9 の数値)の形式で入力する。


## 4.2 QI定義書DBのWebAPI利用
* QIDBのWebAPIは[/api/v1/definitions?project=qip&id=2021](http://qi.med.kyoto-u.ac.jp/api/v1/definitions?project=qip&id=2021)のようなエンドポイントで提供される。
* 返されるデータはJSON形式のデータである。
* 上のリクエストでは、QIPの指標番号2021の指標情報が取得できる。
* QIPのすべての指標は `id` パラメータを使用せず、 `/api/v1/definitions?project=qip` のエンドポイントで取得可能

| リクエストパラメータ | 型 | 備考 |
|:--:|:--:|:--:|
| project | 文字列 | 選択肢は下部に記載 |
| id | 数値 | 指標番号 (`id`を指定する場合には、`project`パラメータが必須)|

* `project` の選択肢
	* qip: QIP
	* jha: 日病
	* jmha: 全自病協
	* sai: 済生会
	* min: 全日本民医連
	* jma: 日本医師会
	* ajha: 全日病
	* nho: 国病
	* rofuku: 労災
	* jamcf: 慢医協
	
	
#### レスポンスパラメータの説明
|変数名|意味|型|詳細|
|:--|:--|:--|:--|
|projects|プロジェクト名と指標番号一覧|JSON|下のnameとnumberを複数持つ|
|name|プロジェクト名|文字列|[QIP, 日病, 全自病協, 済生会, 全日本民医連, 日本医師会, 全日病, 国病, 労災, 慢医協] のいずれか|
|number|指標番号|文字列||
|years|年度|文字列|2008から2014の偶数年が複数個|
|group|指標群|文字列|例: 脳卒中|
|name|名称|文字列||
|meaning|意義|文字列||
|dataset|必要なデータセット|文字列の配列|[DPC様式1, Fファイル, EFファイル, Dファイル, その他(自由記述)]から複数個|
|def_summary|定義の要約|JSON|{def_numer, def_denom}を子にもつ| 
|def_summary_denom|分母の定義の要約|文字列|| 
|def_summary_numer|分子の定義の要約|文字列||
|definitions|指標の定義/算出方法|JSON||
|def_numer|分子の定義|JSON|例:{explanation=>"レセ電コードになんとか", data=>[{"薬価基準コード7桁"=>["3399007", "3399100", "3999411", "2190408"]} を子に複数持つ|
|def_demon|分母の定義||JSON同上|
|drag_output|薬剤一覧の出力|真偽値|true または false|
|factor_definition|リスクの調整因子の定義|真偽値|true または false| 
|factor_definition_detail|定義の詳細|文字列|
|method|指標の算出方法|JSON|{method_explanation, method_unit} を子に持つ
|method_explanation|算出方法の説明|文字列||
|method_unit|単位|文字列||
|order|結果提示時の並び順|文字列|'asc' または 'desc'
|notice|測定上の限界/解釈上の注意|文字列||
|standard_value|参考値|文字列||
|references|参考資料|文字列の配列|| 
|review_span|定義見直しのタイミング|文字列||
|indicator|指標タイプ|文字列|[割合, リスク調整, 平均値, 中央値]のいずれか|
|created_at|作成日|文字列||
|change_logs|変更履歴|JSON|{editor, message}を複数子に持つ|
|editor|変更者|文字列||
|message|変更時のメッセージ|文字列||


## 4.3 QI定義書の閲覧
* 定義書は[/definitions/qip/2021](http://qi.med.kyoto-u.ac.jp/definitions/qip/2021)のようなURLでその内容を閲覧することができる。
* `/definitions/xxxx/yyyy`の`xxxx`の部分で、閲覧したいプロジェクト名を指定し、yyyyの部分で定義書の指標番号を指定する。
* 英語情報も含まれた定義書を見る場合には最後に `/en` をつけたURL、例えば [/definitions/qip/2021/en](http://qi.med.kyoto-u.ac.jp/definitions/qip/2021/en) にアクセスする。
* [/definitions/table](http://qi.med.kyoto-u.ac.jp/definitions/table) では定義書の概要一覧をテーブル形式で見ることができ、これの英語版は [/definitions/table_en](http://qi.med.kyoto-u.ac.jp/definitions/table_en) で見れる。

## 4.4 QI定義書の検索
* 定義書の検索機能は [/](http://qi.med.kyoto-u.ac.jp/) で行うことができる。
* この検索システムで検索出来る範囲は、定義書に含まれる文字列すべてである。
* キーワードを「大動脈バルーンパンピング法　人工心肺」と入力した場合には「大動脈バルーンパンピング法」と「人工心肺」の文字列が共に含まれるAND検索で行われる。
* 検索結果の太字部分、例えば`指標群: 脳卒中　整理番号: 0548`の部分をクリックすることで、その定義書の閲覧ページへ移動することができる。

## 4.5 QI定義書の編集
* 定義書の編集には、4.1と同様に管理者の権限が必要になるのでログインをする。
* プロジェクト名とその指標番号、変更者と変更メッセージは必須入力項目で、それが抜けていると更新ができない。

## 4.6 QI定義書のpdf出力
* [/definitions/qip/2021/sheet.pef](http://qi.med.kyoto-u.ac.jp/definitions/qip/2021/sheet.pdf)からダウンロードできる。
  * 4.3と同じように、プロジェクト名と指標番号を指定する。
* 複数の定義書をダウンロードしたい場合には、[/definitions/select](http://qi.med.kyoto-u.ac.jp/definitions/select)からダウンロードしたい定義書を選択することで、複数の定義書を1つのPDFとしてダウンロードすることができる。

## 4.7 QI定義書のCSV出力
* [/download_csv](http://qi.med.kyoto-u.ac.jp/download_csv)からすべての定義書のCSVデータをダウンロードすることができる。

## 4.8 QI定義書登録時のCSV入力
* 初回デプロイ時に、定義書の骨子となるデータ(プロジェクト/指標群/定義書表題/分母/分子/意義)を一括で取り込む機能である。
* 取り込みの様式は、CSV ファイルで、文字コードは UTF-8 である。
* ファイルの中身は以下のように、列名とカラムが並んでいるべきである。

```
qip,指標群,定義書表題,分母,分子,意義
123,呼吸器系,~症例の割合,~の症例,~の症例,人助け
54,...
```

# 5.保守マニュアル(開発者向け)
## 5.1 開発環境
QIDBに使用している、ソフトウェアとそのバージョン等を記載する。

### IPアドレス
* qi.med.kyoto-u.ac.jp

### Webサーバー
* Nginx

### アプリケーションサーバー
* Unicorn

### アプリケーション関連
* ruby 2.4.6 (rbenvにてインストール)
* MongoDB shell version: 2.6.6
* Rails 5.2.3
	* Railsで使用しているgemのバージョンは`/opt/rails/QIDB/current`で`$ bundle list`により確認可能。

### サーバー環境
* `/etc/sysconfig/iptables`にて通信を許すポートを制限
* `/etc/nginx/.htpasswd` にBasic認証の設定ファイル
* `/etc/nginx/nginx.conf` にNginx全体の設定、`/etc/nginx/conf.d/default.conf`にQIDBのアプリケーションの設定。
* MongoDBとNginxとunicornはサーバー再起動後も自動的に立ち上げるように設定済み

## 5.2 開発手順
* バージョン管理はGitで行っている
* ソースコードは[伊藤のGitHub](https://github.com/showwin/QIDB)においてあり、開発の流れとしては以下が望ましい。
	1. GitHubからローカルにcloneする
	2. 対応する Issue がある場合には ID に `t` をつけたブランチ名、例えば `t123` を作成する。
	3. 機能開発の場合には、その機能のテストコードも追加する。
	2. 開発ブランチを`git@github.com:showwin/QIDB.git`にpushする
	3. プルリクエストを作成してコードに問題がないかどうか、他の人にコードレビューをしてもらう
	4. 問題がなければ、プルリクエストをmasterブランチにマージ
	5. サーバーにデプロイしたい場合には、`release`ブランチにmasterブランチをマージして、GitHubにpushすることでCircleCIから自動でサーバーにデプロイされる。


## 5.3 アップデート
脆弱性がないアプリケーションを保つために、5.1で示したソフトウェアは常に最新のバージョンを使用することが望ましい。  
しかし、Railsの(メジャーアップデートの)バージョンを上げるとアプリケーションが動かなくなることがあるので、マイナーアップデートのみの適用が望ましい。現状は5.2.3を使用しているので、5.2.x系のアップデートは常に取り入れ、6.0.xにはアップデートしない方がよい。  

使用しているgemに関しても、できるだけ最新のバージョンを使用することが望ましいが、`1.2.3`から`2.0.0`などのメジャーアップデートの場合には、アプリケーションが動かなくなることがあるので、
Rails自身を含めたgemのアップデートの際にはgitで別branchを切ってから作業をするのがよい。

## 5.4 Docker 開発環境
開発者がそれぞれ同じ環境で開発できるように Docker を使用する。
環境構築の方法については GitHub の [ここ](https://github.com/showwin/QIDB/pull/103#issuecomment-152819128) にまとめてあるので、参考にすると良い。Windows 環境の場合には [こちら](https://github.com/showwin/QIDB/issues/118) も役立つ。
