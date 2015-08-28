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
��L�[��NOT NULL�͕s�v(NOT NULL�������Ŋ܂�)
check���g�����ƂŃf�[�^�𐧌��ł���
�e�[�u�����폜����Ƃ��́A���g�������Ă���ꍇDELETE=>DROP TABLE �e�[�u����
*/


A3-3
ALTER TABLE
	employee
  ADD 	FOREIGN KEY (office)
  REFERENCES
  	office(o_num);

/*
�e�L�[: �Q�Ƃ���鑤
�O���L�[: �Q�Ƃ��鑤

�e�[�u���̕ύX�Ȃ̂�ALTER TABLE employee ADD

FOREIGN KEY����R�[�h�̊�{�`��
FOREIGN KEY �񃊃X�g REFERENCES �e�e�[�u��(�񃊃X�g) ; ���㔼��

FOREIGN KEY (office)  <=�O���L�[��employee.office��
REFERENCES office(o_num)  <=�e�L�[��office.o_num��
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
����i�f�[�^�S�폜�j���s�����Ƃ�DROP TABLE���e�[�u�����폜�ł���B
����s�݂̂����������ꍇ��where���g������
*/


A5-1
SELECT	e_name
FROM	employee
WHERE	e_name like '% To%'; 

--�c����To%�̊Ԃ�Space���͂��ނ��ƂŁA�c����To�Ŏn�܂�l�𔲂��o���Ȃ��悤�ɂ��Ă���
--�C�ӂ̕�������%, �C�ӂ�1������_���g���ĕ\��

A5-2
SELECT	count(gender)
,	office
FROM	employee
WHERE	gender = '1'
GROUP BY
	office

--FROM�Ńe�[�u���w��=>WHERE�Ŕ͈͍i�荞��=>GROUP BY�ł܂Ƃ�=>SELECT�ŕ\��


A6-1
SELECT	O.office AS �c�Ə���
,	COUNT(*) AS �ڋq��
FROM	customer AS C
,	office AS O
WHERE	C.office = O.o_num
GROUP BY
	O.office

/*
�c�Ə����ƌڋq����''�͂���Ȃ�
  FROM�Ńe�[�u���̓ǂݍ���
=>WHERE�Ńe�[�u���̌���
=>GROUP BY��O.office[Osaka office...]�̒l���g�����W��
    C.office[10, 20, 30]�ŃO���[�v�������̂͐��������ASELECT���O.office�������Ȃ�
    (GROUP BY���g�������ASELECT��Ɏg����̂�GROUP BY��Ŏw�肵����ƏW���֐��̂�)
=>SELECT AS�������ė�^�C�g����ύX�A�o��
*/

�ʉ�
SELECT	O.office AS �c�Ə���
,	count(*) AS �ڋq�̐l��
FROM	customer AS C
  JOIN	office AS O
  ON	C.office = O.o_num
GROUP BY
	O.office


A6-2
SELECT	C.c_name AS �ڋq��
, 	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS �x�������z
FROM	accept_order AS A
,	product AS P
,	customer AS C
WHERE	A.p_num = P.p_num
  AND	A.c_num = C.c_num
GROUP BY
	C.c_name
ORDER BY
	�x�������z DESC

--3�̃e�[�u���������A�����̏�������AND�Ō���
�ʉ�
SELECT	C.c_name AS �ڋq��
,	SUM(P.price * (100 - A.dc_rate) / 100 + A.option_price) AS �x�������z
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
SELECT	E.e_name AS �]�ƈ���
,	COUNT(*) AS �̔�����
FROM	employee AS E
,	accept_order AS A
WHERE	A.employee = E.e_num 
  AND	A.accept_date BETWEEN '20010301' AND '20010331'
GROUP BY
	E.e_name
ORDER BY
	�̔�����
	
�ʉ�
SELECT	E.e_name AS �]�ƈ���
,	count(*) AS �̔�����
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
1. A2�̌ڋq�ԍ���'1007'
2. A1�̏��i�ԍ���A2�̏��i�ԍ�������
3. A1�̌ڋq�ԍ���A2�̌ڋq�ԍ����Ⴄ
=>�ڋq�ԍ��� '1007' �̌ڋq�Ɠ��������Ԃ��w���������R�[�h�����o�����B
  �������A'1007'�͓���Ȃ��B
*/


A6-5
INSERT INTO
	employee
	VALUES('108', 'Fujiwara Norio', '2001', '1', '10')

SELECT	E.e_name AS �]�ƈ�
,	SUM(A.option_price) AS �I�v�V��������
FROM	accept_order AS A
  RIGHT OUTER JOIN
  	employee AS E
  ON	A.employee = E.e_num
GROUP BY
	E.e_name

/*
A RIGHT OUTER JOIN B ON A... = B...
<�e�[�u�� B> �̂��ׂĂ̍s�ƁA<�e�[�u�� A> �ň�v�����o���ꂽ�s���܂܂��B
<�e�[�u�� A> �ň�v�����o����Ȃ������s�ɂ� NULL ���ݒ肳���B
����͏]�ƈ��S���̃f�[�^��(�I�v�V������0�ł�)�ق����̂ŁA
employee����ɊO�������B
FROM employee AS E LEFT OUTER JOIN ... accept_order AS A ON ...�ł��������OK�B
*/


A7-1
SELECT	DISTINCT C2.c_name AS �ڋq��
,	C2.address AS �Z��
FROM	customer AS C2
  NATURAL JOIN
  	accept_order AS A2
  NATURAL JOIN
  	product AS P2 --NATURAL JOIN �ɂ�錋��
WHERE	P2.price * (100 - A2.dc_rate) / 100 + A2.option_price >
(	SELECT	AVG(P1.price * (100 - A1.dc_rate) / 100 + A1.option_price)
	FROM	accept_order AS A1
		NATURAL JOIN product AS P1
);
/*
���̖���1�񂠂���̎x�����z�Ŕ��肵�Ă���i������̍w���͍l�������j
�N�G���ƃT�u�N�G���͂��ꂼ�ꃍ�[�J���ł��邱�Ƃ��������߁A�����ĕϐ�����v�����Ă��Ȃ�
�i�ʏ�Ȃ�S��A, C, P�œ��ꂵ�Ė��Ȃ��j
	=>�T�u�N�G������N�G���ɏo�����AFROM��ŐV����AS��p�������O�̕ύX���K�v
	
�T�u�N�G��
A��P������������āA�x�����z���Z�o�A���ω�
AVG()�͈̔͂�FROM�̑O(AVG�̍s1��)
�N�G��
�T�u�N�G���ŎZ�o���ꂽAVG����ɁA�ڋq���Ƃ̋��z���Z�o�A��r
�������^�̏ꍇ�AA, C, P������������Ė��O�ƏZ��������o���ADISTINCT�ŏd�����폜
*/


A7-2
SELECT	 O1.office AS �c�Ə���, O2.price AS ������z
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
O2.price��SELECT���2�Ԗڂł��邽�߁AO2.price����ɂ���Ƃ����̂悤�ɋL�q���Ă��悢�B
(ORDER BY ������z DESC�Ɠ���)
������z�A�c�Ə����̏��Ƀ\�[�g���s�������ꍇ�́AORDER BY 2,1�ƋL�q����
*/


A7-3
SELECT	E2.e_name AS �]�ƈ���
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
SELECT '1��' AS ��, count(*) AS ����䐔
   FROM accept_order
   WHERE accept_date BETWEEN '20010101' AND '20010131'
UNION
SELECT '2��' AS ��, count(*) AS ����䐔
   FROM accept_order
   WHERE accept_date BETWEEN '20010201' AND '20010228'
UNION
SELECT '3��' AS ��, count(*) AS ����䐔
   FROM accept_order
   WHERE accept_date BETWEEN '20010301' AND '20010331';

�ʉ�(UNION���g��Ȃ�)
SELECT	
  CASE WHEN
	accept_date BETWEEN '20010101' AND '20010131'
	THEN '1��'
  WHEN
	accept_date BETWEEN '20010201' AND '20010228'
	THEN '2��'
  WHEN
	accept_date BETWEEN '20010301' AND '20010331'
	THEN '3��'
  ELSE	NULL
  END AS ��
,	COUNT(*)
FROM	accept_order
GROUP BY ��


A8-2
SELECT	c.c_name AS �ڋq��
,	co.office AS �ڋq�Ǘ��c�Ə���
,	e.e_name AS �̔��]�ƈ���
,	eo.office AS �̔��c�Ə���
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
EXCEPT�̏� => accept_order, customer, employee�������������ׂĂ̌���
EXCEPT�̉� => �������͓̂����B�������A��̕\�����鏇�Ԃɕω�����(c.office, e.office)
	c.office��e.office�̒l���ς��Ȃ���΁A�ڋq�Ə]�ƈ��̎������ɕω��͂Ȃ��B
�܂�A����ɂ���Čڋq�Ə]�ƈ��̎������ɕω���������݂̂̂��ڂ��Ă���
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
�ڋq�̉c�Ə����Ə]�ƈ��̉c�Ə��������ꂼ��擾���邽�߁A
office��ʖ���2��e�[�u���Ɍ������A�f�[�^����ʂ��Ă���
*/
�ʉ�(EXCEPT���g��Ȃ�����)
SELECT	C.c_name AS �ڋq��
,	CO.office AS �ڋq�Ǘ��c�Ə���
,	E.e_name AS �̔��]�ƈ���
,	EO.office AS �̔��c�Ə���
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
�l�����͏�Ɠ����B
������WHERE��1���ŕ\���ł���̂ŁA����Ŋȗ����B
*/


A9-1
CREATE	VIEW MonthCarsListView AS
SELECT	'1��' AS ��
,	count(*) AS ����䐔
FROM	accept_order
WHERE	accept_date BETWEEN '20010101' AND '20010131'
UNION
SELECT '2��' AS ��
,	count(*) AS ����䐔
FROM	accept_order
WHERE	accept_date BETWEEN '20010201' AND '20010228'
UNION
SELECT '3��' AS ��
,	count(*) AS ����䐔
FROM	accept_order
WHERE	accept_date BETWEEN '20010301' AND '20010331';


A9-2
CREATE VIEW OfficeCheckView AS
SELECT	c.c_name AS �ڋq��
,	co.office AS �ڋq�Ǘ��c�Ə���
,	e.e_name AS �̔��]�ƈ���
,	eo.office AS �̔��c�Ə���
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
SELECT	MAX(����䐔) AS �ő�
,	MIN(����䐔) AS �ŏ�
,	AVG(����䐔) AS ����
FROM	MonthCarsListView

