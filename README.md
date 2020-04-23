# README

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