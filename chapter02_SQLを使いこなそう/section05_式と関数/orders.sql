CREATE TABLE orders (
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    order_id INTEGER PRIMARY KEY,
    -- AUTO_INCREMENTをしたい場合 PostgreSQLではSERIAL型を使う
    message VARCHAR(100),
    length INTEGER,
    font_code VARCHAR(1)
);

INSERT INTO
    orders (order_date, order_id, message, length, font_code)
VALUES
    ('2021-12-05', 101, 'Satou', NULL, 2),
    ('2021-12-05', 102, '鈴木 一郎', NULL, 3),
    ('2021-12-05', 113, '横浜 BASEBALL CLUB', NULL, 1),
    ('2021-12-08', 140, 'N.R.', NULL, NULL);

-- 問題5-3
-- 1. 刺繍文字数を求める
UPDATE
    orders
SET
    length = LENGTH(REPLACE(message, ' ', ''));

-- 2. 受注内容を一覧表示する
SELECT
    order_date AS 受注日,
    order_id AS 受注ID,
    length AS 文字数,
    CASE
        (font_code)
        WHEN '1' THEN 'ブロック体'
        WHEN '2' THEN '筆記体'
        WHEN '3' THEN '楷書体'
        ELSE '未指定'
    END AS フォント名,
    CASE
        (font_code)
        WHEN '1' THEN 100
        WHEN '2' THEN 150
        WHEN '3' THEN 200
        ELSE 100
    END AS 単価,
    CASE
        WHEN length > 10 THEN 500
        ELSE 0
    END AS 特別加工料
FROM
    orders
ORDER BY
    order_date ASC;

-- 3. 依頼内容を変更する
UPDATE
    orders
SET
    message = REPLACE(message, ' ', '★')
WHERE
    order_id = 113;