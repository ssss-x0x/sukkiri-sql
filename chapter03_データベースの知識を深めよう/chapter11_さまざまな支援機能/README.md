# データベースをより速くする

## インデックスの作成・削除

- データベース内のテーブルに対して、本の「索引」と似たものをつけることができるのが「インデックス」。
- 指定したカラムに対してインデックスを作り、インデックスが存在するカラムに対して検索を行うと、DBMS は自動的にインデックスの使用を試みる。
- インデックスを使用した検索は、インデックスがない場合よりも高速になる場合が多い。
- 使用したインデックスが実際に使用されているかは、SELECT の頭に `EXPLAIN` をつける

#### 参考

- https://dev.mysql.com/doc/refman/8.0/ja/explain.html
- https://qiita.com/tsurumiii/items/0b70f1a1ee0499be2002

```
-- インデックスを作成する
CREATE INDEX インデックス名 ON テーブル名(カラム名);

-- インデックスを削除する
DROP INDEX インデックス名;
```

### インデックスの使用ケース

- 検索の WHERE 句

```
CREATE INDEX idx_memo ON house_account_books(memo);

-- インデックスが有効になるケース
SELECT * FROM house_account_books WHERE memo = '不明';
SELECT * FROM house_account_books WHERE memo LIKE '太郎の%';

-- インデックスが利用されないケース 部分一致検索・後方一致検索
SELECT * FROM house_account_books WHERE memo LIKE '%のお小遣い';
```

- ORDER BY 句

```
CREATE INDEX idx_category_id ON house_account_books(category_id);

SELECT * FROM house_account_books ORDER BY category_id;
```

- JOIN の結合条件に指定

```
CREATE INDEX idx_category_id ON house_account_books(category_id);

SELECT * FROM house_account_books
    JOIN categories ON house_account_books.category_id = categories.id;
```

### インデックスの注意点

- インデックスは索引情報を保存するためにディスク容量を消費する。
- テーブルのデータ変更時にインデックスの情報も書き換えが必要なため、 INSERT, UPDATE, DELETE 時のオーバーヘッドが増える。
- 検索の性能は向上するがデータの書き換え時の処理は増えてしまうため、むやみに増やさないようにする。
