A1
SELECT	p_name AS �Ԏ�
,	count(*) AS �̔��䐔
FROM	accept_order AS A, product as P
WHERE	A.p_num = P.p_num
GROUP BY
	p_name

A1
SELECT	p_name AS �Ԏ�
,	count(*) AS �̔��䐔
FROM	accept_order AS A
  NATURAL JOIN product as P
-- NATURAL JOIN �ɂ��AA��P��p_num���r���A�l��������������������
GROUP BY
	p_name

A2
SELECT	C.c_name AS �ڋq��
,	P.p_name AS �Ԏ�
FROM	customer AS C
,	accept_order AS A
,	product AS P
WHERE	A.c_num = C.c_num 
  AND	A.p_num = P.p_num

A2-1
SELECT	C.c_name AS �ڋq��
,	P.p_name AS �Ԏ�
FROM	customer AS C
  NATURAL JOIN accept_order AS A
  NATURAL JOIN product AS P
  
A3
SELECT	C.c_name AS �ڋq��
,	P.p_name AS �Ԏ�
,	P.price * (100 - A.dc_rate) / 100 + A.option_price AS �x�������z
FROM	customer AS C
,	accept_order AS A,
	product AS P
WHERE	A.c_num = C.c_num
  AND	A.p_num = P.p_num

A4
SELECT	C.c_name AS �ڋq��
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS �x�������z
FROM	customer AS C
,	accept_order AS A
,	product AS P
WHERE	A.c_num = C.c_num
  AND	A.p_num = P.p_num
GROUP BY
	c_name
ORDER BY
	�x�������z DESC


A5
SELECT	EXTRACT(YEAR	FROM A.accept_date) AS �N
,	EXTRACT(MONTH	FROM A.accept_date) AS ��
,	COUNT(*) AS �̔��䐔
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS ������
FROM	accept_order AS A
  NATURAL JOIN
	customer AS C
  NATURAL JOIN
	product AS P
GROUP BY �N, ��
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
  END	AS ��
,	COUNT(*) AS �̔��䐔
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS ������
FROM	accept_order AS A
  NATURAL JOIN
	customer AS C
  NATURAL JOIN
	product AS P
GROUP BY ��

A7
SELECT	E.e_name AS �]�ƈ���
,	count(*) AS �̔��䐔
FROM	accept_order AS A
  JOIN	employee AS E
  ON	A.employee = E.e_num
WHERE	E.gender = '1'
GROUP BY
	E.e_name
ORDER BY
	�̔��䐔 DESC

SELECT	E.e_name AS �]�ƈ���
,	count(*) AS �̔��䐔
,	E.gender AS ����
FROM	accept_order AS A
  JOIN	employee AS E
  ON	A.employee = E.e_num
GROUP BY
	E.e_name, E.gender
ORDER BY
	3, 2 DESC

/*
A8(�T�u�N�G����2��A���Ƃ��O���̃T�u�N�G���͉���������c)
--����ł����̂ŉߋ��̈╨
SELECT	CASE
  WHEN
	data2.sex = '0'	THEN	'����'
  WHEN
	data2.sex = '1'	THEN	'�j��'
  ELSE	NULL
  END	AS ����
,	data2.�]�ƈ���
,	data2.�̔��䐔
FROM
(
	SELECT	RANK () OVER
	(	
	PARTITION BY sex
	ORDER BY data.�̔��䐔 DESC
	)	AS ranking
	,	data.�]�ƈ���
	,	data.�̔��䐔
	,	data.sex
	FROM
	(
		SELECT	E.e_name AS �]�ƈ���
		,	count(*) AS �̔��䐔
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

A8�ʉ�
--�j���ʂ̃����L���O
--RANK��int�^�����A||�Ō�������Ǝ����I�ɕ�����^�ɕϊ������悤��(�m�F)
SELECT	RANK () OVER
(	
PARTITION BY sex
ORDER BY data.�̔��䐔 DESC
)	|| '��'
	AS �����L���O
--�j���̐��ʂ̕\��
,	CASE
  WHEN
	data.sex = '0'	THEN	'����'
  WHEN
	data.sex = '1'	THEN	'�j��'
  ELSE	NULL
  END	AS ����
--�T�u�N�G���̗񖼂����̂܂ܗ��p
,	data.�]�ƈ���
,	data.�̔��䐔
FROM
(
	SELECT	E.e_name AS �]�ƈ���
	,	count(*) AS �̔��䐔
	,	E.gender AS sex
	FROM	accept_order AS A
	  JOIN	employee AS E
	  ON	A.employee = E.e_num
	GROUP BY
		E.e_name, E.gender
	) AS data
ORDER BY �����L���O
LIMIT	2
/*�����L���O�Ń\�[�g����ƁA1�ʂ�2�o��B
����ĕ\��������2�ɐ������A1�ʂ݂̂��o��
�����A����1�ʂ�3�l�ȏ�o���ꍇ�̏����͂ǂ�����c�H
*/
