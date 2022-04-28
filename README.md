# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

# テーブル設計
## 必要機能

(1)ユーザー管理機能
(2)冷蔵庫商品管理機能
(3)食材寄付機能
(4)献立提案機能

## Users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------  | -----------               |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| family_type_id     | integer |                           |
| eatout_freq_id     | integer |                           |
| appetite_id        | integer |                           |

### Association :Users

- has_many :fridges
- has_many :donates

## Fridges テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| fridge_title     | string     | null: false                    |
| description      | text       | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association :Fridges

- belongs_to  :user
- has_many    :tags, through fridge_tags
- has_one     :food

## Fridge-tags テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| fridge           | references | null: false, foreign_key: true |
| tag              | references | null: false, foreign_key: true |

### Association :Fridge-tags

- belongs_to  :fridge
- belongs_to  :tag

## Tagsテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| name             | string     | null: false |

### Association :Tags

- has_many    :fridges, through fridge_tags

## Foods テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| fridge_space_id  | integer    | null: false                    |
| food_title       | integer    | null: false                    |
| number_title     | integer    | null: false                    |
| purchase_date    | date       | null: false                    |
| expiry_date      | date       | null: false                    |
| price            | integer    | null: false                    |
| give_id          | integer    |                                |
| fridge           | references | null: false, foreign_key: true |

### Association :Foods

- belongs_to  :fridge
- has_one     :donate

## Donates テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| food             | references | null: false, foreign_key: true |

### Association :donates

- belongs_to  :user
- has_one     :address

## Address テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | string     | null: false                    |
| prefecture_id       | integer    | null: false                    |
| city                | string     | null: false                    |
| house_number        | string     | null: false                    |
| build_number        | string     |                                |
| phone_number        | string     | null: false                    |
| donate              | references | null: false, foreign_key: true |

### Association : purchases

- belongs_to : donate


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
