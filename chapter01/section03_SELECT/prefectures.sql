-- 問3-2
CREATE TABLE prefectures (
    code CHAR(2) NOT NULL,
    region VARCHAR(10),
    prefecture_name VARCHAR(20),
    capital_city VARCHAR(20),
    area INT
);

INSERT INTO prefectures (code, region, prefecture_name, capital_city, area) VALUES
('01', '北海道', '北海道', '札幌', 83424),
('02', '東北', '青森', '青森', 9645),
('03', '東北', '岩手', '盛岡', 15275),
('04', '東北', '宮城', '仙台', 7282),
('05', '東北', '秋田', '秋田', 11637),
('06', '東北', '山形', '山形', 9323),
('07', '東北', '福島', '福島', 13783),
('08', '関東', '茨城', '水戸', 6097),
('09', '関東', '栃木', '宇都宮', 6408),
('10', '関東', '群馬', '前橋', 6362),
('11', '関東', '埼玉', 'さいたま', 3798),
('12', '関東', '千葉', '千葉', 5158),
('13', '関東', '東京都', '新宿', 2188),
('14', '関東', '神奈川', '横浜', 2416);

SELECT * FROM prefectures
    WHERE prefecture_name LIKE '%川';
    
SELECT * FROM prefectures
    WHERE prefecture_name LIKE '%島%';
    
SELECT * FROM prefectures
    WHERE prefecture_name LIKE '愛%';

SELECT * FROM prefectures
    WHERE prefecture_name = capital_city;
    
SELECT * FROM prefectures
    WHERE prefecture_name != capital_city;
