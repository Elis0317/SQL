A3-1
CREATE TABLE emloyee
(
	e_num	char(4)		PRIMARY KEY
,	e_name  varchar(40)	NOT NULL
,	year	integer		check(year >= 1970)
,	gender	char(1)		check(gender = '0' OR gender = '1')
,	office char(2)
);

/*
主キーにNOT NULLは不要(NOT NULLを自動で含む)
checkを使うことでデータを制限できる
テーブルを削除するときは、中身が入っている場合DELETE=>DROP TABLE テーブル名
*/


A3-3
ALTER TABLE
	employee
  ADD 	FOREIGN KEY (office)
  REFERENCES
  	office(o_num);

/*
親キー: 参照される側
外部キー: 参照する側

テーブルの変更なのでALTER TABLE employee ADD

FOREIGN KEY制約コードの基本形は
FOREIGN KEY 列リスト REFERENCES 親テーブル(列リスト) ; より後半は

FOREIGN KEY (office)  <=外部キーをemployee.officeに
REFERENCES office(o_num)  <=親キーをoffice.o_numに
*/


A4-1
INSERT into
	employee
VALUES	('101', 'Ato Taro',1972, '1', '10');


A4-2
UPDATE	employee
SET	office = '20'


A4-3
DELETE FROM employee

/*
これ（データ全削除）を行うことでDROP TABLEよりテーブルを削除できる。
特定行のみを消したい場合はwhereを使うこと
*/


A5-1
SELECT	e_name
FROM	employee
WHERE	e_name like '% To%'; 

--苗字とTo%の間にSpaceをはさむことで、苗字がToで始まる人を抜き出さないようにしている
--任意の文字数は%, 任意の1文字は_を使って表示

A5-2
SELECT	count(gender)
,	office
FROM	employee
WHERE	gender = '1'
GROUP BY
	office

--FROMでテーブル指定=>WHEREで範囲絞り込み=>GROUP BYでまとめ=>SELECTで表示


A6-1
SELECT	O.office AS 営業所名
,	COUNT(*) AS 顧客数
FROM	customer AS C
,	office AS O
WHERE	C.office = O.o_num
GROUP BY
	O.office

/*
営業所名と顧客数に''はいらない
  FROMでテーブルの読み込み
=>WHEREでテーブルの結合
=>GROUP BYでO.office[Osaka office...]の値を使った集合
    C.office[10, 20, 30]でグループ分け自体は正しいが、SELECT句にO.officeが書けない
    (GROUP BYを使った時、SELECT句に使えるのはGROUP BY句で指定した列と集合関数のみ)
=>SELECT ASをつかって列タイトルを変更、出力
*/

別解
SELECT	O.office AS 営業所名
,	count(*) AS 顧客の人数
FROM	customer AS C
  JOIN	office AS O
  ON	C.office = O.o_num
GROUP BY
	O.office


A6-2
SELECT	C.c_name AS 顧客名
, 	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS 支払い金額
FROM	accept_order AS A
,	product AS P
,	customer AS C
WHERE	A.p_num = P.p_num
  AND	A.c_num = C.c_num
GROUP BY
	C.c_name
ORDER BY
	支払い金額 DESC

--3つのテーブルを結合、結合の条件式はANDで結ぶ
別解
SELECT	C.c_name AS 顧客名
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS 支払い金額
FROM	accept_order AS A
  NATURAL JOIN
	customer AS C
  NATURAL JOIN
	product AS P
GROUP BY
	C.c_name
ORDER BY 
	2 DESC


A6-3
SELECT	E.e_name AS 従業員名
,	COUNT(*) AS 販売件数
FROM	employee AS E
,	accept_order AS A
WHERE	A.employee = E.e_num 
  AND	A.accept_date BETWEEN '20010301' AND '20010331'
GROUP BY
	E.e_name
ORDER BY
	販売件数
	
別解
SELECT	E.e_name AS 従業員名
,	count(*) AS 販売件数
FROM	accept_order AS A
  JOIN	employee AS E
  ON	A.employee = E.e_num
GROUP BY
	e_name
ORDER BY 2

