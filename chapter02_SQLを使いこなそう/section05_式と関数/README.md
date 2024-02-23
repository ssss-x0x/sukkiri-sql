# 式と関数

SQL では、単なるデータの出し入れだけでなく以下の機能も使うことができる。

- 式を用いることで列の値やリテラルを用いた四則演算
- 関数を用いた引数に応じた処理

## 式と演算子

### SELECT の結果で計算式を使う

- カラム名: 列の内容がそのまま出力される
- 計算式: 計算式の評価結果が出力される
- 固定値: 固定値（リテラル）がそのまま出力される

```
SELECT
*, -- カラム別の値
deposit * 1.1 AS 税込入金額, -- 計算式
'家計簿' AS 固定値サンプル -- 固定値
FROM house_account_books;
```

### INSERT 文での計算式の利用

```
INSERT INTO house_account_books (withdraw) VALUES (withdraw + 100);
```

### UPDATE 文での計算式の利用

```
UPDATE house_account_books SET withdraw = withdraw + 100;
```

## さまざまな演算子

### 基本的な算術演算子
