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
 
 -- アーカイブテーブルを作成する
 CREATE TABLE house_account_book_archives (
 date DATE,
 category VARCHAR(20),
 memo VARCHAR(100),
 deposit INT,
 withdraw INT
 );
 
 INSERT INTO
 house_account_book_archives (date, category, memo, deposit, withdraw)
 VALUES
 ('2023-12-10','給料','11月の給料',280000,0),
 ('2023-12-18','水道光熱費','水道代',0,4200),
 ('2023-12-24','食費','レストランみやび',0,5000),
 ('2023-12-25','居住費','1月の家賃支払い',0,80000),
 ('2024-01-10','給料','12月の給料',280000,0),
 ('2024-01-13','教養娯楽費','スッキリシネマズ',0,1800),
 ('2024-01-13','食費','新年会',0,5000),
 ('2024-01-25','居住費','2月の家賃支払い',0,80000);
 */
/*
 * ORDER BY
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

/*
 * OFFSET - FETCH
 */
-- 出金額の高い準から3行を取得
SELECT
    category,
    withdraw
FROM
    house_account_books
ORDER BY
    withdraw DESC OFFSET 0 ROWS
FETCH FIRST
    3 ROWS ONLY;

-- 3番目に高い出金額だけを取得する
SELECT
    category,
    withdraw
FROM
    house_account_books
ORDER BY
    withdraw DESC OFFSET 2 ROWS
FETCH FIRST
    1 ROWS ONLY;

-- LIMITでも抽出する行数を指定できる
SELECT
    category,
    withdraw
FROM
    house_account_books
ORDER BY
    withdraw DESC
LIMIT
    3;

/**
 * UNION 集合演算子
 */
SELECT
    category,
    deposit,
    withdraw
FROM
    house_account_books
UNION
SELECT
    category,
    deposit,
    withdraw
FROM
    house_account_book_archives
ORDER BY
    deposit,
    withdraw,
    category;

/**
 * EXCEPT 差集合を取得する
 * 1番目に指定されたクエリの結果から2番目に指定されたクエリの結果を除いた結果を取得する
 */
SELECT
    category
FROM
    house_account_books
EXCEPT
SELECT
    category
FROM
    house_account_book_archives;

/**
 * INTERSECT 共通部分を取得する
 */
SELECT
    category
FROM
    house_account_books
INTERSECT
SELECT
    category
FROM
    house_account_book_archives;