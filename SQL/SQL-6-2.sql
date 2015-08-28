/*****************************
�q��	�߂�l���^���l�ɂȂ�֐��̂���
*****************************/
-- DDL�F�e�[�u���쐬
CREATE TABLE SampleLike
( strcol VARCHAR(6) NOT NULL,
  PRIMARY KEY (strcol));

-- DML�F�f�[�^�o�^
BEGIN TRANSACTION;

INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');

COMMIT;


/*****************************
LIKE�q��
	������̕�����v����
	�O����v ��: ddd%	[ddd + �i0�����ȏ�̕�����)]							dddabc�Ȃ�
	���Ԉ�v ��: %ddd%	[�i0�����ȏ�̕�����) + ddd + �i0�����ȏ�̕�����)]		dddabc, adddbc, abcddd�Ȃ�
	�����v ��: %ddd	[�i0�����ȏ�̕�����) + ddd]							abcddd�Ȃ�
	
	%�̑����_���g���ƁA(�C�ӂ�1����)�̈Ӗ��ɂȂ�
*****************************/

SELECT *
  FROM SampleLike
 WHERE strcol LIKE 'ddd%'; -- �O����v

SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd%'; -- ���Ԉ�v

SELECT *
  FROM SampleLike
 WHERE strcol LIKE '%ddd'; -- �����v

SELECT *
  FROM SampleLike
 WHERE strcol LIKE 'abc__'; -- �����v(�ŏ���3������abc��5����)


/*****************************
<��f�[�^> BETWEEN <�ŏ��l> AND <�ő�l>
	�͈͌���
	���[���܂ނ̂ŁA�܂݂����Ȃ��ꍇ�� BETWEEN�ł͂Ȃ� < AND > ���g���K�v������
*****************************/

SELECT shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka BETWEEN 100 AND 1000;
 

/*****************************
IS NULL, IS NOT NULL
	NULL, ��NULL�̔���
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NULL;

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NOT NULL;
 

/*****************************
IN(�l1, �l2, ......)
	OR�֗̕��ȏȗ��`			--�l1, �l2...�݂̂�I���������ꍇ�̏ȗ�
	NOR�֗̕��ȏȗ��`�� NOT IN	--�l1, �l2...�ȊO��I���������ꍇ�̏ȗ�
	
	�ǂ����NULL�͑I���ł��Ȃ�
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IN (320, 500, 5000);
 
SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka NOT IN (320, 500, 5000);


/*****************************
IN(NOT IN)�q��̈����ɃT�u�N�G�����w��
	�T�u�N�G�� = SQL�����Ő������ꂽ�e�[�u���̂���
		=> IN�̓e�[�u���������Ɏw��ł���
		=> IN�̓r���[�������Ɏw��ł���
*****************************/

CREATE TABLE TenpoShohin
(tenpo_id  CHAR(4)       NOT NULL,
 tenpo_mei  VARCHAR(200) NOT NULL,
 shohin_id CHAR(4)       NOT NULL,
 suryo     INTEGER       NOT NULL,
 PRIMARY KEY (tenpo_id, shohin_id)); -- <= �X��ID�Ə��iID��g�ݍ��킹�邱�Ƃɂ���āA�B��ɒ�܂�

BEGIN TRANSACTION;

INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'����',		'0001',	30);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'����',		'0002',	50);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'����',		'0003',	15);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'���É�',	'0002',	30);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'���É�',	'0003',	120);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'���É�',	'0004',	20);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'���É�',	'0006',	10);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'���É�',	'0007',	40);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'���',		'0003',	20);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'���',		'0004',	50);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'���',		'0006',	90);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'���',		'0007',	70);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000D',	'����',		'0001',	100);

COMMIT;


/*****************************
��1)	���X(000C)�ɒu���Ă��鏤�i(shohin_id)�̔̔��P��(hanbai_tanka)�����߂�ꍇ
	1. TenpoShohin�e�[�u������A���X(tenpo_id = '000C')�������Ă��鏤�i(shohin_id)��I������
	2. Shohin�e�[�u������A1. �őI���������i(shohin_id)�̂ݔ̔��P��(hanbai_tanka)��I������
		
1. �̃X�e�b�v
SELECT shohin_id 
  FROM TenpoShohin
 WHERE tenpo_id = '000C');	-- ���̕������̂܂�2. �̏����Ƃ��ėp����΂��悢
*****************************/

-- �u���X�ɒu���Ă��鏤�i�̔̔��P���v�����߂�
SELECT shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE shohin_id IN (SELECT shohin_id 			--)
                       FROM TenpoShohin			--) ���̃T�u�N�G�����W�J�����ƁA
                      WHERE tenpo_id = '000C');	--) ('0003', '0004', '0006', '0007') �Ƃ������ʂ�������

-- ��2)�u�����X(000A)�ɒu���Ă��鏤�i�ȊO�̔̔��P���v�����߂�
SELECT shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE shohin_id NOT IN (SELECT shohin_id 
                           FROM TenpoShohin
                          WHERE tenpo_id = '000A');


/*****************************
EXISTS�q��
	EXISTS�͂���܂łɊw�񂾏q��Ƃ͎g�������قȂ�A�Ӗ��𒼊��I�ɗ�������̂����
	EXIST���g��Ȃ��Ă�IN(NOT IN)�ɂ���āA�u�قځv��p�ł���
	
	��������ɍ��v���郌�R�[�h�̑��ݗL���𒲂ׂ�
		���R�[�h�����݂����TRUE, ���Ȃ��Ȃ�FALSE
		EXISTS�̎��̓��R�[�h
*****************************/

-- ��1) ���X�ɒu���Ă��鏤�i�̔̔��P�������߂�
SELECT shohin_mei, hanbai_tanka
  FROM Shohin AS S
 WHERE EXISTS (SELECT *
                 FROM TenpoShohin AS TS
                WHERE TS.tenpo_id = '000C'
                  AND TS.shohin_id = S.shohin_id);

/*****************************
EXISTS�̎g����
	�����Ɉ����͂Ȃ��A���փT�u�N�G���݂̂������ɂƂ�
	(�����Ȃ�) EXISTS SELECT *(EXIST�̊��K)		-- (���փT�u�N�G��)
					    FROM <�e�[�u����> AS <�e�[�u����>
					   WHERE <����1>
					     AND <����2>
NOT EXISTS
	�T�u�N�G�����Ŏw�肵�������̃��R�[�h�����݂��Ȃ��ꍇ��TRUE��Ԃ�
*****************************/

-- ��2) �����X�ɒu���Ă��鏤�i�ȊO�̔̔��P�������߂�
SELECT shohin_mei, hanbai_tanka
  FROM Shohin AS S
 WHERE NOT EXISTS (SELECT *
                     FROM TenpoShohin AS TS
                    WHERE TS.tenpo_id = '000A'
                      AND TS.shohin_id = S.shohin_id);