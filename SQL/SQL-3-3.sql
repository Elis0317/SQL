/*****************************

�W�񂵂����ʂɏ������w��

GROUP BY��ɂ���ĕ�����ꂽ�O���[�v�ɑ΂��āA����ɏ������w�肵����
	WHERE�̓��R�[�h(�s)�݂̂ɂ����������w��ł��Ȃ�
		HAVING����g��
		
HAVING��
SELECT <��1>, <��2>, <��3>, ......
  FROM <�e�[�u����>
 GROUP BY <��1>, <��2>, <��3>, ......
HAVING <�O���[�v�̒l�ɑ΂������>

*****************************/

-- ���i���ނɂ���ĕ�����ꂽ�Ƃ��̃J�E���g���A���傤��2�̃O���[�v��\������
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING COUNT(*) = 2;	


-- ���i���ނɂ���ĕ�����ꂽ�O���[�v�̂����A�̔��P���̕��ς�2500�ȏ�̃O���\�v��\������
SELECT shohin_bunrui, AVG(hanbai_tanka)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) >= 2500;	


/*****************************
HAVING��ɏ�����v�f
	SELECT��Ɠ���(1) �萔 2) �W��֐� 3) GROUP BY�Ŏw�肵����(�W��L�[))

	GROUP BY��Ɋ܂܂�Ă��Ȃ����HAVING��ɓ����ƁA�G���[��������
		SELECT��ł�HAVING��ł��A��x�W�񂪏I�������̃e�[�u����z�����āA�R�[�h�������ƃ~�X������

*****************************/

/* �G���[�R�[�h��
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING shohin_mei = '�{�[���y��';	-- <= shohin_mei��GROUP BY��Ɋ܂܂�Ă��Ȃ�
*/


/*****************************
�W��L�[�ɑ΂������
	HAVING�����WHERE��ɏ����ق����悢
	
	WHERE��:	�s�ɑ΂������
	HAVING��	�O���[�v�ɑ΂������
	
	�P�Ȃ�s�ɑ΂��������WHERE���g���ق��������͏��Ȃ�
*****************************/

--������HAVING���
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING shohin_bunrui = '�ߕ�';

--������WHERE���
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
WHERE shohin_bunrui = '�ߕ�'
 GROUP BY shohin_bunrui;