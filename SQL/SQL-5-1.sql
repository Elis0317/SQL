/*****************************
�r���[
	�e�[�u���Ɠ��������A���ۂ̃f�[�^�͕ۑ����Ă��Ȃ�
	�r���[��SELECT����ۑ����Ă���A�r���[����f�[�^�����o�����Ƃ���Ƃ��ɁA
	�r���[�͓����I�ɂ���SELECT�������s���A�ꎞ�I�ɉ��z�̃e�[�u�������

�r���[�̃����b�g
	1) �f�[�^��ۑ����Ȃ����߁A�L�����u�̗e�ʂ�ߖ�ł���
	2)�p�ɂɎg��SELECT���������������񏑂��Ȃ��Ă��A�r���[�Ƃ��ĕۑ����邱�ƂŎg���񂵂�����
		��x�r���[������Ă����΁A�Ăяo�������ŊȒP��SELECT���̌��ʂ�������
		
		�r���[���܂ރf�[�^�́A���̃f�[�^�ƘA�����Ď����I�ɍŐV�̏�ԂɍX�V�����
			��r���[���Q�Ƃ���v = �u����SELECT�������s����v

CREATE VIEW �r���[�� (<�r���[�̗�1>, <�r���[�̗�2>, ......)
AS
<SELECT��>
*****************************/

-- ShohinSun�r���[
-- ���i���ނ��Ƃɏ��i�����W�v��������(cnt_shohin)��ۑ�
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)	-- <= �r���[�̗�
AS
SELECT shohin_bunrui, COUNT(*)	-- )
  FROM Shohin					-- ) �r���[��`�̖{��(���g�͂�����SELECT���j
 GROUP BY shohin_bunrui;		-- )

-- �r���[���g��
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;	-- <=�e�[�u���̑���Ƀr���[���w�肷��


/*****************************
�r���[�̐�������
	1) �r���[��`�� ORDER BY�͎g���Ȃ�
		�e�[�u�����l�A�r���[�ɂ��Ăࢍs�ɂ͏������Ȃ�����߁B
		
	2) �r���[�ɑ΂���X�V
		�r���[�ɑ΂��āAINSERT, DELETE, UPDATE�Ȃǂ͊�{�I�Ɏg�p�s��
		
		��̗�(�G���[)
		 INSERT INTO ShohinSum VALUES ('�d�����i', 5);
		 
		 ���̏ꍇ�AShohinSum�r���[�ł͐���ȏ����i���i���ނ��d�����i�A���i����5�j���s����B
		 �������AShohinSum��e�[�u�������݂��INSERT���́A
		 	�u�e�[�u����shohin_bunrui��5���R�[�h�ǉ����邱�Ɓv����������Ȃ��B
		 	�i�܂�A���iID��̔��P���ȂǁA���i���ވȊO�͕s���̍s���A5�s�ł��邱�ƂɂȂ�j
		 	

�r���[�̍폜
	DROP VIEW�����g���B
DROP VIEW �r���[�� (<�r���[�̗�1>, <�r���[�̗�2>, ......)
*****************************/

DROP VIEW ShohinSum;
