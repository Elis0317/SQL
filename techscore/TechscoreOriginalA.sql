A1
SELECT	p_name AS 車種
,	count(*) AS 販売台数
FROM	accept_order AS A, product as P
WHERE	A.p_num = P.p_num
GROUP BY
	p_name

A1
SELECT	p_name AS 車種
,	count(*) AS 販売台数
FROM	accept_order AS A
  NATURAL JOIN product as P
-- NATURAL JOIN により、AとPのp_numを比較し、値が同じ部分が結合する
GROUP BY
	p_name

A2
SELECT	C.c_name AS 顧客名
,	P.p_name AS 車種
FROM	customer AS C
,	accept_order AS A
,	product AS P
WHERE	A.c_num = C.c_num 
  AND	A.p_num = P.p_num

A2-1
SELECT	C.c_name AS 顧客名
,	P.p_name AS 車種
FROM	customer AS C
  NATURAL JOIN accept_order AS A
  NATURAL JOIN product AS P
  
A3
SELECT	C.c_name AS 顧客名
,	P.p_name AS 車種
,	P.price * (100 - A.dc_rate) / 100 + A.option_price AS 支払い価額
FROM	customer AS C
,	accept_order AS A,
	product AS P
WHERE	A.c_num = C.c_num
  AND	A.p_num = P.p_num

A4
SELECT	C.c_name AS 顧客名
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS 支払い価額
FROM	customer AS C
,	accept_order AS A
,	product AS P
WHERE	A.c_num = C.c_num
  AND	A.p_num = P.p_num
GROUP BY
	c_name
ORDER BY
	支払い価額 DESC


A5
SELECT	EXTRACT(YEAR	FROM A.accept_date) AS 年
,	EXTRACT(MONTH	FROM A.accept_date) AS 月
,	COUNT(*) AS 販売台数
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS 総売上
FROM	accept_order AS A
  NATURAL JOIN
	customer AS C
  NATURAL JOIN
	product AS P
GROUP BY 年, 月
ORDER BY 1, 2


A6
SELECT	CASE
  WHEN
	A.accept_date BETWEEN '20010101' AND '20010131'
  THEN	'JAN'
  WHEN
	A.accept_date BETWEEN '20010201' AND '20010228'
  THEN	'FEB'
  WHEN
	A.accept_date BETWEEN '20010301' AND '20010331'
  THEN	'MAR'
  ELSE	NULL
  END	AS 月
,	COUNT(*) AS 販売台数
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS 総売上
FROM	accept_order AS A
  NATURAL JOIN
	customer AS C
  NATURAL JOIN
	product AS P
GROUP BY 月

A7
SELECT	E.e_name AS 従業員名
,	count(*) AS 販売台数
FROM	accept_order AS A
  JOIN	employee AS E
  ON	A.employee = E.e_num
WHERE	E.gender = '1'
GROUP BY
	E.e_name
ORDER BY
	販売台数 DESC

SELECT	E.e_name AS 従業員名
,	count(*) AS 販売台数
,	E.gender AS 性別
FROM	accept_order AS A
  JOIN	employee AS E
  ON	A.employee = E.e_num
GROUP BY
	E.e_name, E.gender
ORDER BY
	3, 2 DESC

/*
A8(サブクエリが2回、何とか外側のサブクエリは回避したい…)
--回避できたので過去の遺物
SELECT	CASE
  WHEN
	data2.sex = '0'	THEN	'女性'
  WHEN
	data2.sex = '1'	THEN	'男性'
  ELSE	NULL
  END	AS 性別
,	data2.従業員名
,	data2.販売台数
FROM
(
	SELECT	RANK () OVER
	(	
	PARTITION BY sex
	ORDER BY data.販売台数 DESC
	)	AS ranking
	,	data.従業員名
	,	data.販売台数
	,	data.sex
	FROM
	(
		SELECT	E.e_name AS 従業員名
		,	count(*) AS 販売台数
		,	E.gender AS sex
		FROM	accept_order AS A
		  JOIN	employee AS E
		  ON	A.employee = E.e_num
		GROUP BY
			E.e_name, E.gender
	) AS data
) AS data2
WHERE	data2.ranking = 1
*/

A8別解
--男女別のランキング
--RANKはint型だが、||で結合すると自動的に文字列型に変換されるようだ(確認)
SELECT	RANK () OVER
(	
PARTITION BY sex
ORDER BY data.販売台数 DESC
)	|| '位'
	AS ランキング
--男女の性別の表示
,	CASE
  WHEN
	data.sex = '0'	THEN	'女性'
  WHEN
	data.sex = '1'	THEN	'男性'
  ELSE	NULL
  END	AS 性別
--サブクエリの列名をそのまま流用
,	data.従業員名
,	data.販売台数
FROM
(
	SELECT	E.e_name AS 従業員名
	,	count(*) AS 販売台数
	,	E.gender AS sex
	FROM	accept_order AS A
	  JOIN	employee AS E
	  ON	A.employee = E.e_num
	GROUP BY
		E.e_name, E.gender
	) AS data
ORDER BY ランキング
LIMIT	2
/*ランキングでソートすると、1位は2つ出る。
よって表示する列を2つに制限し、1位のみを出力
ただ、同着1位が3人以上出た場合の処理はどうする…？
*/
