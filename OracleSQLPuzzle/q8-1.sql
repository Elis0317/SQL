8-1 ����O���[�v�����ƁA�ŏ������擾
���

�}�X�^�e�[�u��
����Code   �⏕����Code
--------   ------------
    001            01
    001            02
    001            03
    001            04
    002            01
    002            02
    003            99
    004            05
    005            77

�}�X�^�e�[�u������A
����̕���Code�A�⏕����Code�̃��R�[�h���ƁA
����̕���Code�A�⏕����Code�̒��ŁA�ŏ��̕⏕����Code�Ȃ�1�����łȂ����0�A
���o�͂���B

�o�͌���
����Code   �⏕����Code  ����O���[�v����  IsMin
--------   ------------  --------------  ------
    001            01                4       1
    001            02                4       0
    001            03                4       0
    001            04                4       0
    002            01                2       1
    002            02                2       0
    003            99                1       1
    004            05                1       1
    005            77                1       1

�f�[�^�쐬�X�N���v�g
CREATE TABLE master(
	Code1 char(3),
	Code2 char(2));

insert into master VALUES ('001', '01');
insert into master VALUES ('001', '02');
insert into master VALUES ('001', '03');
insert into master VALUES ('001', '04');
insert into master VALUES ('002', '01');
insert into master VALUES ('002', '02');
insert into master VALUES ('003', '99');
insert into master VALUES ('004', '05');
insert into master VALUES ('005', '77');

��
SELECT	Code1 AS ����Code, Code2 AS �⏕����Code
,	COUNT(*) OVER (PARTITION BY Code1) AS ����O���[�v����
,	CASE WHEN Code2 = MIN(Code2) OVER (PARTITION BY Code1)
	THEN 1 ELSE 0 END AS IsMin
FROM	master