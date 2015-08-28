/******************************

データベースの作成

CREATE DATABASE <データベース名>;


テーブルの作成

CREATE TABLE <テーブル名>
(<列名1> <データ型> <この列の制約>,
 <列名2> <データ型> <この列の制約>,
 ...
 
 <このテーブルの制約1>, <このテーブルの制約2>,...... );
 
******************************/

CREATE TABLE Shohin
(shohin_id     CHAR(4)      NOT NULL,-- <= 無記入は不可(エラーを起こす)
 shohin_mei    VARCHAR(100) NOT NULL,
 shohin_bunrui VARCHAR(32)  NOT NULL,
 hanbai_tanka  INTEGER ,
 shiire_tanka  INTEGER ,
 torokubi      DATE ,
 PRIMARY KEY (shohin_id));
 
/*****************************
データ型

1. INTEGER（数値）型
	整数のみが入る（少数は入れられない）
	
2. CHAR(文字列型)
	CHAR(10)などのように最大文字数を指定して使う。
	CHAR(8)に'ABC'を代入したとき、'ABC     'という（スペース5つが後ろにつく）形で格納される。
	
3. VARCHAR(可変長文字列)型
	CHARと似ているが、VARCHAR(8)に'ABC'を代入したとき結果は'ABC'である（半角スペースで埋めない）。
	
4. DATE（日付型）
	日付を代入する。代入するときは'1998/10/4'のように ['']でくくること。
*****************************/


/*****************************
制約
1. NOT NULL (NOT NULL制約)
	無記入は不可(エラーを起こす)。

2. PRIMARY KEY（主キー制約）
	一つの行を特定できる（値が絶対に重複しない）列に主キーを当てることで、特定の行のデータを呼び出せる。
*****************************/


/*****************************
テーブルの削除と変更

1. テーブルの削除
	DROP TABLE <テーブル名>;
	※ 一度コマンドを打つと二度と戻らないので注意

2. 列の追加
	ALTER TABLE <テーブル名> ADD COLUMN <列の定義>;
	
3. 列の削除
	ALTER TABLE <テーブル名> DROP COLUMN <列名>;
*****************************/


/*****************************
データ登録

-- DML:データ登録
BEGIN TRANSACTION	<= 行の追加を開始

INSERT INTO <テーブル名> VALUES (<データ1-1>, <データ1-2>, ......);
INSERT INTO <テーブル名> VALUES (<データ2-1>, <データ2-2>, ......);
...

INSERT INTO <テーブル名> VALUES (<データn-1>, <データn-2>, ......);

COMMIT;	<= 行の追加を確定
******************************/


BEGIN TRANSACTION;

INSERT INTO Shohin VALUES ('0001', 'Tシャツ' ,'衣服', 1000, 500, '2009-09-20');
INSERT INTO Shohin VALUES ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO Shohin VALUES ('0003', 'カッターシャツ', '衣服', 4000, 2800, NULL);
INSERT INTO Shohin VALUES ('0004', '包丁', 'キッチン用品', 3000, 2800, '2009-09-20');
INSERT INTO Shohin VALUES ('0005', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15');
INSERT INTO Shohin VALUES ('0006', 'フォーク', 'キッチン用品', 500, NULL, '2009-09-20');
INSERT INTO Shohin VALUES ('0007', 'おろしがね', 'キッチン用品', 880, 790, '2008-04-28');
INSERT INTO Shohin VALUES ('0008', 'ボールペン', '事務用品', 100, NULL, '2009-11-11');

COMMIT;


