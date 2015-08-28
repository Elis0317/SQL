/*****************************
結合
	別のテーブルから列を持ってきて、列を増やす操作
		集合演算: 行を増やす作業
		
	どちらのテーブルにも存在する列(A)を橋渡しにして、片方のテーブルにしか存在しない列(B)同士を一緒の結果に含める
*****************************/

/* INNER JOIN(内部結合)
例: Shohinテーブルから商品名と販売単価の列をもってきて、TenpoShohinテーブルにくっつける
	Shohinテーブルの列データ:		[商品ID, 商品名, 商品分類, 販売単価, 仕入れ単価, 登録日]
	TenpoShohinテーブルの列データ:	[商品ID, 店舗ID, 店舗名, 数量]

	(A): 商品ID		(B): 商品ID以外の列
*/

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM TenpoShohin AS TS INNER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id;

/*****************************
内部結合の使い方
	1. FROM句に2つのテーブルを書く
		テーブル名が長いと読みづらいので、一般的にはASで別名をつける
	
	2. ON句で結合条件を指定する
		2つのテーブルを結び付ける列(結合キー)を指定する
			結合条件専用のWHEREのようなもの
			基本的に = でキーを結び付ける
			
		FROMとWHEREの間に書くこと
		
	3. SELECT句の書き方
		<テーブル名の別名>, <列名>という記述によって、どのテーブルのどの列を持ってきているか明示する

内部結合とWHEREの組み合わせ
	結合演算によりテーブルを結合した後は、WHERE, GROUP BY, ORDER BYなどを使うことができる
	SELECT文が実行されている間氏か存続しないので、常に残したいならビューを作成する

*****************************/

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM TenpoShohin AS TS INNER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id
 WHERE TS.tenpo_id = '000A';


/*****************************
OUTER JOIN(外部結合)
	どちらか一方のテーブルに存在しているならば、そのテーブルの情報が欠けることなく出力される
	テーブルから分からない情報はNULLとして結果に表れる
		※内部結合では、一方のテーブルにしか存在していないテーブルは結果に出ない
	
		元のテーブルにない（つまりテーブルの外部から）情報を結果に持ってくる
	
マスタテーブルの指定
	FROM句内でLEFT, RIGHTを使うことでマスタテーブルを指定する
		指定されたマスタテーブルの情報が全て表示される
	LEFT, RIGHTに機能的な差はない
*****************************/

SELECT TS.tenpo_id, TS.tenpo_mei, S.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM Shohin AS S LEFT OUTER JOIN TenpoShohin AS TS
    ON TS.shohin_id = S.shohin_id;


/*****************************
3つ以上のテーブルを使った場合
	3つ以上のテーブルを同時に結合することも可能
	FROM句にINNER JOINを重ねていけばいい
*****************************/

-- DDL：テーブル作成
CREATE TABLE ZaikoShohin
( souko_id		CHAR(4)      NOT NULL,
  shohin_id     CHAR(4)      NOT NULL,
  zaiko_suryo	INTEGER      NOT NULL,
  PRIMARY KEY (souko_id, shohin_id));

-- DML：データ登録

INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0001',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0002',	120);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0003',	200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0004',	3);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0005',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0006',	99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0007',	999);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0008',	200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0001',	10);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0002',	25);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0003',	34);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0004',	19);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0005',	99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0006',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0007',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0008',	18);

COMMIT;

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka, ZS.zaiko_suryo
  FROM TenpoShohin AS TS INNER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id
               INNER JOIN ZaikoShohin AS ZS
                   ON TS.shohin_id = ZS.shohin_id
                   -- TS.-とS.-が等号で結ばれているので、S.-とZS.-の等号はいらない
                   		--（SとZSを結合しても結果は同じ）
WHERE ZS.souko_id = 'S001';