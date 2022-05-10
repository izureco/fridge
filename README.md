# アプリケーション名
冷蔵庫管理アプリケーション FRiDGE

# アプリケーション概要
- 冷蔵庫に入っている食材がシェアできる
- 登録された食材を元にオススメのレシピを提案してくれる
- 不要な食材を登録しておけば、必要としているユーザーに譲ることができる

# アプリケーション作成の背景
最も身近な奥さんに日常生活の課題をヒアリングしたところ、「日々の食材管理が面倒」という回答があった。家事を分担しているので、この課題は共感したことと、「冷蔵庫食材のシェアリング」という観点は、類似サービスが見つからなかったことから、開発することにした。

## ペルソナ
- 性別 : 女性
- 年齢 : 30代
- 背景 : 既婚, 10:00-18:00のパートタイマー
- 趣味 : 音楽鑑賞, SNS, 節約

## ペルソナを元に実装した機能
### <困りごと❶> 買い出しの際、自宅の冷蔵庫に何があったか覚えておらず、無駄なモノを買ってしまう。
<実装した機能>
- 冷蔵庫の食材を管理する機能
- 他ユーザーの冷蔵庫の食材を譲り受けられる機能

### <困りごと❷> 今ある食材から献立を考えるのが面倒。他の人がどんな食材を買って、やりくりしているか知りたい
<実装した機能>
- 冷蔵庫の食材を「シェア」できる機能
- 登録している冷蔵庫の食材から、レシピを提案する機能

# 要件定義
https://docs.google.com/spreadsheets/d/1oEpJ1GJASJOFnGSHlHrVNZ2_ndCOklUk9rih8poRjYs/edit?usp=sharing

# 実装した機能説明
- 冷蔵庫の登録画面
<!-- TODO : GIFを登録 -->
- 冷蔵庫の食材登録画面
<!-- TODO : GIFを追加 -->
- 他のユーザーの冷蔵庫を閲覧する
<!-- TODO : GIFを追加 -->

# 実装予定の機能
1. 食材の寄付機能
 - どのように実装しようとしているか??
2. タグ検索機能
 - 冷蔵庫のタグから、該当する冷蔵庫を一覧表示させる。

# 工夫したポイント
## 楽天レシピAPIと連動して、登録されている食材からレシピを表示
 - 「何を作ろう?」と悩んだとき、冷蔵庫に入っている食材から作れるレシピが提案される。
 - 1つの食材だけでなく、登録された複数の食材で作れるレシピが表示されることで、効率的な食材消費が可能に。
## 食材登録は、食材毎に「カテゴリ」に分けた
 - 全ての食材を一つのフォームで登録するのではなく、カテゴリに分けて登録させることで、その後の食材管理をしやすくした。
 <ペルソナの声>
 - 全ての食材を一括表示していると、お目当ての食材が探しづらい
 - 実際に献立を考えるときは、まず大カテゴリ(肉、魚、野菜)を絞るので、カテゴリ毎表示の方が、見やすい。

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

## 食材登録
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