A6-4
SELECT  DISTINCT A1.c_num
FROM	accept_order A1
,	accept_order A2
WHERE	A2.c_num = '1007'
  AND	A1.p_num = A2.p_num
  AND	A1.c_num <> A2.c_num ;
   
/*
1. A2の顧客番号が'1007'
2. A1の商品番号とA2の商品番号が同じ
3. A1の顧客番号とA2の顧客番号が違う
=>顧客番号が '1007' の顧客と同じ自動車を購入したレコードが抽出される。
  ただし、'1007'は入らない。
*/


A6-5
INSERT INTO
	employee
	VALUES('108', 'Fujiwara Norio', '2001', '1', '10')

SELECT	E.e_name AS 従業員
,	SUM(A.option_price) AS オプション売上
FROM	accept_order AS A
  RIGHT OUTER JOIN
  	employee AS E
  ON	A.employee = E.e_num
GROUP BY
	E.e_name

/*
A RIGHT OUTER JOIN B ON A... = B...
<テーブル B> のすべての行と、<テーブル A> で一致が検出された行が含まれる。
<テーブル A> で一致が検出されなかった行には NULL が設定される。
今回は従業員全員のデータが(オプションが0でも)ほしいので、
employeeを基準に外部結合。
FROM employee AS E LEFT OUTER JOIN ... accept_order AS A ON ...でももちろんOK。
*/


A7-1
SELECT	DISTINCT C2.c_name AS 顧客名
,	C2.address AS 住所
FROM	customer AS C2
  NATURAL JOIN
  	accept_order AS A2
  NATURAL JOIN
  	product AS P2 --NATURAL JOIN による結合
WHERE	P2.price * (100 - A2.dc_rate) / 100 + A2.option_price >
(	SELECT	AVG(P1.price * (100 - A1.dc_rate) / 100 + A1.option_price)
	FROM	accept_order AS A1
		NATURAL JOIN product AS P1
);
/*
この問題は1回あたりの支払金額で判定している（複数回の購入は考慮せず）
クエリとサブクエリはそれぞれローカルであることを示すため、あえて変数を一致させていない
（通常なら全てA, C, Pで統一して問題なし）
	=>サブクエリからクエリに出た時、FROM句で新たにASを用いた名前の変更が必要
	
サブクエリ
AとPを内部結合して、支払金額を算出、平均化
AVG()の範囲はFROMの前(AVGの行1列)
クエリ
サブクエリで算出されたAVGを基準に、顧客ごとの金額を算出、比較
条件が真の場合、A, C, Pを内部結合して名前と住所を割り出し、DISTINCTで重複を削除
*/


A7-2
SELECT	 O1.office AS 営業所名, O2.price AS 売上金額
FROM	 office as O1
  NATURAL JOIN (
	SELECT	C.office AS o_num
	,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS price
	FROM accept_order AS A
	  NATURAL JOIN
		product AS P
	  NATURAL JOIN
		customer AS C
	GROUP BY C.office
  ) AS O2
ORDER BY
	2 DESC;
/*
O2.priceはSELECT句の2番目であるため、O2.priceを基準にするときこのように記述してもよい。
(ORDER BY 売上金額 DESCと同じ)
売上金額、営業所名の順にソートを行いたい場合は、ORDER BY 2,1と記述する
*/


A7-3
SELECT	E2.e_name AS 従業員名
FROM	
(
	SELECT	A.employee
	FROM	accept_order AS A
	GROUP BY
		A.employee
	HAVING	count(*) >= 3
)	AS E1
  JOIN	employee AS E2
  ON	E1.employee = E2.e_num

A8-1
SELECT '1月' AS 月, count(*) AS 売上台数
   FROM accept_order
   WHERE accept_date BETWEEN '20010101' AND '20010131'
UNION
SELECT '2月' AS 月, count(*) AS 売上台数
   FROM accept_order
   WHERE accept_date BETWEEN '20010201' AND '20010228'
UNION
SELECT '3月' AS 月, count(*) AS 売上台数
   FROM accept_order
   WHERE accept_date BETWEEN '20010301' AND '20010331';

別解(UNIONを使わない)
SELECT	
  CASE WHEN
	accept_date BETWEEN '20010101' AND '20010131'
	THEN '1月'
  WHEN
	accept_date BETWEEN '20010201' AND '20010228'
	THEN '2月'
  WHEN
	accept_date BETWEEN '20010301' AND '20010331'
	THEN '3月'
  ELSE	NULL
  END AS 月
