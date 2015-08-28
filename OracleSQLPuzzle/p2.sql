机上で考えよう

2-1-2 連続したスカラー問い合わせ(実行済)

問題
Table1のCol1の合計と、
Table2のCol1の平均と、
Table3のCol1の最小値と、Col2の最大値を取得する。

回答
SELECT	(SELECT SUM(col1) FROM Table1), (SELECT AVG(col1) FROM Table2)
,	(SELECT MIN(col1) FROM Table3), (SELECT MAX(col2) FROM Table3)
--FROM文がなくてもSELECT()はどれもスカラ・サブクエリなので問題ない

2-1-3 select文の結果を使ってupdate

問題
Table1                    Table2
PKey  Val1  Val2  Val3    PKey  Val1  Val2  Val3
----  ----  ----  ----    ----  ----  ----  ----
  10  aaaa  bbbb  cccc      10  xxxx  yyyy  zzzz
  20  dddd  eeee  ffff      30  1111  2222  3333

Table1のPKeyに紐づく、Table2の値を使って、Table1のVal1,Val2,Val3をupdateする。
ただし、Table2に紐づくレコードが存在するレコードのみを対象とする。

Table1、Table2のプライマリキーは、PKeyとする。

更新結果
Table1
PKey  Val1  Val2  Val3
----  ----  ----  ----
  10  xxxx  yyyy  zzzz
  20  dddd  eeee  ffff

データ作成スクリプト
create table Table1(
	PKey integer primary key
,	Val1 char(4), Val2 char(4), Val3 char(4)
);

insert into Table1 VALUES(10, 'aaaa', 'bbbb', 'cccc');
insert into Table1 VALUES(20, 'dddd', 'eeee', 'ffff');

create table Table2(
	PKey integer primary key
,	Val1 char(4), Val2 char(4), Val3 char(4)
);

insert into Table2 VALUES(10, 'xxxx', 'yyyy', 'zzzz');
insert into Table2 VALUES(30, 'dddd', 'eeee', 'ffff');

