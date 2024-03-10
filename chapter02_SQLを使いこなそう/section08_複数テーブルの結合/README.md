# 複数テーブルの結合

- 今までの章だと 1 テーブルで管理していた家計簿テーブル

```
CREATE TABLE house_account_books (
    date DATE,
    category VARCHAR(20),
    memo VARCHAR(100),
    expenses VARCHAR(20)
    deposit INT,
    withdraw INT
);
```

- …を、家計簿テーブルと費目テーブル・経費区分の 3 つに分離することができる。
- データを完全・確実・高速に取り扱いやすくなる
- 複数のテーブルに分割したデータを関連づけて管理・利用できるデータベースのことをリレーショナルデータベースと呼ぶ。

```
-- 家計簿
CREATE TABLE house_account_books (
    date DATE,
    category_id INT,
    memo VARCHAR(100),
    expenses_id INT,
    deposit INT,
    withdraw INT,
);

-- 費目
CREATE TABLE categories (
    id INT PRIMARY KEY, -- ここで家計簿テーブルと結合できる
    name VARCHAR(20),
    remarks VARCHAR(100),
    expenses_id INT
);

-- 経費区分
CREATE TABLE expenses (
    id INT PRIMARY KEY, -- ここで費目テーブルと結合できる
    name VARCHAR(20)
)
```

## テーブルの結合

###　内部結合

- 結合条件を満たす行をつなぐことを結合と呼ぶ。
- DBMS は左テーブルを 1 行ずつ処理していく際に、左の行につなぐべき右テーブルの行はどれか？を繰り返し SELECT 実行をしている。
- 結合条件列が重複する場合は、左テーブルの行を複製して結合するので、結果表の行数は元の左テーブルの行数より増える。
- 結合条件列が合致しない場合・左テーブルの結合条件のカラムが NULL の場合は、結合結果から左の行は消滅する。

```
SELECT カラム
FROM 左テーブル JOIN 右テーブル ON 両テーブルの結合条件
-- INNER JOIN とも書ける
```

### 外部結合

> 結合条件列が合致しない場合・左テーブルの結合条件のカラムが NULL の場合

- この場合に INNER JOIN の場合は結合結果から行が消えてしまうが、必ず出力したい場合は 外部結合（LEFT JOIN）を用いる。
- `テーブル名.カラム名` で明示的にどちらのテーブルのどのカラムを抽出したいのかを明示的に指定できる。

```
SELECT
    左テーブル.カラム,
    右テーブル.カラム
    FROM 左テーブル
    LEFT JOIN 右テーブル
    ON 両テーブルの結合条件
```

### その他の外部結合

- 右外部結合: 右テーブルの全魚を必ず出力する

```
SELECT *
    FROM 左テーブル
    RIGHT JOIN 右テーブル　-- RIGHT OUTER JOIN とも書ける
    ON 結合条件;
```

- 完全外部結合: 左右テーブルの全行を必ず出力する

```
SELECT *
    FROM 左テーブル
    FULL JOIN 右テーブル　-- FULL OUTER JOIN とも書ける
    ON 結合条件;

-- MySQLでは FULL JOINを使えないのでUNIONを使って同等の処理を実現する。
SELECT カラム
    FROM 左テーブル
    LEFT JOIN 右テーブル
    ON 両テーブルの結合条件
    UNION
    SELECT カラム
        FROM 左テーブル
        RIGHT JOIN 右テーブル
        ON 両テーブルの結合条件;
```

### 3 テーブル以上の結合

3 テーブル以上の結合は、3 テーブルが一気に結合されるわけではなく、1 テーブルずつ結合処理が行われていく。

```
SELECT
    date,
    categories.name,
    expenses.name
FROM
    house_account_books
    INNER JOIN categories ON house_account_books.category_id = categories.id
    INNER JOIN expenses ON categories.expenses_id = expenses.id
```

### 副問い合わせの結果との結合

表形式のデータを抽出する副問い合わせも JOIN に含めることができる。

```
SELECT
    date,
    temp_categories.name
FROM
    house_account_books
    INNER JOIN (
        SELECT
            *
        FROM
            categories
        WHERE
            expenses_id = 1
    ) AS temp_categories ON house_account_books.category_id = temp_categories.id
```

### 同じテーブル同士を結合

- 自己結合・再起結合と呼ぶ。
- 同じテーブルの行同士が関連している場合に見やすくできる。

```
-- 家計簿テーブルだったら、 「1/10 パパに100円貸した」「1/12 パパに100円返してもらった 関連日付 1/10」の行同士を結合するイメージ
SELECT
    house_account_books.date,
    house_account_books.memo,
    house_account_books.relation_date
    house_account_books_rel.memo
FROM
    house_account_books
    LEFT JOIN  house_account_books AS   house_account_books_rel ON house_account_books.relation_date = house_account_books_rel.date;
```
