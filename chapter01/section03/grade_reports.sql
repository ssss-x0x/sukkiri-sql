-- 問3.3
CREATE TABLE grade_reports (
    student_id CHAR(4) PRIMARY KEY,
    student_name VARCHAR(20),
    law INT,
    economics INT,
    philosophy INT,
    information_theory INT,
    foreign_language INT,
    overall_grade CHAR(1)
);

INSERT INTO grade_reports (student_id, student_name, law, economics, philosophy, information_theory, foreign_language, overall_grade) VALUES
('S001', '織田信長', 77, 55, 80, 75, 93, NULL),
('A002', '豊臣秀吉', 64, 69, 70, 0, 59, NULL),
('E003', '徳川家康', 80, 83, 85, 90, 79, NULL);

SELECT * FROM grade_reports;

UPDATE grade_reports SET law = 85, philosophy = 67 WHERE student_id = 'S001';

UPDATE grade_reports SET foreign_language = 81 WHERE student_id IN ('A002', 'E003');

UPDATE grade_reports SET overall_grade = 'A' 
    WHERE law >= 80 
    AND economics >= 80 
    AND philosophy >= 80 
    AND information_theory >= 80 
    AND foreign_language >= 80;

UPDATE grade_reports SET overall_grade = 'B' 
    WHERE (law >= 80 OR foreign_language >= 80) 
    AND (economics >= 80 AND philosophy >= 80);
    AND overall_grade IS NULL;
    
UPDATE grade_reports SET overall_grade = 'D'
    WHERE law < 50 
    AND economics < 50
    AND philosophy < 50
    AND information_theory < 50
    AND foreign_language < 50
    AND overall_grade IS NULL;
    
UPDATE grade_reports SET overall_grade = 'C'
    WHERE overall_grade IS NULL;
    
DELETE FROM grade_reports 
    WHERE law = 0
    OR economics = 0
    OR philosophy = 0
    OR information_theory = 0
    OR foreign_language = 0;
     