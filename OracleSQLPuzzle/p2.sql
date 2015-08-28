����ōl���悤

2-1-2 �A�������X�J���[�₢���킹(���s��)

���
Table1��Col1�̍��v�ƁA
Table2��Col1�̕��ςƁA
Table3��Col1�̍ŏ��l�ƁACol2�̍ő�l���擾����B

��
SELECT	(SELECT SUM(col1) FROM Table1), (SELECT AVG(col1) FROM Table2)
,	(SELECT MIN(col1) FROM Table3), (SELECT MAX(col2) FROM Table3)
--FROM�����Ȃ��Ă�SELECT()�͂ǂ���X�J���E�T�u�N�G���Ȃ̂Ŗ��Ȃ�

2-1-3 select���̌��ʂ��g����update

���
Table1                    Table2
PKey  Val1  Val2  Val3    PKey  Val1  Val2  Val3
----  ----  ----  ----    ----  ----  ----  ----
  10  aaaa  bbbb  cccc      10  xxxx  yyyy  zzzz
  20  dddd  eeee  ffff      30  1111  2222  3333

Table1��PKey�ɕR�Â��ATable2�̒l���g���āATable1��Val1,Val2,Val3��update����B
�������ATable2�ɕR�Â����R�[�h�����݂��郌�R�[�h�݂̂�ΏۂƂ���B

Table1�ATable2�̃v���C�}���L�[�́APKey�Ƃ���B

�X�V����
Table1
PKey  Val1  Val2  Val3
----  ----  ----  ----
  10  xxxx  yyyy  zzzz
  20  dddd  eeee  ffff

�f�[�^�쐬�X�N���v�g
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

��
--UPDATE���̊�{=>UPDATE <�e�[�u����> SET <��> = <��> WHERE <����>
UPDATE	Table1 AS t1
SET	Val1 = (SELECT t2.Val1 FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
,	Val2 = (SELECT t2.Val2 FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
,	Val3 = (SELECT t2.Val3 FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
	/*WHERE�𔲂��ƃG���[
	  �X�J���E�T�u�N�G���ɂȂ�Ȃ����߂���?*/
WHERE	EXISTS(SELECT * FROM Table2 AS t2 WHERE t2.PKey = t1.PKey)
	--EXISTS�̓��R�[�h���Ƃ�T��F�݂̂�Ԃ��AUPDATE��T�̂ݎ��s�����
	
/*WHERE�����Ȃ���2�s�ڂ�Val�͑S��NULL
PKey  Val1  Val2  Val3
----  ----  ----  ----
  10  xxxx  yyyy  zzzz
  20  NULL  NULL  NULL
  SET����WHERE��ɑΉ�����t2.PKey���Ȃ�����*/

2-1-4 �A������null�`�F�b�N

���
nullTable
Col1  Col2  Col3  Col4
----  ----  ----  ----
   1     2     3     4
   1     2     3  null
null     2     3     4
null  null  null  null

�e�[�u����Col1�ACol2�ACol3�ACol4���擾����B
������Col1�ACol2�ACol3�ACol4���S��null�Ȃ�擾���Ȃ�

�o�͌���
Col1  Col2  Col3  Col4
----  ----  ----  ----
   1     2     3     4
   1     2     3  null
null     2     3     4

��
SELECT	*
FROM	nullTable
WHERE	Col1 IS NULL AND Col2 IS NULL 
	AND Col3 IS NULL AND Col4 IS NULL
  
�����Ɗȗ��ɁI(COALESCE���g��)
SELECT	*
FROM	nullTable
WHERE	COALESCE(Col1, Col2, Col3, Col4) IS NOT NULL
/*COALESCE�͈����������珇�Ԃɒ��ׁA��ԏ��߂�NULL�łȂ�������Ԃ�=>�S��NULL�Ȃ�NULL
  �ǂꂩ�ɒl�����݂����NULL�ȊO��Ԃ��̂ŁA����Ŕ��ʉ�*/

2-1-6 �����`�̑��e�[�u���Ɣ�r

tbl1
ID  ���O      �퓬  �єz
--  --------  ----  ----
 1  �D�c�M��    70    94
 2  �ēc����    86    85
 3  �O�c����    69    72
 5  �؉��G�g    59    91
 6  ����ƍN  null  null
 7  null      null  null

tbl2
ID  ���O      �퓬  �єz
--  --------  ----  ----
 1  �g�@�t      70    94
 2  �ēc����    86  null
 4  ���q���G    61    87
 5  �؉��G�g    59    91
 6  null      null  null
 7  null      null  null

tbl1��ID�A���O�A�퓬�A�єz�ƁA
tbl2��ID�A���O�A�퓬�A�єz���r��(null��null�͓����������Ƃ���)
ID(�v���C�}���L�[)���������Ēl���Ⴄ�f�[�^�ƁA
tbl1�Atbl2�́A�Е��݂̂ɑ��݂���f�[�^���擾����B

�o�͌`���́A
tbl1��ID(tbl2�݂̂ɑ��݂����null),tbl2��ID(tbl1�݂̂ɑ��݂����null),
tbl1�̖��O,tbl2�̖��O,tbl1�̐퓬,tbl2�̐퓬,tbl1�̍єz,tbl2�̍єz
�Ƃ���B

�o�͌���
 AID   BID  A���O     B���O     A�퓬  B�퓬   A�єz  B�єz
----  ----  --------  --------  -----  -----  -----  -----
   1     1  �D�c�M��  �g�@�t       70     70     94     94
   2     2  �ēc����  �ēc����     86     86     85   null
   3  null  �O�c����  null         69   null     72   null
null     4  null      ���q���G   null     61   null     87
   6     6  ����ƍN  null       null   null   null   null

�f�[�^�쐬�X�N���v�g
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

insert into tbl1 values(1,'�D�c�M��',70,94);
insert into tbl2 values(1,'�g�@�t'  ,70,94);
insert into tbl1 values(2,'�ēc����',86,85);
insert into tbl2 values(2,'�ēc����',86,null);
insert into tbl1 values(3,'�O�c����',69,72);
insert into tbl2 values(4,'���q���G',61,87);
insert into tbl1 values(5,'�؉��G�g',59,91);
insert into tbl2 values(5,'�؉��G�g',59,91);
insert into tbl1 values(6,'����ƍN',null,null);
insert into tbl2 values(6,null,null,null);
insert into tbl1 values(7,null,null,null);
insert into tbl2 values(7,null,null,null);

��
--��蕶��LEAST���g���A�ǂ��炩�Е���NULL�Ȃ�NULL��Ԃ��O��ŉ񓚂�����Ă��邪�A����͊Ԉ���Ă���
--����Ę_���a���g���A���������ʂ��o��
SELECT	T1.id, T2.id
,	T1.name, T2.name
,	T1.war, T2.war
,	T1.talent, T2.talent
FROM	tbl1 AS T1
  FULL OUTER JOIN tbl2 AS T2
  ON	T1.id = T2.id
WHERE	T1.name <> T2.name			  --���O���ǂ����NULL�łȂ��A�����O���Ⴆ�ΐ^
  OR	(COALESCE(T1.name, T2.name) IS NOT NULL   --���O���ǂ����NULL�łȂ���ΐ^
	AND (T1.name IS NULL OR T2.name IS NULL)) --���O�̂ǂ��炩��NULL�ł���ΐ^
	--=>���O�̑g�ݍ��킹���Ⴄor���O�̈���݂̂�NULL�̂ݕ\�������
	
	--�ȉ����l
  OR	T1.war <> T2.war
  OR	(COALESCE(T1.war, T2.war) IS NOT NULL
	AND (T1.war IS NULL OR T2.war IS NULL))
  OR	T1.talent <> T2.talent
  OR	(COALESCE(T1.talent, T2.talent) IS NOT NULL
	AND (T1.talent IS NULL OR T2.talent IS NULL))
ORDER BY
	COALESCE(T1.ID, T2.ID)--COALESCE�Ŕԍ����܂Ƃ߂Ă���

2-1-8 �ł��߂��{���ɁA���l��ϊ�

���
���l���A�ł��߂�5�̔{���ɐ��l��؂�グ�A����сA
�ł��߂�5�̔{���ɐ��l��؂艺����B
�� Val = 10.5  => 15, 10
   Val = -1.5  => 0, -5

��
--�؂�グ�֐���ceil, �؂�̂Ċ֐���floor
SELECT	Val
,	CEIL(Val/5)  *5 AS �؂�グ
,	FLOOR(Val/5) *5 AS �؂�̂�
FROM	(SELECT 10.5 AS VAL) AS A
UNION
SELECT	Val
,	CEIL(Val/5)  *5 AS �؂�グ
,	FLOOR(Val/5) *5 AS �؂�̂�
FROM	(SELECT -1.5 AS VAL) AS A

/*FROM	(SELECT 10.5 AS VAL UNION
	 SELECT 10 ) �̂悤��PostgreSQL�ŏ����Ȃ���?*/

2-2-2 select��ŃT�u�N�G��

���

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

Table1��Code2(Table2�̊O���L�[)�ɕR�Â�Table2��Name�̒l�A
Table1��Code3(Table3�̊O���L�[)�ɕR�Â�Table3��Name�̒l�A
Table1��Code4�ɕR�Â�Table4��Val�̒l�̍ő�l�ƍŏ��l���擾����B

�o�͌���
Name  Code2  Code3  Code4  Name2  Name3  maxVal  minVal
----  -----  -----  -----  -----  -----  ------  ------
aaaa   501    601    701   AAAA   DDDD      789     123
bbbb   502    602    999   BBBB   EEEE     null    null
cccc   503    999    702   CCCC   null      456     321
dddd   999    603    703   null   FFFF      987     987
eeee   999    999    999   null   null     null    null

�f�[�^�쐬�X�N���v�g
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

��
SELECT	DISTINCT T1.name AS "NAME"
,	T1.code2 AS "Code2", T1.code3 AS "Code3", T1.code4 AS "Code4"
,	T2.name AS "Name2", T3.name AS "Name3"
,	MAX(T4.val) OVER (PARTITION BY T1.name)--���O���Ƃ�val�̍ő�l
,	MIN(T4.val) OVER (PARTITION BY T1.name)--���O���Ƃ�val�̍ŏ��l
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

�X�J���[���₢���킹���g����������
select Name, Code2, Code3, Code4
,	(SELECT b.Name FROM Table2 b WHERE b.Code = a.Code2) as Name2
,	(SELECT b.Name FROM Table3 b WHERE b.Code = a.Code3) as Name3
,	(SELECT max(val) FROM Table4 b WHERE b.code = a.Code4) as maxVal
,	(SELECT	min(val) FROM Table4 b WHERE b.code = a.Code4) as minVal 
from Table1 a;

2-2-3 in�q��̈����ɃT�u�N�G��
���

Table1        Table2
Col1  Col2    Col3  Col4
----  ----    ----  ----
1111  1111    1111  2222
1111  2222    2222  1111
1111  3333    2222  2222
2222  1111    2222  3333
2222  2222
2222  3333

Table1��Col1,Col2�̒l�̑g�ݍ��킹�Ɠ���̑g�ݍ��킹���A
Table2��Col3,Col4�̒l�̑g�ݍ��킹�̏W���̒��ɑ��݂�����A
Table1�̊Y�����R�[�h��Delete����B

�폜����
Table1
Col1  Col2
----  ----
1111  1111
1111  3333

��
DELETE	
FROM	Table1 AS T1
WHERE	EXISTS(
		SELECT * FROM Table2 AS T2
		WHERE T1.Col1 = T2.Col3 AND T3.COl3 = T4.Col4
	) AS TE
	
2-2-7 case����exists�q��
���

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

Table1�̎�L�[��
Table2����O���L�[�o�R�ŎQ�Ƃ���Ă����1�A����ĂȂ����0
���擾����B

�o�͌���
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

2-2-8 exists�q��̈����ɏW�����Z
���

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

Table1��Col1���A
Table2��Table3�̏��Ȃ��Ƃ��Е�����A�O���L�[�o�R�ŎQ�Ƃ���Ă����1�A����ĂȂ����0
���o�͂���B

Table1�ATable2�ATable3�̃v���C�}���L�[�́ACol1�Ƃ���B

�o�͌���
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

2-2-11 case����LNNVL�q��
���

BoolTable
Val1  Val2
----  ----
   1     9
   9     9
   9     1
null     1
   1  null

Val1��Val2���r���AVal1 < Val2��true�łȂ����(unknown��false�ł����)1�A
Val1��Val2���r���AVal1 < Val2��false�łȂ����(unknown��true�ł����)1�A
���擾����B

�o�͌���
Val1  Val2  IsNotTrue  IsNotFalse
----  ----  ---------  ----------
   1     9          0           1
   9     9          1           0
   9     1          1           0
null     1          1           1
   1  null          1           1
   
��
SELECT	Val1, Val2
,	CASE WHEN Val1 < Val2 /*= TRUE*/THEN 1 ELSE 0
	END AS IsNotTrue
,	CASE WHEN Val1 < Val2 = FALSE THEN 1 ELSE 0
	END AS IsNotFalse
FROM	BoolTable

2-3-2 �O���̃��R�[�h���擾
���
table1
date1      Val1
---------  ----
2005/5/25     2
2005/5/24     1
2005/5/23     3
2005/5/20     6

Table1��Date1(Date�^)�ƁAVal1�ƁA
Date1���O���̃��R�[�h��Val1(�O���̃��R�[�h�����݂��Ȃ����0)
���擾����B
Table1�̃v���C�}���L�[�́ADate1�Ƃ���B

�o�͌���
date1      Val1  BeforeVal1
---------  ----  ----------
2005/5/25     2           1
2005/5/24     1           3
2005/5/23     3           0
2005/5/20     6           0

��
SELECT	A.date1, A.Val1
,	CASE WHEN EXISTS(
		SELECT * FROM Table1 AS B WHERE A.date1 = B.date1 - 1
		)THEN (SELECT B.Val1 FROM Table1 AS B WHERE A.date1 = B.date1 - 1) ELSE 0
	END AS BeforeVal1
FROM	table1 AS A

2-3-5 ���[�h(�ŕp�l)���擾
���

�ŕp�l�e�[�u��
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

�ŕp�l�e�[�u���́A
Col1�̍ŕp�l(�ł��������݂���l)�ƁA
�ŕp�l�̃��R�[�h�����擾����B

�o�͌���
�ŕp�l  �ŕp�l�̃��R�[�h��
------  ------------------
    40                   4
    50                   4
    60                   4

�f�[�^�쐬�X�N���v�g

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

��
SELECT	Col1, �ŕp�l�̃��R�[�h��
FROM	(SELECT	Col1
	,	COUNT(*) as ���R�[�h��
	,	max(count(*)) OVER() as �ŕp�l�̃��R�[�h�� FROM Table1 GROUP BY Col1
	) AS T
WHERE ���R�[�h�� = �ŕp�l�̃��R�[�h��
ORDER BY Col1;

2-3-8 �ߋ��̍ō�������擾

����e�[�u������A�S����ID���ƁA�N�����ƂɁA
�N�����_�ł̍ō������\������B

����e�[�u��
�S����ID    �N��    ����
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

�o�͌���
�S����ID    �N��    ����   �ō�����
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
	id AS �S����ID
,	ym AS �N��
,	sale AS ����
,	MAX(����) OVER (PARTITION BY �S����ID ORDER BY �N��) AS �ō�����
FROM	table1
ORDER BY
	�S����ID

