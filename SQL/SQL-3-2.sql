/*****************************

�e�[�u������O���[�v�ւ̐؂蕪��
	���܂Ńe�[�u���S�̂���̃O���[�v�Ƃ��Ă݂Ȃ��Ă������AGROUP BY�ɂ���ĕ����̃O���[�v�ɐ؂蕪������

SELECT <��1>,<��2>,<��3>, ......
  FROM <�e�[�u����>
 GROUP BY <��1>,<��2>,<��3>, ......; <=GROUP BY�Ɏw�肷���̂��Ƃ͏W��L�[�A�O���[�v����ƌĂ΂��
 
 NULL����̃O���[�v�ɕ��ނ����iNULL���m���W�܂�)
 
*****************************/

SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui;	-- <= ���iID����A���i���ނ���Ƃ����\�ɕω�
 
 
/*****************************

WHERE��GROUP BY�̕��p
	������: SELECT => FROM => WHERE => GROUP BY
	���s��: FROM => WHERE => GROUP BY => SELECT
		�����ڂ̕��я��Ǝ��s�����Ⴄ�̂Œ���

*****************************/

SELECT shiire_tanka, COUNT(*)	-- 4. shiire_tanka���\���ACOUNT�v�Z
  FROM Shohin					-- 1. Shohin�e�[�u�����Ăяo��
 WHERE shohin_bunrui = '�ߕ�'	-- 2. ���i���ނ��ߕ��̂��̂��i�荞��
 GROUP BY shiire_tanka;			-- 3. �d����P���ŃO���[�v��
 
 --	Shohin�e�[�u�����Ăяo�� => ���i���ނ��ߕ��̂��̂��i�荞�� => 
 --	�d����P���ŃO���[�v�� => shiire_tanka���\���ACOUNT�v�Z


/*****************************
�W��֐���GROUP BY��Ɋւ���A�悭����ԈႢ


1. SELECT��ɗ]�v�ȗ������
	�W��֐����g���Ƃ��ASELECT��ɏ������Ƃ��ł���̂́A
		1) �萔 2) �W��֐� 3) GROUP BY�Ŏw�肵����(�W��L�[)
		
	�W��L�[�Ƒ��̃f�[�^�́A�K������1��1�Ή��ɂȂ�Ƃ͌���Ȃ�����
	�i�W��L�[�ɑ��\���ĕ����̒l�����݂�����SELECT��Ɋ܂߂�̂͘_���I�ɕs�\)


2. GROUP BY���(AS���g����)��̕ʖ�������
	SELECT��Ɋ܂߂����ڂɂ́AAS���g�����Ƃŕ\���p�̕ʖ������邱�Ƃ��ł���
	 => GROUP BY���SELECT����ɋN������̂ŁAGROUP BY��͂��̎��_��SELECT��ł����ʖ���m��Ȃ�


3. GROUP BY����g���Č��ʂ�I���������A�\������錋�ʂ͋K��������?
	SELECT�ɂ���ĕ\������錋�ʂ͑S���̃����_��
		=>���я����\�[�g����ꍇ�ASELECT���Ŏw�肷��K�v������


4. WHERE��ɏW��֐�������
	WHERE��ɂ͏������w��ł��邪�A�W��֐����������Ƃ͂ł��Ȃ�
	<= �W��֐���������̂�SELECT��AHAVING��A(ORDER BY��)�̂�
*****************************/

/* 1�̃G���[��
SELECT shohin_mei, shiire_tanka, COUNT(*)	-- shohin_mei��GROUP BY�ɏ�����Ă��Ȃ�
  FROM Shohin
 GROUP BY shiire_tanka;
 */

/* 2�̃G���[��
SELECT shohin_bunrui AS sb, COUNT(*)	--3. �����ŕt����ꂽAS sb��
  FROM Shohin							--1.
 GROUP BY sb;							--2. GROUP�͂܂��m��Ȃ�
 */

/* 4�̃G���[��
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 WHERE COUNT(*) = 2				--count = 2�̍s�����\���������ƌ����Ă��A���̏������͕s��
 GROUP BY shohin_bunrui;
 */