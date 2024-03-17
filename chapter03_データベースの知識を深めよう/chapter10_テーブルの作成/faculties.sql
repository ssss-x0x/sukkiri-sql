-- 10-2 元のCREATE文を修正する
CREATE TABLE faculties(
    id CHAR(1),
    -- 学部を一意に特定する文字
    name VARCHAR(20),
    -- 学部の名前 必須、重複不可
    memo VARCHAR(100) -- 特に無い場合は'特になし'を設定する
);

-- 修正後
CREATE TABLE faculties(
    id INTEGER PRIMARY KEY AUTO INCREMENT,
    -- 学部を一意に特定する文字
    name VARCHAR(20) UNIQUE NOT NULL,
    -- 学部の名前 必須、重複不可
    memo VARCHAR(100) DEFAULT '特になし' NOT NULL -- 特に無い場合は'特になし'を設定する
);

-- 10.3 学生テーブルを作成する
CREATE TABLE students (
    id CHAR(8) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    birth_day DATE NOT NULL,
    blood_type CHAR(2) CHECK(
        blood_type IN ('A', 'B', 'O', 'AB')
        OR blood_type IS NULL
    ),
    faculty_id INTEGER REFERENCES faculties(id),
);

-- 10.4 参照整合性を崩す恐れがあるとしてエラーになる操作
/*
 1. 学生テーブルのデータを学部テーブルに存在しない学部IDで登録・更新する
 2. 学生テーブルから参照されている学部テーブルの学部IDを削除する
 */
-- 10.5 理学部（R）を廃止して工学部（K）に移行するマイグレーションクエリを作成する
BEGIN;

INSERT INTO
    faculties (id, name, memo)
VALUES
    ('K', '工学部', '特になし');

UPDATE
    students
SET
    faculty_id = 'K'
WHERE
    faculty_id = 'R';

DELETE FROM
    faculties
WHERE
    id = 'R';

COMMIT;