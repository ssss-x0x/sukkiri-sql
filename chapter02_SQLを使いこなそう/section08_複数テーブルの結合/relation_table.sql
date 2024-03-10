CREATE TABLE table_a (a1 SERIAL PRIMARY KEY, a2 INT);

CREATE TABLE table_b (b1 SERIAL PRIMARY KEY, b2 INT);

INSERT INTO
    table_a (a1, a2)
VALUES
    (1, 3),
    (2, 4);

INSERT INTO
    table_b (b1, b2)
VALUES
    (1, 2),
    (3, NULL);

/**
 1. table_aとtable_bのa1とb1が一致するレコードを取得するSQL
 1,3,1,2
 
 2. table_bのb2がtable_aのa1と一致するレコードを取得するSQL
 2,4,1,2
 
 3.  table_bのb2がtable_aのa1と一致するレコードを外部結合で取得するSQL
 2,4,1,2
 NULL,NULL,3,NULL
 
 4. table_aのa1とtable_bのb1を内部結合し、さらに table_aをtable_cとして table_bのb1とtable_cのa1が一致するレコードを取得するSQL
 1,3,1,2
 */