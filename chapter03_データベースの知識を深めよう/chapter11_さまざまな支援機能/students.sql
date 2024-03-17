-- 11.2 学生テーブルを作成する
CREATE students (
    id CHAR(8) PRIMARY KEY,
    -- 学籍ID
    name VARCHAR(30) NOT NULL,
    -- 名前
    birth_day DATE NOT NULL,
    -- 生年月日
    blood_type CHAR(2) CHECK(
        blood_type IN ('A', 'B', 'O', 'AB')
        OR blood_type IS NULL
    ),
    -- 血液型
    faculty_id INTEGER REFERENCES faculties(id),
    -- 学部ID
    order_no: INTEGER AUTO INCREMENT -- 並び順
);

-- 学部テーブルを作成する
CREATE faculties (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
);

/**
 * 11.2-1 インデックスを作成することが有効な列
 * 名前・学部ID
 */
-- 11.2-2 ビューを作成するSQL文
CREATE VIEW students_view AS
SELECT
    student.id,
    student.name,
    student.birth_day,
    student.blood_type,
    student.faculty_id,
    faculty.name AS faculty_name
FROM
    students
    INNER JOIN faculties ON students.faculty_id = faculties.id;

-- 11.2-3 学生情報を追加するSQL
CREATE SEQUENCE ISTD;

INSERT INTO
    students (
        id,
        name,
        birth_day,
        blood_type,
        faculty_id,
        order_no
    )
VALUES
    (
        'B1101022',
        '古島 進',
        '2002-02-12',
        'A',
        'K',
        (
            SELECT
                NEXTVAL('ISTD')
        )
    );