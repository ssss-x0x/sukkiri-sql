CREATE TABLE email_addresses (
    email_address VARCHAR(255) NOT NULL PRIMARY KEY,
    -- メールアドレスは255文字まで
    country VARCHAR(50),
    residence_type CHAR(1),
    age INTEGER
);

INSERT INTO
    email_addresses (email_address, country, residence_type, age)
VALUES
    ('suzuki.takeshi@mailsample.jp', NULL, 'D', 51),
    ('philip@mailsample.uk', NULL, 'C', 26),
    ('hao@mailsample.cn', NULL, 'C', 35),
    ('marie@mailsample.fr', NULL, 'D', 43),
    ('hoa@mailsample.vn', NULL, 'D', 22);

-- 5.2.1 メールアドレスのドメイン末尾から国名を変換して登録する
UPDATE
    email_addresses
SET
    country = CASE
        WHEN email_address LIKE '%.jp' THEN 'Japan'
        WHEN email_address LIKE '%.uk' THEN 'United Kingdom'
        WHEN email_address LIKE '%.cn' THEN 'China'
        WHEN email_address LIKE '%.fr' THEN 'France'
        WHEN email_address LIKE '%.vn' THEN 'Vietnam'
        ELSE NULL
    END;

-- トリムした文字列を使うこともできる
UPDATE
    email_addresses
SET
    country = CASE
        SUBSTRING(
            TRIM(email_address),
            LENGTH(TRIM(email_address)) -1,
            2
        )
        WHEN 'jp' THEN 'Japan'
        WHEN 'uk' THEN 'United Kingdom'
        WHEN 'cn' THEN 'China'
        WHEN 'fr' THEN 'France'
        WHEN 'vn' THEN 'Vietnam'
        ELSE NULL
    END;

SELECT
    email_address,
    SUBSTRING(
        TRIM(email_address),
        LENGTH(TRIM(email_address)) -1,
        2
    ) AS trimming
FROM
    email_addresses;

-- 5.2.2,3 住居タイプと年代を変換して出力する
SELECT
    email_address AS メールアドレス,
    CONCAT(
        CASE
            WHEN age < 20 THEN '未成年'
            WHEN age BETWEEN 20
            AND 29 THEN '20代'
            WHEN age BETWEEN 30
            AND 39 THEN '30代'
            WHEN age BETWEEN 40
            AND 49 THEN '40代'
            WHEN age BETWEEN 50
            AND 59 THEN '50代'
            ELSE '60代以上'
        END,
        ':',
        CASE
            residence_type
            WHEN 'D' THEN '戸建て'
            WHEN 'C' THEN '集合住宅'
            ELSE '不明'
        END
    ) AS 属性
FROM
    email_addresses;