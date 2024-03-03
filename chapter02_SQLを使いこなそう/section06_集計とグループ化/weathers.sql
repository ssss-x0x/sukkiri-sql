CREATE TABLE weathers (
    id SERIAL PRIMARY KEY,
    city VARCHAR(255) NOT NULL,
    month INTEGER NOT NULL,
    precipitation INTEGER,
    max_temperature INTEGER,
    min_temperature INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO
    weathers (
        city,
        month,
        precipitation,
        max_temperature,
        min_temperature
    )
VALUES
    ('Tokyo', 1, 50, -9, 5),
    ('Tokyo', 2, 60, -10, 7),
    ('Tokyo', 3, 45, 15, 10),
    ('Tokyo', 4, 36, 18, 13),
    ('Tokyo', 5, 10, 20, 15),
    ('Tokyo', 6, 100, 25, 20),
    ('Tokyo', 7, 110, 38, 25),
    ('Tokyo', 8, 69, 40, 30),
    ('Tokyo', 9, 30, 37, 25),
    ('Tokyo', 10, 10, 25, 20),
    ('Tokyo', 11, 60, 20, 15),
    ('Tokyo', 12, 30, 15, 10),
    ('Osaka', 2, 80, -10, 7),
    ('Nagoya', 3, 70, 15, 10),
    ('Fukuoka', 4, 80, 18, 13),
    ('Sapporo', 5, 90, 20, 15);

-- 問題6-1 集計データを求める
-- 1
SELECT
    SUM(precipitation) AS 年間降水量合計,
    AVG(max_temperature) AS 年間最高気温平均,
    AVG(min_temperature) AS 年間最高気温平均
FROM
    weathers;

-- 2
SELECT
    city AS 都市名,
    month AS 月,
    AVG(precipitation) AS 年間降水量平均,
    AVG(max_temperature) AS 各月の最高気温平均,
    AVG(min_temperature) AS 各月の最低気温平均
FROM
    weathers
WHERE
    city = 'Tokyo'
GROUP BY
    city,
    month
ORDER BY
    month;

-- 3
SELECT
    city AS 都市名,
    AVG(precipitation) AS 降水量平均,
    MIN(max_temperature) AS 最も低かった最高気温,
    MAX(min_temperature) AS 最も高かった最低気温
FROM
    weathers
GROUP BY
    city;

-- 4
SELECT
    month AS 月,
    AVG(precipitation) AS 降水量平均,
    AVG(max_temperature) AS 最高気温平均,
    AVG(min_temperature) AS 最低気温平均
FROM
    weathers
GROUP BY
    month
ORDER BY
    month;

--5
SELECT
    city AS 都市名,
    month AS 月,
    MAX(max_temperature) AS 最高気温
FROM
    weathers
GROUP BY
    city,
    month
HAVING
    MAX(max_temperature) >= 38;

-- 6
SELECT
    city AS 都市名,
    month AS 月,
    MIN(min_temperature) AS 最低気温
FROM
    weathers
GROUP BY
    city,
    month
HAVING
    MIN(min_temperature) <= -10;