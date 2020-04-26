# README
## 概要
プログラミングスクールTECH::EXPERTの最終課題でフリーマーケットサイトを作成しました。約1ヶ月間、3人チームでアジャイル開発を行いました。

### 開発状況
- 開発環境  
  - 開発言語：  
    - Ruby/Ruby on Railsi 
  - 開発ツール：  
    - Github/AWS/Visual Studio Code  
  - データベース：  
    - MySQL  

- 開発期間  
  - 開発期間：  
    - 28日間(3/30 ~ 4/24 )  
  - 平均作業時間：  
    - 10時間/1日  

- 開発体制  
  - 人数：  
    - 3人  
  - 開発方式：  
    - アジャイル型開発（スクラム）  
  - タスク管理：  
    - Trelloによるタスク管理  

- 動作概要  
  - 接続先情報  
  - URL：  
    - http://18.180.214.184/  
  - ID:  
    - team72b  
  - Pass:  
    - 4649  
  
# fujiken7777の担当箇所
## 商品出品機能
![product](https://user-images.githubusercontent.com/61737215/80297361-7b92ac00-87bd-11ea-8803-611df5227c24.gif)
- 商品情報を保存するProductテーブルと写真を保存するImageテーブルのレコードを1ページで作成するように実装。accepts_nested_attributes_forをmodelで定義し、1つのformで値を送れるように実装。
- 画像はcarrierwaveを使用し、複数枚投稿ができる。
- カテゴリーはancestryを用い、seedに記載した親・子・孫のカテゴリーデータをDBに保存している。
- カテゴリーは親カテゴリーを選択すると、子カテゴリー、孫カテゴリーのセレクトボックスが出現するよう非同期にて実装。
- その他の選択項目は、active_hashを用いモデル内にデータを保存している。
- バリデーションを設定し、必須項目が抜けていると登録できないようになっている。
```
<!-- 画像 -->
= form_for @product do |f|
          〜省略〜
  .hidden-content
    = f.fields_for :images do |image|
      = image.file_field :image, class: "hidden-field"
      %input{class:"hidden-field", type: "file", name: "product[images_attributes][1][image]", id: "product_images_attributes_1_image" }
```
```
<!-- カテゴリー -->
.select-wrap__box.parentn                   < 親カテゴリー >
  %select#parent.select-wrap__box--select
    %option{value: 0} 選択して下さい
    - @parents.each do |parent|
      %option{value: "#{parent.id}"} #{parent.main_name}
.child                                      < 子カテゴリー >
  %select#child.select-wrap__box--select
.grand_child                                < 孫カテゴリー >
  = f.collection_select(:category_id, [], :id, :main_name, {prompt: "選択して下さい"}, {class: 'select-wrap__box--select', id: "grand_child"})
```

- jQueryを用いて、登録した写真のプレビュー、写真の削除を非同期にて実装。
![product-image mp4](https://user-images.githubusercontent.com/61737215/80297420-b563b280-87bd-11ea-8226-51d65a0c1665.gif)

## 商品編集機能
![edit mp4](https://user-images.githubusercontent.com/61737215/80297439-e6dc7e00-87bd-11ea-8950-57d641be77d2.gif)
- 画像やカテゴリーの情報など、すでに登録されている商品情報は編集画面を開いた時点で、表示されるよう実装。
- 画像は1枚毎に差し替えが可能。
- バリデーションを設定し、必須項目が抜けていると登録できないようになっている。

## いいね機能
![いいね機能 mov](https://user-images.githubusercontent.com/61737215/80298325-1099a300-87c6-11ea-8ccb-c00890c06fee.gif)
- いいねボタン、カウントを非同期にて実装。
- likesテーブルを作成し、商品とユーザーの紐付けをすることで、どのユーザーがどの商品をいいねしたのか判別できる。
- 商品(products)テーブルにlikes_countカラムを追加することで、いいねの数が保存できる。
- マイページのいいね一覧ページからいいねした商品を確認できる。

## コメント投稿・削除機能
![comment mp4](https://user-images.githubusercontent.com/61737215/80297455-0ecbe180-87be-11ea-8621-c89a1239cdfc.gif)
- コメント投稿を非同期にて実装
- 自分のアイコンが表示できるようになっている。登録していない場合は共通のアイコン画像を表示。

## カテゴリ機能
![category mp4](https://user-images.githubusercontent.com/61737215/80297468-286d2900-87be-11ea-8253-296e6cc30715.gif)
- jQueryを用いて、カテゴリメニューの表示を行っている。

# freemarket_sample_72b DB設計
## usersテーブル 
|Column|Type|Options|
|------|----|-------|
|email             |string |null: false, default: ""|
|encrypted_password|string |null: false, default: ""|
|nickname          |string |null: false|
|user_image        |text   ||
|first_name        |string |null:false|
|last_name         |string |null:false|
|first_name_read   |string |null:false|
|last_name_read    |string |null:false|
|birthday          |date   |null: false|
|introduction      |text   ||
|phone_num         |integer|null: false, unique: true|
### Association
- has_many :products, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_one :address, dependent: :destroy
- accepts_nested_attributes_for :address
- has_many :card, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :like_products, through: :likes, source: :product
- has_many :sns_credentials, dependent: :destroy

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|zip_code     |string    |null: false|
|prefecture_id|integer   |null: false|
|city         |string    |null: false|
|address1     |string    ||
|address2     |string    ||
|user         |references|null: false, foreign_key: true|
### Association
- belongs_to :user, optional: true

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user       |references|null: false, foreign_key: true|
|card_id    |string    |null: false|
|customer_id|string    |null: false|
### Association
- belongs_to :user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|user         |references|null: false|
|product_name |string    |null: false|
|description  |text      |null: false, foreign_key: true|
|category_id  |integer   |null: false|
|brand        |string    |default: ""|
|condition    |references|null: false, default: 0|
|size         |references|null: false, default: 0|
|delivery_fee |references|null: false, default: 0|
|delivery_way |references|null: false, default: 0|
|delivery_date|references|null: false, default: 0|
|price        |integer   |null: false|
|prefecture   |references|null: false, default: 0|
|buyer_id     |integer   |foreign_key: true|
|likes_count  |integer   ||
### Association
- belongs_to :user
- has_many :main_categories
- has_many :images, dependent: :destroy
- accepts_nested_attributes_for   :images, allow_destroy: true
- has_many :comments, dependent: :destroy
- belongs_to_active_hash :condition, presence: true
- belongs_to_active_hash :size, presence: true
- belongs_to_active_hash :delivery_fee, presence: true
- belongs_to_active_hash :delivery_date, presence: true
- belongs_to_active_hash :delivery_way, presence: true
- belongs_to_active_hash :prefecture, presence: true
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false|
|image  |string    |null: false|
### Association
- belongs_to :product
- mount_uploader :image, ImageUploader

## main_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|product  |references||
|main_name|string    |null: false|
|ancestry |string    ||
### Association
- belongs_to :product
- has_ancestry

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|user   |references|null: false, foreign_key: true|
|text   |text      |null: false|
### Association
- belongs_to :user
- belongs_to :product

## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string    ||
|uid     |string    ||
|user    |references|foreign_key: true|
### Association
- belongs_to :user, optional: true, dependent: :destroy

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id   |string    ||
|product_id|string    ||
### Association
- belongs_to :product, counter_cache: :likes_count
- belongs_to :user