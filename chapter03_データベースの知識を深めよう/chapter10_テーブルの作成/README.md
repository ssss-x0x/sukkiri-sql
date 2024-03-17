# テーブルの作成

## SQL 命令の分類

### データベースにデータの出し入れを指示する SQL

#### DML

参考: chapter01

- データ操作言語
- SELECT, UPDATE などデータの格納や取り出し・更新・削除などの命令

#### TCL

参考: chapter03 > section09

- トランザクション制御言語
- SET TRANSACTION, COMMIT などトランザクションの開始・終了の命令

### データの出し入れを安全にできるように、必要なテーブルの準備や設定を指示する SQL

#### DDL

- データ定義言語
- CREATE, ALTER など、テーブルなどの作成や削除・各種設定の命令
- カラムに制限をかけて CREATE TABLE することで人為的な操作ミス・入力ミスを防ぐことができる。（口座の「入金額」にマイナスが入る、「入金日」が未入力になる…など）
- ロールバックできない DB もある。（MySQL はできない）
  [参考:DDL をロールバックする](https://zenn.dev/sayu/articles/58d6abfe33759f)
- テーブルの全行を削除する場合には TRUNCATE が利用されることがあるが、厳密には削除ではなくテーブルの初期化。テーブルを一度 DROP して再度 CREATE するイメージ。

```
-- テーブルを作成
CREATE TABLE テーブル名 (
    id INTEGER PRIMARY KEY, -- 主キー制約(ユニークかつNOT NULLである値) ,
    カラム名1 データ型 DEFAULT デフォルト値 NOT NULL, -- NULLを禁止する
    カラム名2 データ型 DEFAULT デフォルト値 CHECK (カラム名2 >= 0), -- カラム名2が0以上のみ可
    カラム名2 INTEGER UNSIGNED DEFAULT デフォルト値, -- 0以上の整数
    カラム名3 データ型 UNIQUE -- ユニーク制約
    ...
    );

-- 存在しない場合のみテーブルを作成
CREATE TABLE IF NOT EXISTS テーブル名 (...)

-- テーブルを操作する 例: カラム追加
ALTER TABLE テーブル名 ADD COLUMN カラム名 データ型 DEFAULT デフォルト値;

-- テーブルを削除
DROP TABLE テーブル名;

-- 存在する場合のみテーブルを削除
DROP TABLE IF EXISTS テーブル名;
```

#### DCL

- データ制御言語
- GRANT, REMOVE など、DML や DDL の利用に関する許可や禁止を設定する命令
- DB によっては COMMIT などが DCL に分類されるケースもある

```
-- 権限を設定する
GRANT 権限名 TO ユーザー名;

-- 権限を除去する
REVOKE 権限名 FROM ユーザー名;
```

## 参照整合性を保とう

- 参照整合性 = 外部キーが指し示す先にあるべき行が存在してリレーションシップが成立していること。
- 参照先の行が存在しない状態を「参照整合性の崩壊」と言い、絶対に避けなければならない。
- データ操作時に参照整合性を崩壊させる操作をしようとした際に、強制的に処理を中断させる制約を「外部キー制約」と呼ぶ。

```
CREATE TABLE house_account_books(
    date DATE NOT NULL,
    category_id INTEGER REFERENCE categories(id), -- 外部キー制約を入れる
    memo VARCHAR(100) DEFAULT '不明' NOT NULL,
    ...
);

CREATE TABLE house_account_books(
    date DATE NOT NULL,
    category_id INTEGER,
    memo VARCHAR(100) DEFAULT '不明' NOT NULL,
    ...
    FOREIGN KEY(category_id) REFERENCES categories(id) -- という書き方もできる
);

```

### 参照整合性の崩壊を引き起こすデータ操作

1. 他の行から参照されている行を削除する
1. 他の行から参照されている行の主キーを変更してしまう
1. 存在しない行を参照する行を追加する
1. 存在しない行を参照する行を更神する
