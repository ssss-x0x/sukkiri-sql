# 検索結果の加工

SQL で SELECT による検索結果を得るまでの過程は２段階ある。

1. 通常の検索実行（抽出）
2. 検索結果を加工（並び替え・超副業の削除など）

## 検索結果を加工する主なキーワード

| キーワード     | 内容                                             |
| -------------- | ------------------------------------------------ |
| DISTINCT       | 検索結果から超副業を除外する                     |
| ORDER BY       | 検索結果の順序を並べかえる                       |
| OFFSET - FETCH | 検索結果から件数を限定して取得する               |
| UNION          | 検索結果に他の検索結果を足し合わせる             |
| EXPECT         | 検索結果から他の検索結果を差し引く               |
| INTERSEPT      | 検索結果とほかの検索結果で重複する部分を取得する |

### ORDER BY

- ORDER BY 句を伴わない SELECT では、各行をどの順序で返すか保証されない。

### OFFSET - FETCH

- 行数を限定して取得することができるのでページングなどに用いる。

```
SELECT * FROM テーブル名
    ORDER BY カラム名
    OFFSET 先頭から除外する行数 ROWS
        FETCH NEXT 取得行数 ROWS ONLY
```

## 集合演算子

構造が似ている複数テーブルに対して SELECT した内容を組み合わせたい場合は、集合演算子を活用することで 1 つの SQL 文で検索を行うことができる。  
データの行数を考慮してテーブルを分割した場合などに有効。

### UNION

- 2 つの SELECT 文を UNION で繋ぐと和集合を求めることができる。
- UNION 対象の検索結果の列・データ型を統一する必要がある。
- ORDER BY 句を併用する場合は 1 つ目の SELECT 文に記述した絡む名を指定する。

```
SELECT id AS primary_id, name FROM table_A
UNION
SELECT id, name FROM table_B
ORDER BY primary_id ASC;
```

### EXPECT | MINUS

- ある SELECT 文の検索結果に存在する行から、別の SELECT 文の検索結果に存在する行を差し引いた「差集合」を求めることができる。

```
SELECT id AS primary_id, name FROM table_A
EXCEPT (ALL)
SELECT id, name FROM table_B
ORDER BY primary_id ASC;
```

### INTERSECT

- 2 つの SELECT 文に共通する行を集めた「積集合」を求めることができる。
- どの順番で SELECT 文を記述しても結果は変わらない。
- INTERSECT ALL にすると重複行をまとめずに返す。
- NULL 同士をイコール とみなす。

```
SELECT name FROM table_A
INTERSECT
SELECT name FROM table_B
ORDER BY name ASC;
```
