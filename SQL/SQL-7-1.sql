/*****************************
�W�����Z
	���R�[�h�̎l�����Z
	
	�W��: ���R�[�h�̏W��
		�e�[�u���A�r���[�E�N�G���̎��s���ʂȂ�
*****************************/

CREATE TABLE Shohin2
(shohin_id     CHAR(4)      NOT NULL,
 shohin_mei    VARCHAR(100) NOT NULL,
 shohin_bunrui VARCHAR(32)  NOT NULL,
 hanbai_tanka  INTEGER      ,
 shiire_tanka  INTEGER      ,
 torokubi      DATE         ,
 PRIMARY KEY (shohin_id));

BEGIN TRANSACTION;

INSERT INTO Shohin2 VALUES ('0001', 'T�V���c' ,'�ߕ�', 1000, 500, '2009-09-20');
INSERT INTO Shohin2 VALUES ('0002', '�������p���`', '�����p�i', 500, 320, '2009-09-11');
INSERT INTO Shohin2 VALUES ('0003', '�J�b�^�[�V���c', '�ߕ�', 4000, 2800, NULL);
INSERT INTO Shohin2 VALUES ('0009', '���', '�ߕ�', 800, 500, NULL);
INSERT INTO Shohin2 VALUES ('0010', '�₩��', '�L�b�`���p�i', 2000, 1700, '2009-09-20');

COMMIT;


/*****************************
�e�[�u���̑����Z�ƈ����Z
	�����Z�i�a�W��)
SELECT <��f�[�^1>, <��f�[�^2>, ...
  FROM <�e�[�u��1>
UNION
SELECT <��f�[�^1>, <��f�[�^2>, ...
  FROM <�e�[�u��2>

�d���s���c���W�����Z
	UNION �̌���ALL ������
*****************************/

SELECT shohin_id, shohin_mei
  FROM Shohin
UNION
SELECT shohin_id, shohin_mei
  FROM Shohin2
ORDER BY shohin_id;	-- shohin_id�̏��ɕ��ёւ�

SELECT shohin_id, shohin_mei
  FROM Shohin
UNION ALL
SELECT shohin_id, shohin_mei
  FROM Shohin2;


/*****************************
�W�����Z�̒��ӎ���
	1. ���Z�ΏۂƂȂ郌�R�[�h�̗񐔂͓����ł��邱��
	2. �����Z�̑ΏۂƂȂ郌�R�[�h�̗�̃f�[�^�^����v���Ă��邱��
		�ǂ����Ă��Ⴄ�f�[�^�^�̗���g�������ꍇ�́A�^�ϊ��֐�CAST��p����
	3. SELECT���͂ǂ�Ȃ��̂��w�肵�Ă��悢���AORDER BY��͍Ō�Ɉ����
*****************************/

/*****************************
INTERSECT(����)
	2�̃��R�[�h�̋��ʕ�����I��

EXCEPT(��)
	�e�[�u��1�̃��R�[�h����e�[�u��2�̃��R�[�h���������c���I��
*****************************/

SELECT shohin_id, shohin_mei
  FROM Shohin
EXCEPT
SELECT shohin_id, shohin_mei
  FROM Shohin2
ORDER BY shohin_id;

SELECT shohin_id, shohin_mei
  FROM Shohin2
EXCEPT
SELECT shohin_id, shohin_mei
  FROM Shohin
ORDER BY shohin_id;