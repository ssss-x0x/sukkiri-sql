# 副問い合わせ（サブクエリ）

他の SQL の一部分として登場する SELECT 文を副問い合わせという。

```
-- 注文をしたことのある顧客一覧を取得する
SELECT
    *
from
    customers
WHERE
    id IN (
        SELECT <- ここ
            DISTINCT customer_id
        FROM
            orders
    );
```

## 副問い合わせの流れ

1. 副問い合わせの SQL が実行され、具体値を出力する
1. 副問い合わせ結果が元の SQL の中に置換されて、元の SQL を実行する

### 副問い合わせのパターン

1. スカラー: 単一の値 ... 単一の値の代わりとして副問い合わせの検索結果を用いる。  
   UPDATE クエリの SET 値や、集計関数を元の SQL で表示したい時に用いる。
1. ベクター: 一次元に並んだ値 ... 複数の値の代わりとして副問い合わせの検索結果を用いる。SELECT の WHERE 句の IN 条件で用いられることが多い。
1. マトリックス: 二次元に並んだ値・表 ... 表の値の代わりとして副問い合わせの検索結果を用いる。

### 注意点

取得した値の中に 1 つでも NULL が含まれる場合、比較結果はすべて NULL となってしまうため、以下のいずれかで対策する。

- 副問い合わせの検索条件に `IS NOT NULL` 条件を含める。
- COALESCE 関数を使って NULL を別の値に置き換える。

```
-- 過去に問い合わせをしたことがある顧客のメールアドレス一覧を出力する。

-- 副問い合わせの検索条件に `IS NOT NULL` 条件を含める。
SELECT
    name,
    mail
from
    customers
WHERE
    mail IN (
        SELECT
            DISTINCT mail
        FROM
            inquiries
        WHERE mail IS NOT NULL
    );

-- COALESCE関数を使う
SELECT
    name,
    mail
from
    customers
WHERE
    mail IN (
        SELECT
            DISTINCT COALESCE(mail, 'invalid') -- 項目がnullの場合 invalidの文字列を代用する
        FROM
            inquiries
    );
```

### 表の代わりに副問い合わせを用いる

副問い合わせの検索結果が複数行と複数のカラムからなる表形式の値となるパターン。  
SELECT 文の FROM 句や INSERT 文の条件などの記述することができる。

- 例 1: SELECT 文の FROM 句で用いるケース

```
-- 家計簿のメインテーブル・アーカイブテーブル全体の集計結果を取得する。
SELECT
    SUM(SUB.withdraw) AS 出金額合計
FROM
    (
        SELECT
            date,
            category,
            withdraw
        FROM
            house_account_books
        UNION
        SELECT
            date,
            category,
            withdraw
        FROM
            house_account_book_archives
        WHERE
            date BETWEEN '2023-12-01'
            AND '2023-12-31'
    ) AS SUB;
```

-　例 2: INSERT 文で使用する

```
-- 家計簿集計テーブルに出金額の集計結果を登録する
INSERT INTO
    house_account_book_analytics (
        category,
        withdraw_summary,
        withdraw_average,
        counts
    )
SELECT
    category,
    SUM(withdraw),
    AVG(withdraw),
    COUNT(*)
FROM
    house_account_books
WHERE
    withdraw > 0
GROUP BY
    category;
```

### 単独で処理できない副問い合わせは EXISTS を用いる

副問い合わせの内部から主問い合わせの表・カラムを利用する副問い合わせを `相関副問い合わせ` という。  
他のテーブルに値が登場する行のみを抽出したい場合などに利用する。

:::note-warn
主問い合わせがテーブルから行を絞り込む時に「各行で抽出の可否を判断するために副問い合わせを都度実行する」処理が行われるため、  
DB への負荷が大幅に増えるためなるべく避けるようにする。
:::

```
-- 家計簿テーブルで実際に使われている費目のみ、家計簿集計テーブルから抽出する

SELECT
    category,
    withdraw_summary
FROM
    house_account_book_analytics
WHERE
    EXISTS (
        SELECT
            *
        FROM
            house_account_books
        WHERE
            house_account_books.category = house_account_book_analytics.category
    );
```
