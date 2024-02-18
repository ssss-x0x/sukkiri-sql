/*
 テーブル準備用クエリ
 
 CREATE TABLE house_account_books (
 date DATE,
 category VARCHAR(20),
 memo VARCHAR(100),
 deposit INT,
 withdraw INT
 );
 
 INSERT INTO
 house_account_books (date, category, memo, deposit, withdraw)
 VALUES
 ('2024-02-03', '食費', 'コーヒーを購入', 0, 380),
 ('2024-02-10', '給料', '1月の給料', 280000, 0),
 ('2024-02-11', '教養娯楽費', '書籍を購入', 0, 2800),
 ('2024-02-14', '交際費', '同期会の会費', 0, 5000),
 ('2024-02-18', '水道光熱費', '1月の電気代', 0, 7560),
 ('2022-02-25', '居住費', '3月の家賃', 0, 90000);
 
 */
-- 費目一覧の取得
SELECT
    DISTINCT category
FROM
    house_account_books;

-- 出金額で昇順となるよう並べ替えて取得する
SELECT
    *
FROM
    house_account_books
ORDER BY
    withdraw ASC;

-- 複数の列で並べ替える
SELECT
    *
FROM
    house_account_books
ORDER BY
    deposit DESC,
    withdraw DESC;

-- 列番号で並べ替えて同じ結果を取得できる（けど可読性めちゃくちゃ低いね）
SELECT
    *
FROM
    house_account_books
ORDER BY
    4 DESC,
    5 DESC;

-- 列番号は取得結果の列を元にして指定されるので、出力される列の順番が変わると並び替え結果も変わる
SELECT
    deposit,
    withdraw
FROM
    house_account_books
ORDER BY
    1 DESC,
    2 DESC;

SELECT
    withdraw,
    deposit
FROM
    house_account_books
ORDER BY
    1 DESC,
    2 DESC;