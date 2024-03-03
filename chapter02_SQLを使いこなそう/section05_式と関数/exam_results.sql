CREATE TABLE exam_results (
    candidate_id VARCHAR(10) NOT NULL PRIMARY KEY,
    morning_score INT,
    afternoon1_score INT,
    afternoon2_score INT,
    essay_score INT,
    average_score INT
);

INSERT INTO
    exam_results(
        candidate_id,
        morning_score,
        afternoon1_score,
        afternoon2_score,
        essay_score,
        average_score
    )
VALUES
    (
        'SW1046',
        86,
        NULL,
        68,
        91,
        80
    ),
    (
        'SW1350',
        65,
        53,
        70,
        NULL,
        68
    ),
    (
        'SW1877',
        NULL,
        59,
        56,
        36,
        56
    );

-- 5.9 1: 現在登録されているデータを元にNULLの値を正しいものに修正する
UPDATE
    exam_results
SET
    afternoon1_score = average_score * 4 - (morning_score + afternoon2_score + essay_score)
WHERE
    candidate_id = 'SW1046';

UPDATE
    exam_results
SET
    essay_score = average_score * 4 - (
        morning_score + afternoon1_score + afternoon2_score
    )
WHERE
    candidate_id = 'SW1350';

UPDATE
    exam_results
SET
    morning_score = average_score * 4 - (
        afternoon1_score + afternoon2_score + essay_score
    )
WHERE
    candidate_id = 'SW1877';

-- 平均点の結果と合致するか確認する
SELECT
    candidate_id,
    (
        morning_score + afternoon1_score + afternoon2_score + essay_score
    ) / 4 AS average
FROM
    exam_results;

-- 5.9 2: 合格者のIDを抽出する
SELECT
    candidate_id AS 合格者ID
FROM
    exam_results
WHERE
    morning_score >= 60
    AND afternoon1_score + afternoon2_score >= 120
    AND essay_score >= 0.3 * (
        morning_score + afternoon1_score + afternoon2_score + essay_score
    );