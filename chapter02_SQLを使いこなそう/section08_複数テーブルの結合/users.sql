-- 社員テーブル
CREATE TABLE users (
    id CHAR(8) PRIMARY KEY,
    name VARCHAR(40),
    birth_date DATE,
    department_id INT NOT NULL,
    boss_user_id CHAR(8),
    -- 上司がいない場合はNULL
    area_id INT NOT NULL
);

-- 部署テーブル
CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    head_office_id INT NOT NULL
);

-- 支店テーブル
CREATE TABLE areas (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    manager_id CHAR(8);

-- 1. 部署名が入った全社員の一覧表
SELECT
    users.id AS '社員番号',
    users.name AS '社員名',
    departments.name AS '部署名'
FROM
    users
    INNER JOIN departments ON users.department_id = departments.id;

-- 2. 上司の名前が入った全社員の一覧表
SELECT
    users.id AS '社員番号',
    users.name AS '社員名',
    boss.name AS '上司名'
FROM
    users
    LEFT JOIN users AS boss ON users.boss_user_id = boss.id;

-- 部署名と勤務地が入った社員一覧表
SELECT
    users.id AS '社員番号',
    users.name AS '社員名',
    departments.name AS '部署名',
    areas.name AS '勤務地'
FROM
    users
    INNER JOIN departments ON users.department_id = departments.id
    INNER JOIN areas ON users.area_id = areas.id;

-- 支店ごとの支店長名と社員数の一覧表
SELECT
    areas.id AS '支店コード',
    areas.name AS '支店名',
    manager.name AS '支店長名',
    COUNT(users.id) AS '社員数'
FROM
    areas
    INNER JOIN users AS manager ON areas.manager_id = manager.id
    INNER JOIN users ON users.area_id = areas.id;

-- 5. 上司と違う勤務地で働いている社員の一覧表
SELECT
    users.id AS '社員番号',
    users.name AS '社員名',
    user_areas.name AS '本人の勤務地',
    boss_areas.name AS '上司の勤務地'
FROM
    users
    INNER JOIN users AS boss ON users.boss_user_id = boss.id
    AND user_areas.area_id <> boss_areas.area_id
    INNER JOIN areas AS user_areas ON users.area_id = user_areas.id
    INNER JOIN areas AS boss_areas ON boss.area_id = boss_areas.id;