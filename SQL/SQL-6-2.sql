/*****************************
述語	戻り値が真理値になる関数のこと
*****************************/
-- DDL：テーブル作成
CREATE TABLE SampleLike
( strcol VARCHAR(6) NOT NULL,
  PRIMARY KEY (strcol));

-- DML：データ登録
BEGIN TRANSACTION;

INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');

COMMIT;


/*****************************
LIKE述語
	文字列の部分一致検索
	前方一致 例: ddd%	[ddd + （0文字以上の文字列)]							dddabcなど
	中間一致 例: %ddd%	[（0文字以上の文字列) + ddd + （0文字以上の文字列)]		dddabc, adddbc, abcdddなど
	後方一致 例: %ddd	[（0文字以上の文字列) + ddd]							abcdddなど
	
	%の代わりに_を使うと、(任意の1文字)の意味になる
*****************************/

SELECT *
  FROM SampleLike
 WHERE strcol LIKE 'ddd%'; -- 前方一致

SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd%'; -- 中間一致

SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd'; -- 後方一致

SELECT *
  FROM SampleLike
 WHERE strcol LIKE 'abc__'; -- 後方一致(最初の3文字がabcの5文字)


/*****************************
<列データ> BETWEEN <最小値> AND <最大値>
	範囲検索
	両端を含むので、含みたくない場合は BETWEENではなく < AND > を使う必要がある
*****************************/

SELECT shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka BETWEEN 100 AND 1000;
 

/*****************************
IS NULL, IS NOT NULL
	NULL, 非NULLの判定
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NULL;

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NOT NULL;
 

/*****************************
IN(値1, 値2, ......)
	ORの便利な省略形			--値1, 値2...のみを選択したい場合の省略
	NORの便利な省略形は NOT IN	--値1, 値2...以外を選択したい場合の省略
	
	どちらもNULLは選択できない
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IN (320, 500, 5000);
 
SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka NOT IN (320, 500, 5000);


/*****************************
IN(NOT IN)述語の引数にサブクエリを指定
	サブクエリ = SQL内部で精製されたテーブルのこと
		=> INはテーブルを引数に指定できる
		=> INはビューを引数に指定できる
*****************************/

CREATE TABLE TenpoShohin
(tenpo_id  CHAR(4)       NOT NULL,
 tenpo_mei  VARCHAR(200) NOT NULL,
 shohin_id CHAR(4)       NOT NULL,
 suryo     INTEGER       NOT NULL,
 PRIMARY KEY (tenpo_id, shohin_id)); -- <= 店舗IDと商品IDを組み合わせることによって、唯一つに定まる

BEGIN TRANSACTION;

INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'東京',		'0001',	30);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'東京',		'0002',	50);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'東京',		'0003',	15);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0002',	30);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0003',	120);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0004',	20);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0006',	10);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0007',	40);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0003',	20);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0004',	50);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0006',	90);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0007',	70);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000D',	'福岡',		'0001',	100);

COMMIT;


/*****************************
例1)	大阪店(000C)に置いてある商品(shohin_id)の販売単価(hanbai_tanka)を求める場合
	1. TenpoShohinテーブルから、大阪店(tenpo_id = '000C')が持っている商品(shohin_id)を選択する
	2. Shohinテーブルから、1. で選択した商品(shohin_id)のみ販売単価(hanbai_tanka)を選択する
		
1. のステップ
SELECT shohin_id 
  FROM TenpoShohin
 WHERE tenpo_id = '000C');	-- この文をそのまま2. の条件として用いればいよい
*****************************/

-- 「大阪店に置いてある商品の販売単価」を求める
SELECT shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE shohin_id IN (SELECT shohin_id 			--)
                       FROM TenpoShohin			--) このサブクエリが展開されると、
                      WHERE tenpo_id = '000C');	--) ('0003', '0004', '0006', '0007') という結果が得られる

-- 例2)「東京店(000A)に置いてある商品以外の販売単価」を求める
SELECT shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE shohin_id NOT IN (SELECT shohin_id 
                           FROM TenpoShohin
                          WHERE tenpo_id = '000A');


/*****************************
EXISTS述語
	EXISTSはこれまでに学んだ述語とは使い方が異なり、意味を直感的に理解するのが難しい
	EXISTを使わなくてもIN(NOT IN)によって、「ほぼ」代用できる
	
	ある条件に合致するレコードの存在有無を調べる
		レコードが存在すればTRUE, しないならFALSE
		EXISTSの主語はレコード
*****************************/

-- 例1) 大阪店に置いてある商品の販売単価を求める
SELECT shohin_mei, hanbai_tanka
  FROM Shohin AS S
 WHERE EXISTS (SELECT *
                 FROM TenpoShohin AS TS
                WHERE TS.tenpo_id = '000C'
                  AND TS.shohin_id = S.shohin_id);

/*****************************
EXISTSの使い方
	左側に引数はなく、相関サブクエリのみを引数にとる
	(引数なし) EXISTS SELECT *(EXISTの慣習)		-- (相関サブクエリ)
					    FROM <テーブル名> AS <テーブル名>
					   WHERE <条件1>
					     AND <条件2>
NOT EXISTS
	サブクエリ内で指定した条件のレコードが存在しない場合にTRUEを返す
*****************************/

-- 例2) 東京店に置いてある商品以外の販売単価を求める
SELECT shohin_mei, hanbai_tanka
  FROM Shohin AS S
 WHERE NOT EXISTS (SELECT *
                     FROM TenpoShohin AS TS
                    WHERE TS.tenpo_id = '000A'
                      AND TS.shohin_id = S.shohin_id);