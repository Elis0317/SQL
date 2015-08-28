/*****************************
集合演算
	レコードの四則演算
	
	集合: レコードの集合
		テーブル、ビュー・クエリの実行結果など
*****************************/

CREATE TABLE Shohin2
(shohin_id     CHAR(4)      NOT NULL,
 shohin_mei    VARCHAR(100) NOT NULL,
 shohin_bunrui VARCHAR(32)  NOT NULL,
 hanbai_tanka  INTEGER      ,
 shiire_tanka  INTEGER      ,
 torokubi      DATE         ,
 PRIMARY KEY (shohin_id));

BEGIN TRANSACTION;

INSERT INTO Shohin2 VALUES ('0001', 'Tシャツ' ,'衣服', 1000, 500, '2009-09-20');
INSERT INTO Shohin2 VALUES ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO Shohin2 VALUES ('0003', 'カッターシャツ', '衣服', 4000, 2800, NULL);
INSERT INTO Shohin2 VALUES ('0009', '手袋', '衣服', 800, 500, NULL);
INSERT INTO Shohin2 VALUES ('0010', 'やかん', 'キッチン用品', 2000, 1700, '2009-09-20');

COMMIT;


/*****************************
テーブルの足し算と引き算
	足し算（和集合)
SELECT <列データ1>, <列データ2>, ...
  FROM <テーブル1>
UNION
SELECT <列データ1>, <列データ2>, ...
  FROM <テーブル2>

重複行を残す集合演算
	UNION の後ろにALL をつける
*****************************/

SELECT shohin_id, shohin_mei
  FROM Shohin
UNION
SELECT shohin_id, shohin_mei
  FROM Shohin2
ORDER BY shohin_id;	-- shohin_idの順に並び替え

SELECT shohin_id, shohin_mei
  FROM Shohin
UNION ALL
SELECT shohin_id, shohin_mei
  FROM Shohin2;


/*****************************
集合演算の注意事項
	1. 演算対象となるレコードの列数は同じであること
	2. 足し算の対象となるレコードの列のデータ型が一致していること
		どうしても違うデータ型の列を使いたい場合は、型変換関数CASTを用いる
	3. SELECT文はどんなものを指定してもよいが、ORDER BY句は最後に一つだけ
*****************************/

/*****************************
INTERSECT(交差)
	2つのレコードの共通部分を選択

EXCEPT(差)
	テーブル1のレコードからテーブル2のレコードを引いた残りを選択
*****************************/

SELECT shohin_id, shohin_mei
  FROM Shohin
EXCEPT
SELECT shohin_id, shohin_mei
  FROM Shohin2
ORDER BY shohin_id;

SELECT shohin_id, shohin_mei
  FROM Shohin2
EXCEPT
SELECT shohin_id, shohin_mei
  FROM Shohin
ORDER BY shohin_id;