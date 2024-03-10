CREATE TABLE prices (
    model_code CHAR(3) PRIMARY KEY,
    model_name VARCHAR(20),
    price INT
);

CREATE TABLE rental_histories (
    id CHAR(4) PRIMARY KEY,
    model_code CHAR(3),
    days INT
);

/*
 1.車種コードがE01のレンタル日数 ✖ ️価格を計算するSQL
 8400 * 3 = 25200 
 
 2. 1日を超える日数レンタルされた車種を抽出するSQL 
 - E01,エコカー 
 - S01,軽自動車 
 - S02,ハッチバック 
 
 3.車種ごとのレンタル日数合計を抽出するSQL 
 - S01, 3 日
 - S02, 6 日
 - E01, 3 日
 
 -> 12日, 3件
 */