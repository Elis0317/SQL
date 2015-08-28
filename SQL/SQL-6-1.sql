/*****************************
関数の種類
	1. 算術関数
		数値の計算を行う関数
	2. 文字列関数
		（文字列を操作するための関数）
	3. 日付関数
		（日付を操作するための関数）
	4. 変換関数
		（データ型や値を変換するための関数）
	5. 集約関数 
		（データの集計を行うための関数）--習得済み
******************************/

/*****************************
1.算術関数
*****************************/

-- DDL (データ定義言語)：テーブル作成
CREATE TABLE SampleMath
(m  NUMERIC (10,3),	-- (全体の桁数, 小数の桁数）により数値の大きさを指定
 n  INTEGER,
 p  INTEGER);

-- DML (データ操作言語)：データ登録
BEGIN TRANSACTION;

INSERT INTO SampleMath(m, n, p) VALUES (500,  0,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180, 0,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 7,    3);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 5,    2);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 4,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8,    NULL, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555,2,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 1,    NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76, NULL, NULL);

-- DCL (データ制御言語) :データ確定
COMMIT;

-- テーブルの内容確認
SELECT * FROM SampleMath;


/*********
ABS(数値)
	絶対値を求める関数
*********/

SELECT m,
       ABS(m) AS abs_col
  FROM SampleMath;


/*********
MOD(被序数, 序数)
	剰余を求める関数
	余りという概念上、整数型の列だけになる
*********/

SELECT n, p,
       MOD(n, p) AS mod_col
  FROM SampleMath;


/*********
MOD(対象数, 丸めの桁数)
	四捨五入する関数
	丸めの桁数までの数値が表示される: 0 => 整数値, 2 => 小数第2位まで（小数第3位を四捨五入)
*********/

SELECT m, n,
       ROUND(m, n) AS round_col
  FROM SampleMath;


/*****************************
2.文字列関数
*****************************/

-- DDL：テーブル作成
CREATE TABLE SampleStr
(str1  VARCHAR(40),
 str2  VARCHAR(40),
 str3  VARCHAR(40));

-- DML：データ登録
BEGIN TRANSACTION;

INSERT INTO SampleStr (str1, str2, str3) VALUES ('あいう',	'えお'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc'	,	'def'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('山田'	,	'太郎'  ,	'です');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa'	,	NULL    ,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL	,	'あああ',	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%',	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc太郎',	'abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdefabc','abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ミックマック',	'ッ', 'っ');

COMMIT;


-- テーブルの内容確認
SELECT * FROM SampleStr;


/*********
文字列1 || 文字列2
	連結
	足す文字がNULLの場合、結果はNULL
	3つ以上つなげることも可能
*********/

SELECT str1, str2, str3,
       str1 || str2 || str3 AS str_concat
  FROM SampleStr
 WHERE str1 = '山田';


/*********
LENGTH（文字列）
	文字列長
	文字が何文字か調べる
*********/

SELECT str1,
       LENGTH(str1) AS len_str
  FROM SampleStr;


/*********
LOWER（文字列）
	小文字化
	アルファベットの大文字のみに関係し、全て小文字にする
	小文字から大文字はUPPER
*********/

SELECT str1,
       LOWER(str1) AS low_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');

SELECT str1,
       UPPER(str1) AS up_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');
 
 
/*********
REPLACE(対象文字列, 置換前の文字列, 置換後の文字列)
	置換
	文字列中のある一部分の文字列を別の文字列におきかえる
*********/

SELECT str1, str2, str3,
       REPLACE(str1, str2, str3) AS rep_str
  FROM SampleStr;


/*********
SUBSTRING(対象文字列 FROM 切り出し開始位置 FOR 切り出す文字数)
	切り出し
	文字列中のある一部分の文字列を切り出す
	FROMとFORの後ろは整数値が入り、「何文字目から」「何文字抜き出す」かを指定する
*********/

SELECT str1,
       SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
  FROM SampleStr;


/*****************************
3.日付関数
*****************************/

/*********
CURRENT_DATE
	現在の日付
	この関数が実行された日を戻り値として返す

CURRENT_TIME
	現在の時間
	この関数が実行された時間を戻り値として返す

CURRENT_TIMESTAMP
	現在の日時
	この関数が実行された日時を戻り値として返す
*********/

SELECT CURRENT_DATE;

SELECT CURRENT_TIME;

SELECT CURRENT_TIMESTAMP


/*********
EXTRACT
	日付要素の切り出し
	日付データから「年」や「月」、「秒」を切り出す場合に使う
	戻り値は数値型
*********/

/*****************************
4. 変換関数
*****************************/

/*********
CAST(変換前の値 AS 変換するデータ型
	型変換
	型が不一致故のエアーを回避させる
*********/

SELECT CAST('0001' AS INTEGER) AS int_col;

SELECT CAST('2009-12-14' AS DATE) AS date_col;


/*********
COALESCE（データ1, データ2, データ3, ......)
	NULLを値へ変換
	左の引数から順に見ていき、初めてNULLでなかった時の数値を返す
	例: NULL NULL 3 NULL 5の場合、戻り値は3
	
	NULLが演算・関数に紛れ込むと全てNULLになるため、それを避ける時に重宝
*********/

SELECT COALESCE(NULL, 1)                  AS col_1,
       COALESCE(NULL, 'test', NULL)       AS col_2,
       COALESCE(NULL, NULL, '2009-11-01') AS col_3;

SELECT COALESCE(str2, 'NULLです')	-- <= このようにしておくと、str2の値が全てNULLでもNULLを返さなくなる
  FROM SampleStr;
