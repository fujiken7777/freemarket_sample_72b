# README

# freemarket_sample_72b DB設計

# 実装機能紹介
### フリーマーケットのアプリケーションを作成しました。
### sho1374kの担当箇所
#### 新規登録
- sessionを用いたウィザード形式
- jquery validation pluginを用いたバリデーション
- deviseというgemを用いたユーザー登録
![validation mov](https://user-images.githubusercontent.com/61724976/80277528-7df7f600-872a-11ea-8e08-b8244fa06132.gif)
![souhusaki mov](https://user-images.githubusercontent.com/61724976/80277635-52c1d680-872b-11ea-8a68-e8247aaf6809.gif)

#### SNS認証
- omniauthというgemを用いたsns認証登録・ログイン(ローカル環境のみ)

##### 新規登録
![google mp4](https://user-images.githubusercontent.com/61724976/80277772-4d18c080-872c-11ea-92b8-502abaee74c6.gif)

##### ログイン
![logun mp4](https://user-images.githubusercontent.com/61724976/80277738-12168d00-872c-11ea-8be3-9303b27b894a.gif)

##### クレジットカード登録
![kureka mov](https://user-images.githubusercontent.com/61724976/80277801-84876d00-872c-11ea-8ba7-185a6c29b00f.gif)

#### パンくず機能
- gretelというgemを用いたパンくず表示機能
<img width="1433" alt="7cbe1ecd0be68f8efd83e14aa005b099 (1)" src="https://user-images.githubusercontent.com/61724976/80277675-987e9f00-872b-11ea-8782-00d73a049706.png">

<img width="1426" alt="e5d894b03b3e6c4f2ab05a9d217e2b75 (1)" src="https://user-images.githubusercontent.com/61724976/80277698-bcda7b80-872b-11ea-82f2-066ebb82260b.png">

##### 各個別詳細
![kobetu mov](https://user-images.githubusercontent.com/61724976/80277828-b4cf0b80-872c-11ea-84ef-dc3b16c96ebe.gif)

### 開発状況
- 開発環境
    - 開発言語：
        - Ruby/Ruby on Railsi
    - 開発ツール：
        - Gthub/AWS/Visual Studio Code
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