/*****************************
�֐��̎��
	1. �Z�p�֐�
		���l�̌v�Z���s���֐�
	2. ������֐�
		�i������𑀍삷�邽�߂̊֐��j
	3. ���t�֐�
		�i���t�𑀍삷�邽�߂̊֐��j
	4. �ϊ��֐�
		�i�f�[�^�^��l��ϊ����邽�߂̊֐��j
	5. �W��֐� 
		�i�f�[�^�̏W�v���s�����߂̊֐��j--�K���ς�
******************************/

/*****************************
1.�Z�p�֐�
*****************************/

-- DDL (�f�[�^��`����)�F�e�[�u���쐬
CREATE TABLE SampleMath
(m  NUMERIC (10,3),	-- (�S�̂̌���, �����̌����j�ɂ�萔�l�̑傫�����w��
 n  INTEGER,
 p  INTEGER);

-- DML (�f�[�^���쌾��)�F�f�[�^�o�^
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

-- DCL (�f�[�^���䌾��) :�f�[�^�m��
COMMIT;

-- �e�[�u���̓��e�m�F
SELECT * FROM SampleMath;


/*********
ABS(���l)
	��Βl�����߂�֐�
*********/

SELECT m,
       ABS(m) AS abs_col
  FROM SampleMath;


/*********
MOD(�폘��, ����)
	��]�����߂�֐�
	�]��Ƃ����T�O��A�����^�̗񂾂��ɂȂ�
*********/

SELECT n, p,
       MOD(n, p) AS mod_col
  FROM SampleMath;


/*********
MOD(�Ώې�, �ۂ߂̌���)
	�l�̌ܓ�����֐�
	�ۂ߂̌����܂ł̐��l���\�������: 0 => �����l, 2 => ������2�ʂ܂Łi������3�ʂ��l�̌ܓ�)
*********/

SELECT m, n,
       ROUND(m, n) AS round_col
  FROM SampleMath;


/*****************************
2.������֐�
*****************************/

-- DDL�F�e�[�u���쐬
CREATE TABLE SampleStr
(str1  VARCHAR(40),
 str2  VARCHAR(40),
 str3  VARCHAR(40));

-- DML�F�f�[�^�o�^
BEGIN TRANSACTION;

INSERT INTO SampleStr (str1, str2, str3) VALUES ('������',	'����'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc'	,	'def'	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('�R�c'	,	'���Y'  ,	'�ł�');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa'	,	NULL    ,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL	,	'������',	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%',	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC'	,	NULL	,	NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc���Y',	'abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdefabc','abc'	,	'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('�~�b�N�}�b�N',	'�b', '��');

COMMIT;


-- �e�[�u���̓��e�m�F
SELECT * FROM SampleStr;


/*********
������1 || ������2
	�A��
	����������NULL�̏ꍇ�A���ʂ�NULL
	3�ȏ�Ȃ��邱�Ƃ��\
*********/

SELECT str1, str2, str3,
       str1 || str2 || str3 AS str_concat
  FROM SampleStr
 WHERE str1 = '�R�c';


/*********
LENGTH�i������j
	������
	�����������������ׂ�
*********/

SELECT str1,
       LENGTH(str1) AS len_str
  FROM SampleStr;


/*********
LOWER�i������j
	��������
	�A���t�@�x�b�g�̑啶���݂̂Ɋ֌W���A�S�ď������ɂ���
	����������啶����UPPER
*********/

SELECT str1,
       LOWER(str1) AS low_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', '�R�c');

SELECT str1,
       UPPER(str1) AS up_str
  FROM SampleStr
 WHERE str1 IN ('ABC', 'aBC', 'abc', '�R�c');
 
 
/*********
REPLACE(�Ώە�����, �u���O�̕�����, �u����̕�����)
	�u��
	�����񒆂̂���ꕔ���̕������ʂ̕�����ɂ���������
*********/

SELECT str1, str2, str3,
       REPLACE(str1, str2, str3) AS rep_str
  FROM SampleStr;


/*********
SUBSTRING(�Ώە����� FROM �؂�o���J�n�ʒu FOR �؂�o��������)
	�؂�o��
	�����񒆂̂���ꕔ���̕������؂�o��
	FROM��FOR�̌��͐����l������A�u�������ڂ���v�u�����������o���v�����w�肷��
*********/

SELECT str1,
       SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
  FROM SampleStr;


/*****************************
3.���t�֐�
*****************************/

/*********
CURRENT_DATE
	���݂̓��t
	���̊֐������s���ꂽ����߂�l�Ƃ��ĕԂ�

CURRENT_TIME
	���݂̎���
	���̊֐������s���ꂽ���Ԃ�߂�l�Ƃ��ĕԂ�

CURRENT_TIMESTAMP
	���݂̓���
	���̊֐������s���ꂽ������߂�l�Ƃ��ĕԂ�
*********/

SELECT CURRENT_DATE;

SELECT CURRENT_TIME;

SELECT CURRENT_TIMESTAMP


/*********
EXTRACT
	���t�v�f�̐؂�o��
	���t�f�[�^����u�N�v��u���v�A�u�b�v��؂�o���ꍇ�Ɏg��
	�߂�l�͐��l�^
*********/

/*****************************
4. �ϊ��֐�
*****************************/

/*********
CAST(�ϊ��O�̒l AS �ϊ�����f�[�^�^
	�^�ϊ�
	�^���s��v�̂̃G�A�[�����������
*********/

SELECT CAST('0001' AS INTEGER) AS int_col;

SELECT CAST('2009-12-14' AS DATE) AS date_col;


/*********
COALESCE�i�f�[�^1, �f�[�^2, �f�[�^3, ......)
	NULL��l�֕ϊ�
	���̈������珇�Ɍ��Ă����A���߂�NULL�łȂ��������̐��l��Ԃ�
	��: NULL NULL 3 NULL 5�̏ꍇ�A�߂�l��3
	
	NULL�����Z�E�֐��ɕ��ꍞ�ނƑS��NULL�ɂȂ邽�߁A���������鎞�ɏd��
*********/

SELECT COALESCE(NULL, 1)                  AS col_1,
       COALESCE(NULL, 'test', NULL)       AS col_2,
       COALESCE(NULL, NULL, '2009-11-01') AS col_3;

SELECT COALESCE(str2, 'NULL�ł�')	-- <= ���̂悤�ɂ��Ă����ƁAstr2�̒l���S��NULL�ł�NULL��Ԃ��Ȃ��Ȃ�
  FROM SampleStr;
