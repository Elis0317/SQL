/*****************************
�T�u�N�G��

	�r���[:		�f�[�^�����o��SELECT��������ۑ�������@
	�T�u�N�G��	�r���[��`��SELECT�������̂܂�FROM��Ɏ������񂾂���
	
*****************************/

-- ���i���ނ��Ƃɏ��i�����W�v����r���[
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui;

-- �r���[���쐬����Ă��邱�Ƃ̊m�F
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;


-- ���i���ނ��Ƃɏ��i�����W�v����T�u�N�G��
SELECT shohin_bunrui, cnt_shohin
  FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
          FROM Shohin			-- FROM��ɒ��ڃr���[��`��SELECT��������
         GROUP BY shohin_bunrui) AS ShohinSum;	--AS ShohinSum �Ɩ��t����

/*****************************
�T�u�N�G���̊�{
	SELECT ...		) 2. �O���̃N�G��(SELECT���j�����s
	  FROM (
	  	SELECT ...	)
	  	  FROM ...	) 1. �����̃N�G��(�T�u�N�G���j������s
	  	 GROUP ...	)
	) AS ...

�T�u�N�G���̊K�w���̑���
	FROM��ɂ���ɃT�u�N�G�����g�����ƂŁA����q��[�����邱�Ƃ��\�B
	�ǂ݂Â炭�Ȃ�̂ł��܂���ꂷ���Ȃ��悤��

�T�u�N�G���̖��O
	���O��t����K�v������A�������e����l�����K�؂Ȗ��O��t����K�v������B
	AS�͏ȗ��\�B
*****************************/

/*****************************
�X�J���E�T�u�N�G��
	�T�u�N�G��:			�\���I�ɂ̓e�[�u���Ɠ����Ȃ̂ŁA��{�I�ɕ����s�����ʂƂ��ĕԂ��B
	�X�J���E�T�u�N�G��	�u�K��1�s1�񂾂��̖߂�l��Ԃ��v�Ƃ���������t�����T�u�N�G��
		�߂�l���P��Ȃ̂ŁA�T�u�N�G���̖߂�l���r���Z�q(<, >, =, �Ȃ�)�̓��͂Ƃ��ėp���邱�Ƃ��ł���B
*****************************/

-- ��: ��̔��P�����A�S�̂̕��ς̔̔��P����荂�����i��������������v

/* �G���[
SELECT shohin_id, shohinmei, hanbai_tanka
  FROM Shohim
 WHERE hanbai_tanka > AVG(hanbai_tanka)		-- WHERE���ɏW��֐��͏����Ȃ�
*/

-- �i�O�i�K�j�̔��P���̕��ς����߂�
SELECT AVG(hanbai_tanka)
  FROM Shohin;

--WHERE���ɂ��̌��ʂ����̂܂܃N�G���̉E�ӂɑ������
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)	-- ���ς̔̔��P�������߂�X�J���E�T�u�N�G��
                         FROM Shohin);			-- ���̕��ł́A�X�J���E�T�u�N�G���͕��ϒl��2097.5�ɒu�������


/*****************************
�X�J���E�T�u�N�G���̋K��
	�X�J���E�T�u�N�G����������ꏊ�́A�萔��񖼂������邱�Ƃ̂ł���ꏊ���ׂ�
		SELECT, GROUP BY, HAVING, ORDER BY�ȂǁA�قƂ�ǂ�����ꏊ�ɏ�����
	
	�����s��Ԃ��Ȃ����Ƃ��m�F���Ďg���i�����s�̎��_�ŃX�J���E�T�u�N�G���ł͂Ȃ��j
*****************************/