,	COUNT(*)
FROM	accept_order
GROUP BY 月


A8-2
SELECT	c.c_name AS 顧客名
,	co.office AS 顧客管理営業所名
,	e.e_name AS 販売従業員名
,	eo.office AS 販売営業所名
FROM
(
	SELECT	a.c_num
	,	c.office AS c_office
	,	a.employee
	,	e.office AS e_office
	FROM accept_order a
	  JOIN customer c
	  ON a.c_num = c.c_num
	  JOIN employee e
	  ON a.employee = e.e_num

	EXCEPT
	
	SELECT	a.c_num
	,	e.office
	,	a.employee
	,	c.office
	FROM accept_order a
	  JOIN customer c
	  ON a.c_num = c.c_num
	  JOIN employee e
	  ON a.employee = e.e_num
)	data
/*
EXCEPTの上 => accept_order, customer, employeeを結合したすべての結果
EXCEPTの下 => 結合自体は同じ。ただし、列の表示する順番に変化あり(c.office, e.office)
	c.officeとe.officeの値が変わらなければ、顧客と従業員の事務所に変化はない。
つまり、これによって顧客と従業員の事務所に変化があるもののみを載せている
*/
	  JOIN customer c
	  ON data.c_num = c.c_num
	  JOIN office co
	  ON data.c_office = co.o_num
	  
	  JOIN employee e
	  ON data.employee = e.e_num
	  JOIN office eo
	  ON data.e_office = eo.o_num;
/*
顧客の営業所名と従業員の営業所名をそれぞれ取得するため、
officeを別名で2回テーブルに結合し、データを区別している
*/
別解(EXCEPTを使わないもの)
SELECT	C.c_name AS 顧客名
,	CO.office AS 顧客管理営業所名
,	E.e_name AS 販売従業員名
,	EO.office AS 販売営業所名
FROM	accept_order AS A
  NATURAL JOIN
	customer AS C
  JOIN	office AS CO
  ON	C.office = CO.o_num
  
  JOIN	employee AS E
  ON	A.employee = E.e_num
  JOIN	office AS EO
  ON	E.office = EO.o_num
WHERE	C.office <> E.office
/*
考え方は上と同じ。
条件はWHERE句1文で表現できるので、これで簡略化。
*/


A9-1
CREATE	VIEW MonthCarsListView AS
SELECT	'1月' AS 月
,	count(*) AS 売上台数
FROM	accept_order
WHERE	accept_date BETWEEN '20010101' AND '20010131'
UNION
SELECT '2月' AS 月
,	count(*) AS 売上台数
FROM	accept_order
WHERE	accept_date BETWEEN '20010201' AND '20010228'
UNION
SELECT '3月' AS 月
,	count(*) AS 売上台数
FROM	accept_order
WHERE	accept_date BETWEEN '20010301' AND '20010331';


A9-2
CREATE VIEW OfficeCheckView AS
SELECT	c.c_name AS 顧客名
,	co.office AS 顧客管理営業所名
,	e.e_name AS 販売従業員名
,	eo.office AS 販売営業所名
FROM
(
	SELECT	a.c_num
	,	c.office AS c_office
	,	a.employee
	,	e.office AS e_office
	FROM accept_order a
	  JOIN customer c
	  ON a.c_num = c.c_num
	  JOIN employee e
	  ON a.employee = e.e_num

	EXCEPT
	
	SELECT	a.c_num
	,	e.office
	,	a.employee
	,	c.office
	FROM accept_order a
	  JOIN customer c
	  ON a.c_num = c.c_num
	  JOIN employee e
	  ON a.employee = e.e_num
)	data

	  JOIN customer c
	  ON data.c_num = c.c_num
	  JOIN office co
	  ON data.c_office = co.o_num
	  
	  JOIN employee e
	  ON data.employee = e.e_num
	  JOIN office eo
	  ON data.e_office = eo.o_num;


A9-3
SELECT	MAX(売上台数) AS 最大
,	MIN(売上台数) AS 最少
,	AVG(売上台数) AS 平均
FROM	MonthCarsListView

