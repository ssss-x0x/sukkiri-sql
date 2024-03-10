CREATE TABLE cow_identifications (
    id CHAR(4) PRIMARY KEY,
    date_of_birth DATE,
    sex_code CHAR(1),
    mother_id CHAR(4),
    breed_code CHAR(2),
    prefecture CHAR(20)
);

CREATE TABLE cow_counts (prefecture CHAR(20) counts INT);

-- 1. 飼育件別に飼育頭数をカウントし、その結果をcow_countsテーブルに挿入する
INSERT INTO
    cow_counts (prefecture, counts)
SELECT
    prefecture,
    COUNT(*)
FROM
    cow_identifications
GROUP BY
    prefecture;

-- 2. 飼育頭数の多い順に3つの都道府県で飼育されている牛のデータを個体テーブルから抽出する
SELECT
    prefecture AS '都道府県',
    id AS '個体識別番号',
    CASE
        (sex_code)
        WHEN '1' THEN '雄'
        WHEN '2' THEN '雌'
        ELSE '不明'
    END AS '雌雄',
FROM
    cow_identifications
WHERE
    prefecture IN (
        SELECT
            prefecture
        FROM
            cow_counts
        ORDER BY
            counts DESC
        LIMIT
            3 -- もしくは　OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
    );

-- 3. 母牛が乳用種である牛のデータを個体テーブルから抽出する
SELECT
    id AS '個体識別番号',
    CASE
        (breed_code)
        WHEN '01' THEN '乳用種'
        WHEN '02' THEN '肉用種'
        WHEN '03' THEN '交雑種'
        ELSE '不明'
    END AS '品種',
    date_of_birth AS '出生日',
    mother_id AS '母牛識別番号'
FROM
    cow_identifications
WHERE
    mother_id IN (
        SELECT
            id
        FROM
            cow_identifications
        WHERE
            breed_code = '01'
    );