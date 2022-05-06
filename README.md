# アプリケーション名
冷蔵庫管理アプリケーション FRiDE

# アプリケーション概要
- 冷蔵庫

# アプリケーション作成の背景
## ペルソナ
## 必要機能

# 要件定義

# 実装した機能説明
- 冷蔵庫の登録画面
- 冷蔵庫の食材登録画面
- 他のユーザーの冷蔵庫を閲覧する

# 実装予定の機能
1. 食材の寄付機能
 - どのように実装しようとしているか??
2. 保存した食材を元に、楽天レシピAPIと連動して、献立を提案
 - どのように実装しようとしているか??
3. タグ検索機能
 - 冷蔵庫のタグから、該当する冷蔵庫を一覧表示させる。

# 工夫したポイント
- 
- 

# URL
https://fridge-izumi.herokuapp.com/

# テスト用アカウント
- Basic認証パスワード : admin
- basic認証ID : 1111
- メールアドレス : 
- パスワード : 

# 利用方法
## 冷蔵庫投稿
1. トップページのヘッダーからユーザーの新規登録を行う
2. 新規冷蔵庫作成ボタンから、冷蔵庫の内容を入力して登録する

## 冷蔵庫検索
1. 
2. 

# データベース設計
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

- has_many :boxes
- has_many :donates

## Boxes テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| box_title        | string     | null: false                    |
| description      | text       | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association :Boxes

- belongs_to  :user
- has_many    :tags, through box_tags
- has_one     :food

## Box-tags テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| box              | references | null: false, foreign_key: true |
| tag              | references | null: false, foreign_key: true |

### Association :Box-tags

- belongs_to  :box
- belongs_to  :tag

## Boxtagsテーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| tag_name         | string     | null: false |

### Association :Tags

- has_many    :boxes, through box_tags

## Foods テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| availability     | boolean    |                                |
| food_title       | string     | null: false                    |
| number_title     | integer    | null: false                    |
| purchase_date    | date       | null: false                    |
| expiry_date      | date       | null: false                    |
| price            | integer    | null: false                    |
| give_id          | integer    |                                |
| box              | references | null: false, foreign_key: true |

### Association :Foods

- belongs_to  :box
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

# 画面遷移図


# 開発環境

# ローカルでの動作方法

