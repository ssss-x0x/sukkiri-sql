CREATE TABLE access_histories (
  id SERIAL PRIMARY KEY,
  is_exit CHAR(1) COMMENT '1: 退室済み, NULL: 入室中',
  name VARCHAR(255) COMMENT '社員名',
  access_date DATE NOT NULL,
  type CHAR(1) COMMENT '入室事由 1: メンテナンス, 2: リリース作業, 3: 障害対応 9: その他'
);

INSERT INTO
  access_histories (is_exit, name, access_date, type)
VALUES
  ('1', '山田一郎', '2021-12-01', '1'),
  ('1', '山田一郎', '2021-12-02', '1'),
  ('1', '山田一郎', '2021-12-03', '1'),
  ('1', '山田一郎', '2021-12-04', '1'),
  ('1', '山田一郎', '2021-12-05', '1'),
  ('1', '山田一郎', '2021-12-06', '1'),
  ('1', '山田一郎', '2021-12-07', '2'),
  ('1', '山田一郎', '2021-12-08', '1'),
  ('1', '山田一郎', '2021-12-09', '1'),
  ('1', '山田一郎', '2021-12-10', '1'),
  (NULL, '山田一郎', '2021-12-11', '3'),
  ('1', '山田ニ郎', '2021-12-07', '2'),
  ('1', '山田ニ郎', '2021-12-07', '3'),
  (NULL, '山田ニ郎', '2021-12-11', '3'),
  ('1', '山田三郎', '2021-12-01', '2'),
  ('1', '山田三郎', '2021-12-10', '1'),
  (NULL, '山田三郎', '2021-12-11', '3');

-- 問題6.2
--1
SELECT
  count(*) AS 入室人数
FROM
  access_histories
WHERE
  is_exit IS NULL;

-- 2
SELECT
  name AS 社員名,
  count(*) AS 入室回数
FROM
  access_histories
GROUP BY
  name
ORDER BY
  入室回数 DESC;

-- 3
SELECT
  CASE
    (type)
    WHEN '1' THEN 'メンテナンス'
    WHEN '2' THEN 'リリース作業'
    WHEN '3' THEN '障害対応'
    ELSE 'その他'
  END AS 入室事由,
  count(*) AS 入室回数
FROM
  access_histories
GROUP BY
  type
ORDER BY
  type;

-- 4
SELECT
  name AS 社員名,
  count(*) AS 入室回数
FROM
  access_histories
GROUP BY
  name
HAVING
  count(*) > 10;

-- 5
SELECT
  access_date AS 日付,
  count(name) AS 入室人数
FROM
  access_histories
WHERE
  type = '3'
GROUP BY
  access_date;