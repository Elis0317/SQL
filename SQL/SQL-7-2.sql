/*****************************
����
	�ʂ̃e�[�u�������������Ă��āA��𑝂₷����
		�W�����Z: �s�𑝂₷���
		
	�ǂ���̃e�[�u���ɂ����݂����(A)�����n���ɂ��āA�Е��̃e�[�u���ɂ������݂��Ȃ���(B)���m���ꏏ�̌��ʂɊ܂߂�
*****************************/

/* INNER JOIN(��������)
��: Shohin�e�[�u�����珤�i���Ɣ̔��P���̗�������Ă��āATenpoShohin�e�[�u���ɂ�������
	Shohin�e�[�u���̗�f�[�^:		[���iID, ���i��, ���i����, �̔��P��, �d����P��, �o�^��]
	TenpoShohin�e�[�u���̗�f�[�^:	[���iID, �X��ID, �X�ܖ�, ����]

	(A): ���iID		(B): ���iID�ȊO�̗�
*/

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM TenpoShohin AS TS INNER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id;

/*****************************
���������̎g����
	1. FROM���2�̃e�[�u��������
		�e�[�u�����������Ɠǂ݂Â炢�̂ŁA��ʓI�ɂ�AS�ŕʖ�������
	
	2. ON��Ō����������w�肷��
		2�̃e�[�u�������ѕt�����(�����L�[)���w�肷��
			����������p��WHERE�̂悤�Ȃ���
			��{�I�� = �ŃL�[�����ѕt����
			
		FROM��WHERE�̊Ԃɏ�������
		
	3. SELECT��̏�����
		<�e�[�u�����̕ʖ�>, <��>�Ƃ����L�q�ɂ���āA�ǂ̃e�[�u���̂ǂ̗�������Ă��Ă��邩��������

����������WHERE�̑g�ݍ��킹
	�������Z�ɂ��e�[�u��������������́AWHERE, GROUP BY, ORDER BY�Ȃǂ��g�����Ƃ��ł���
	SELECT�������s����Ă���Ԏ����������Ȃ��̂ŁA��Ɏc�������Ȃ�r���[���쐬����

*****************************/

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM TenpoShohin AS TS INNER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id
 WHERE TS.tenpo_id = '000A';


/*****************************
OUTER JOIN(�O������)
	�ǂ��炩����̃e�[�u���ɑ��݂��Ă���Ȃ�΁A���̃e�[�u���̏�񂪌����邱�ƂȂ��o�͂����
	�e�[�u�����番����Ȃ�����NULL�Ƃ��Č��ʂɕ\���
		�����������ł́A����̃e�[�u���ɂ������݂��Ă��Ȃ��e�[�u���͌��ʂɏo�Ȃ�
	
		���̃e�[�u���ɂȂ��i�܂�e�[�u���̊O������j�������ʂɎ����Ă���
	
�}�X�^�e�[�u���̎w��
	FROM�����LEFT, RIGHT���g�����ƂŃ}�X�^�e�[�u�����w�肷��
		�w�肳�ꂽ�}�X�^�e�[�u���̏�񂪑S�ĕ\�������
	LEFT, RIGHT�ɋ@�\�I�ȍ��͂Ȃ�
*****************************/

SELECT TS.tenpo_id, TS.tenpo_mei, S.shohin_id, S.shohin_mei, S.hanbai_tanka
  FROM Shohin AS S LEFT OUTER JOIN TenpoShohin AS TS
    ON TS.shohin_id = S.shohin_id;


/*****************************
3�ȏ�̃e�[�u�����g�����ꍇ
	3�ȏ�̃e�[�u���𓯎��Ɍ������邱�Ƃ��\
	FROM���INNER JOIN���d�˂Ă����΂���
*****************************/

-- DDL�F�e�[�u���쐬
CREATE TABLE ZaikoShohin
( souko_id		CHAR(4)      NOT NULL,
  shohin_id     CHAR(4)      NOT NULL,
  zaiko_suryo	INTEGER      NOT NULL,
  PRIMARY KEY (souko_id, shohin_id));

-- DML�F�f�[�^�o�^

INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0001',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0002',	120);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0003',	200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0004',	3);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0005',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0006',	99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0007',	999);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0008',	200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0001',	10);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0002',	25);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0003',	34);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0004',	19);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0005',	99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0006',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0007',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0008',	18);

COMMIT;

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka, ZS.zaiko_suryo
  FROM TenpoShohin AS TS INNER JOIN Shohin AS S
    ON TS.shohin_id = S.shohin_id
               INNER JOIN ZaikoShohin AS ZS
                   ON TS.shohin_id = ZS.shohin_id
                   -- TS.-��S.-�������Ō��΂�Ă���̂ŁAS.-��ZS.-�̓����͂���Ȃ�
                   		--�iS��ZS���������Ă����ʂ͓����j
WHERE ZS.souko_id = 'S001';