/******************************

�f�[�^�x�[�X�̍쐬

CREATE DATABASE <�f�[�^�x�[�X��>;


�e�[�u���̍쐬

CREATE TABLE <�e�[�u����>
(<��1> <�f�[�^�^> <���̗�̐���>,
 <��2> <�f�[�^�^> <���̗�̐���>,
 ...
 
 <���̃e�[�u���̐���1>, <���̃e�[�u���̐���2>,...... );
 
******************************/

CREATE TABLE Shohin
(shohin_id     CHAR(4)      NOT NULL,-- <= ���L���͕s��(�G���[���N����)
 shohin_mei    VARCHAR(100) NOT NULL,
 shohin_bunrui VARCHAR(32)  NOT NULL,
 hanbai_tanka  INTEGER ,
 shiire_tanka  INTEGER ,
 torokubi      DATE ,
 PRIMARY KEY (shohin_id));
 
/*****************************
�f�[�^�^

1. INTEGER�i���l�j�^
	�����݂̂�����i�����͓�����Ȃ��j
	
2. CHAR(������^)
	CHAR(10)�Ȃǂ̂悤�ɍő啶�������w�肵�Ďg���B
	CHAR(8)��'ABC'���������Ƃ��A'ABC     '�Ƃ����i�X�y�[�X5�����ɂ��j�`�Ŋi�[�����B
	
3. VARCHAR(�ϒ�������)�^
	CHAR�Ǝ��Ă��邪�AVARCHAR(8)��'ABC'���������Ƃ����ʂ�'ABC'�ł���i���p�X�y�[�X�Ŗ��߂Ȃ��j�B
	
4. DATE�i���t�^�j
	���t��������B�������Ƃ���'1998/10/4'�̂悤�� ['']�ł����邱�ƁB
*****************************/


/*****************************
����
1. NOT NULL (NOT NULL����)
	���L���͕s��(�G���[���N����)�B

2. PRIMARY KEY�i��L�[����j
	��̍s�����ł���i�l����΂ɏd�����Ȃ��j��Ɏ�L�[�𓖂Ă邱�ƂŁA����̍s�̃f�[�^���Ăяo����B
*****************************/


/*****************************
�e�[�u���̍폜�ƕύX

1. �e�[�u���̍폜
	DROP TABLE <�e�[�u����>;
	�� ��x�R�}���h��łƓ�x�Ɩ߂�Ȃ��̂Œ���

2. ��̒ǉ�
	ALTER TABLE <�e�[�u����> ADD COLUMN <��̒�`>;
	
3. ��̍폜
	ALTER TABLE <�e�[�u����> DROP COLUMN <��>;
*****************************/


/*****************************
�f�[�^�o�^

-- DML:�f�[�^�o�^
BEGIN TRANSACTION	<= �s�̒ǉ����J�n

INSERT INTO <�e�[�u����> VALUES (<�f�[�^1-1>, <�f�[�^1-2>, ......);
INSERT INTO <�e�[�u����> VALUES (<�f�[�^2-1>, <�f�[�^2-2>, ......);
...

INSERT INTO <�e�[�u����> VALUES (<�f�[�^n-1>, <�f�[�^n-2>, ......);

COMMIT;	<= �s�̒ǉ����m��
******************************/


BEGIN TRANSACTION;

INSERT INTO Shohin VALUES ('0001', 'T�V���c' ,'�ߕ�', 1000, 500, '2009-09-20');
INSERT INTO Shohin VALUES ('0002', '�������p���`', '�����p�i', 500, 320, '2009-09-11');
INSERT INTO Shohin VALUES ('0003', '�J�b�^�[�V���c', '�ߕ�', 4000, 2800, NULL);
INSERT INTO Shohin VALUES ('0004', '�', '�L�b�`���p�i', 3000, 2800, '2009-09-20');
INSERT INTO Shohin VALUES ('0005', '���͓�', '�L�b�`���p�i', 6800, 5000, '2009-01-15');
INSERT INTO Shohin VALUES ('0006', '�t�H�[�N', '�L�b�`���p�i', 500, NULL, '2009-09-20');
INSERT INTO Shohin VALUES ('0007', '���낵����', '�L�b�`���p�i', 880, 790, '2008-04-28');
INSERT INTO Shohin VALUES ('0008', '�{�[���y��', '�����p�i', 100, NULL, '2009-11-11');

COMMIT;