回答
--UPDATE文の基本=>UPDATE <テーブル名> SET <列名> = <式> WHERE <条件>
UPDATE	Table1 AS t1
SET	Val1 = (SELECT t2.Val1 FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
,	Val2 = (SELECT t2.Val2 FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
,	Val3 = (SELECT t2.Val3 FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
	/*WHEREを抜くとエラー
	  スカラ・サブクエリにならないためかな?*/
WHERE	EXISTS(SELECT * FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
	--EXISTSはレコードごとにTかFのみを返す、UPDATEはTのみ実行される
	
/*WHERE文がないと2行目のValは全てNULL
PKey  Val1  Val2  Val3
----  ----  ----  ----
  10  xxxx  yyyy  zzzz
  20  NULL  NULL  NULL
  SET内のWHERE句に対応するt2.PKeyがないため*/

2-1-4 連続したnullチェック

問題
nullTable
Col1  Col2  Col3  Col4
----  ----  ----  ----
   1     2     3     4
   1     2     3  null
null     2     3     4
null  null  null  null

テーブルのCol1、Col2、Col3、Col4を取得する。
ただしCol1、Col2、Col3、Col4が全てnullなら取得しない

出力結果
Col1  Col2  Col3  Col4
----  ----  ----  ----
   1     2     3     4
   1     2     3  null
null     2     3     4

回答
SELECT	*
FROM	nullTable
WHERE	Col1 IS NULL AND Col2 IS NULL 
	AND Col3 IS NULL AND Col4 IS NULL
  
もっと簡略に！(COALESCEを使う)
SELECT	*
FROM	nullTable
WHERE	COALESCE(Col1, Col2, Col3, Col4) IS NOT NULL
/*COALESCEは引数を左から順番に調べ、一番初めのNULLでない引数を返す=>全てNULLならNULL
  どれかに値が存在すればNULL以外を返すので、これで判別可*/

2-1-6 同一定義の他テーブルと比較

tbl1
ID  名前      戦闘  采配
--  --------  ----  ----
 1  織田信長    70    94
 2  柴田勝家    86    85
 3  前田利家    69    72
 5  木下秀吉    59    91
 6  徳川家康  null  null
 7  null      null  null

tbl2
ID  名前      戦闘  采配
--  --------  ----  ----
 1  吉法師      70    94
 2  柴田勝家    86  null
 4  明智光秀    61    87
 5  木下秀吉    59    91
 6  null      null  null
 7  null      null  null

tbl1のID、名前、戦闘、采配と、
tbl2のID、名前、戦闘、采配を比較し(nullとnullは等しい扱いとする)
ID(プライマリキー)が等しくて値が違うデータと、
tbl1、tbl2の、片方のみに存在するデータを取得する。

出力形式は、
tbl1のID(tbl2のみに存在すればnull),tbl2のID(tbl1のみに存在すればnull),
tbl1の名前,tbl2の名前,tbl1の戦闘,tbl2の戦闘,tbl1の采配,tbl2の采配
とする。

出力結果
 AID   BID  A名前     B名前     A戦闘  B戦闘   A采配  B采配
----  ----  --------  --------  -----  -----  -----  -----
   1     1  織田信長  吉法師       70     70     94     94
   2     2  柴田勝家  柴田勝家     86     86     85   null
   3  null  前田利家  null         69   null     72   null
null     4  null      明智光秀   null     61   null     87
   6     6  徳川家康  null       null   null   null   null

データ作成スクリプト
create table tbl1(
id	integer,
name	varchar(8),
war	integer,
talent	integer,
primary key(ID));

create table tbl2(
id	integer,
name	varchar(8),
war	integer,
talent	integer,
primary key(ID));

insert into tbl1 values(1,'織田信長',70,94);
insert into tbl2 values(1,'吉法師'  ,70,94);
insert into tbl1 values(2,'柴田勝家',86,85);
insert into tbl2 values(2,'柴田勝家',86,null);
insert into tbl1 values(3,'前田利家',69,72);
insert into tbl2 values(4,'明智光秀',61,87);
insert into tbl1 values(5,'木下秀吉',59,91);
insert into tbl2 values(5,'木下秀吉',59,91);
insert into tbl1 values(6,'徳川家康',null,null);
insert into tbl2 values(6,null,null,null);
insert into tbl1 values(7,null,null,null);
insert into tbl2 values(7,null,null,null);

回答
--問題文はLEASTを使い、どちらか片方がNULLならNULLを返す前提で回答を作っているが、それは間違っている
--よって論理和を使い、正しい結果を出す
SELECT	T1.id, T2.id
,	T1.name, T2.name
,	T1.war, T2.war
,	T1.talent, T2.talent
FROM	tbl1 AS T1
  FULL OUTER JOIN tbl2 AS T2
  ON	T1.id = T2.id
WHERE	T1.name <> T2.name			  --名前がどちらもNULLでなく、かつ名前も違えば真
  OR	(COALESCE(T1.name, T2.name) IS NOT NULL   --名前がどちらもNULLでなければ真
	AND (T1.name IS NULL OR T2.name IS NULL)) --名前のどちらかがNULLであれば真
	--=>名前の組み合わせが違うor名前の一方のみがNULLのみ表示される
	
	--以下同様
  OR	T1.war <> T2.war
  OR	(COALESCE(T1.war, T2.war) IS NOT NULL
	AND (T1.war IS NULL OR T2.war IS NULL))
  OR	T1.talent <> T2.talent
  OR	(COALESCE(T1.talent, T2.talent) IS NOT NULL
	AND (T1.talent IS NULL OR T2.talent IS NULL))
ORDER BY
	COALESCE(T1.ID, T2.ID)--COALESCEで番号をまとめている

2-1-8 最も近い倍数に、数値を変換

問題
数値を、最も近い5の倍数に数値を切り上げ、および、
最も近い5の倍数に数値を切り下げる。
例 Val = 10.5  => 15, 10
   Val = -1.5  => 0, -5

回答
--切り上げ関数はceil, 切り捨て関数はfloor
SELECT	Val
,	CEIL(Val/5)  *5 AS 切り上げ
,	FLOOR(Val/5) *5 AS 切り捨て
FROM	(SELECT 10.5 AS VAL) AS A
UNION
SELECT	Val
,	CEIL(Val/5)  *5 AS 切り上げ
,	FLOOR(Val/5) *5 AS 切り捨て
FROM	(SELECT -1.5 AS VAL) AS A

/*FROM	(SELECT 10.5 AS VAL UNION
	 SELECT 10 ) のようにPostgreSQLで書けないか?*/

2-2-2 select句でサブクエリ

問題

Table1
Name  Code2  Code3  Code4
----  -----  -----  -----
aaaa    501    601    701
bbbb    502    602    999
cccc    503    999    702
dddd    999    603    703
eeee    999    999    999

Table2        Table3        Table4
Code  Name    Code  Name    Code  Val
----  ----    ----  ----    ----  ---
 501  AAAA     601  DDDD     701  123
 502  BBBB     602  EEEE     701  456
 503  CCCC     603  FFFF     701  789
                             702  321
                             702  456
                             703  987

Table1のCode2(Table2の外部キー)に紐づくTable2のNameの値、
Table1のCode3(Table3の外部キー)に紐づくTable3のNameの値、
Table1のCode4に紐づくTable4のValの値の最大値と最小値を取得する。

出力結果
Name  Code2  Code3  Code4  Name2  Name3  maxVal  minVal
----  -----  -----  -----  -----  -----  ------  ------
aaaa   501    601    701   AAAA   DDDD      789     123
bbbb   502    602    999   BBBB   EEEE     null    null
cccc   503    999    702   CCCC   null      456     321
dddd   999    603    703   null   FFFF      987     987
eeee   999    999    999   null   null     null    null

データ作成スクリプト
create table Table1(
	Name char(4)
,	Code2 integer
,	Code3 integer
,	Code4 integer);

insert into Table1 values('aaaa', 501, 601, 701);
insert into Table1 values('bbbb', 502, 602, 999);
insert into Table1 values('cccc', 503, 999, 702);
insert into Table1 values('dddd', 999, 603, 703);
insert into Table1 values('eeee', 999, 999, 999);

create table Table2(
	Code integer primary key
,	Name char(4));

insert into Table2 values(501, 'AAAA');
insert into Table2 values(502, 'BBBB');
insert into Table2 values(503, 'CCCC');

create table Table3(
	Code integer primary key
,	Name char(4));

insert into Table3 values(601, 'DDDD');
insert into Table3 values(602, 'EEEE');
insert into Table3 values(603, 'FFFF');

create table Table4(
	Code integer
,	Val integer);

insert into Table4 values(701, 123);
insert into Table4 values(701, 456);
insert into Table4 values(701, 789);
insert into Table4 values(702, 321);
insert into Table4 values(702, 654);
insert into Table4 values(703, 987);

回答
SELECT	DISTINCT T1.name AS "NAME"
,	T1.code2 AS "Code2", T1.code3 AS "Code3", T1.code4 AS "Code4"
,	T2.name AS "Name2", T3.name AS "Name3"
,	MAX(T4.val) OVER (PARTITION BY T1.name)--名前ごとのvalの最大値
,	MIN(T4.val) OVER (PARTITION BY T1.name)--名前ごとのvalの最小値
FROM	Table1 AS T1
  LEFT JOIN
	Table2 AS T2
  ON	T2.Code = T1.Code2
  LEFT JOIN
	Table3 AS T3
  ON	T3.Code = T1.Code3
  LEFT JOIN
	Table4 AS T4
  ON	T4.Code = T1.Code4
ORDER BY T1.name

スカラー副問い合わせを使った書き方
select Name, Code2, Code3, Code4
,	(SELECT b.Name FROM Table2 b WHERE b.Code = a.Code2) as Name2
,	(SELECT b.Name FROM Table3 b WHERE b.Code = a.Code3) as Name3
,	(SELECT max(val) FROM Table4 b WHERE b.code = a.Code4) as maxVal
,	(SELECT	min(val) FROM Table4 b WHERE b.code = a.Code4) as minVal 
from Table1 a;

2-2-3 in述語の引数にサブクエリ
問題

Table1        Table2
Col1  Col2    Col3  Col4
----  ----    ----  ----
1111  1111    1111  2222
1111  2222    2222  1111
1111  3333    2222  2222
2222  1111    2222  3333
2222  2222
2222  3333

Table1のCol1,Col2の値の組み合わせと同一の組み合わせが、
Table2のCol3,Col4の値の組み合わせの集合の中に存在したら、
Table1の該当レコードをDeleteする。

削除結果
Table1
Col1  Col2
----  ----
1111  1111
1111  3333

回答
DELETE	
FROM	Table1 AS T1
WHERE	EXISTS(
		SELECT * FROM Table2 AS T2
		WHERE T1.Col1 = T2.Col3 AND T3.COl3 = T4.Col4
	) AS TE
	
2-2-7 case式とexists述語
問題

Table1      Table2
PK          FK
--          --
 1           2
 2           4
 3           6
 4           8
 5          10
 6
 7
 8
 9
10

Table1の主キーが
Table2から外部キー経由で参照されていれば1、されてなければ0
を取得する。

出力結果
PK  IsRefered
--  ---------
 1          0
 2          1
 3          0
 4          1
 5          0
 6          1
 7          0
 8          1
 9          0
10          1

SELECT	PK
,	CASE WHEN EXISTS(
		SELECT * FROM Table2 AS T2 WHERE Table1.PK = Table2.FK
		THEN 1 ELSE 0 END
	) AS IsRefered
FROM	Table1 AS T1

2-2-8 exists述語の引数に集合演算
問題

Table1    Table2    Table3
Col1      Col1      Col1
----      ----      ----
   1         2         3
   2         4         6
   3         8         9
   4        10        12
   5                  15
   6                  18
   7
   8
   9
  10

Table1のCol1が、
Table2とTable3の少なくとも片方から、外部キー経由で参照されていれば1、されてなければ0
を出力する。

Table1、Table2、Table3のプライマリキーは、Col1とする。

出力結果
COL1  IsReference
----  -----------
   1            0
   2            1
   3            1
   4            1
   5            0
   6            1
   7            0
   8            1
   9            1
  10            1

SELECT	COL1
,	CASE WHEN EXISTS(
			SELECT * FROM Table2 AS T2 WHERE T1.Col1 = T2.Col1
		) OR EXISTS(
			SELECT * FROM Table3 AS T3 WHERE T1.Col1 = T3.col1
		) THEN 1 ELSE 0
	END AS IsRefered
FROM	Table1 AS T1

2-2-11 case式とLNNVL述語
問題

BoolTable
Val1  Val2
----  ----
   1     9
   9     9
   9     1
null     1
   1  null

Val1とVal2を比較し、Val1 < Val2がtrueでなければ(unknownかfalseであれば)1、
Val1とVal2を比較し、Val1 < Val2がfalseでなければ(unknownかtrueであれば)1、
を取得する。

出力結果
Val1  Val2  IsNotTrue  IsNotFalse
----  ----  ---------  ----------
   1     9          0           1
   9     9          1           0
   9     1          1           0
null     1          1           1
   1  null          1           1
   
回答
SELECT	Val1, Val2
,	CASE WHEN Val1 < Val2 /*= TRUE*/THEN 1 ELSE 0
	END AS IsNotTrue
,	CASE WHEN Val1 < Val2 = FALSE THEN 1 ELSE 0
	END AS IsNotFalse
FROM	BoolTable

2-3-2 前日のレコードを取得
問題
table1
date1      Val1
---------  ----
2005/5/25     2
2005/5/24     1
2005/5/23     3
2005/5/20     6

Table1のDate1(Date型)と、Val1と、
Date1が前日のレコードのVal1(前日のレコードが存在しなければ0)
を取得する。
Table1のプライマリキーは、Date1とする。

出力結果
date1      Val1  BeforeVal1
---------  ----  ----------
2005/5/25     2           1
2005/5/24     1           3
2005/5/23     3           0
2005/5/20     6           0

回答
SELECT	A.date1, A.Val1
,	CASE WHEN EXISTS(
		SELECT * FROM Table1 AS B WHERE A.date1 = B.date1 - 1
		)THEN (SELECT B.Val1 FROM Table1 AS B WHERE A.date1 = B.date1 - 1) ELSE 0
	END AS BeforeVal1
FROM	table1 AS A

2-3-5 モード(最頻値)を取得
問題

最頻値テーブル
Col1
----
  10
  20
  20
  30
  30
  30
  40
  40
  40
  40
  50
  50
  50
  50
  60
  60
  60
  60

最頻値テーブルの、
Col1の最頻値(最も多く存在する値)と、
最頻値のレコード数を取得する。

出力結果
最頻値  最頻値のレコード数
------  ------------------
    40                   4
    50                   4
    60                   4

データ作成スクリプト

CREATE TABLE table1(
	Col1 integer);

INSERT INTO table1 VALUES(10);
INSERT INTO table1 VALUES(20);
INSERT INTO table1 VALUES(20);
INSERT INTO table1 VALUES(30);
INSERT INTO table1 VALUES(30);
INSERT INTO table1 VALUES(30);
INSERT INTO table1 VALUES(40);
INSERT INTO table1 VALUES(40);
INSERT INTO table1 VALUES(40);
INSERT INTO table1 VALUES(40);
INSERT INTO table1 VALUES(50);
INSERT INTO table1 VALUES(50);
INSERT INTO table1 VALUES(50);
INSERT INTO table1 VALUES(50);
INSERT INTO table1 VALUES(60);
INSERT INTO table1 VALUES(60);
INSERT INTO table1 VALUES(60);
INSERT INTO table1 VALUES(60);

回答
SELECT	Col1, 最頻値のレコード数
FROM	(SELECT	Col1
	,	COUNT(*) as レコード数
	,	max(count(*)) OVER() as 最頻値のレコード数 FROM Table1 GROUP BY Col1
	) AS T
WHERE レコード数 = 最頻値のレコード数
ORDER BY Col1;

2-3-8 過去の最高売上を取得

売上テーブルから、担当者IDごと、年月ごとに、
年月時点での最高売上を表示する。

売上テーブル
担当者ID    年月    売上
--------  ------   ----
       1  200501   1000
       1  200502    500
       1  200503   2000
       1  200504   1500
       2  200501   1000
       2  200502   1500
       2  200503   1000
       2  200504   2000
       3  200501   1000
       3  200502   1500
       3  200503   1000

出力結果
担当者ID    年月    売上   最高売上
--------  ------   ----   --------
       1  200501   1000       1000
       1  200502    500       1000
       1  200503   2000       2000
       1  200504   1500       2000
       2  200501   1000       1000
       2  200502   1500       1500
       2  200503   1000       1500
       2  200504   2000       2000
       3  200501   1000       1000
       3  200502   1500       1500
       3  200503   1000       1500

SELECT	
	id AS 担当者ID
,	ym AS 年月
,	sale AS 売上
,	MAX(売上) OVER (PARTITION BY 担当者ID ORDER BY 年月) AS 最高売上
FROM	table1
ORDER BY
	担当者ID

