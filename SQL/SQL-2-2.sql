/*****************************
�Z�p���Z�q

SQL���ɂ́AWHERE���Ɍv�Z�����L���\�B
�������ANULL���܂񂾌v�Z���͑S��NULL�ɂȂ�̂Œ��� ��(NULL / 0 = NULL,�G���[�ɂȂ�Ȃ�)
*****************************/

SELECT shohin_mei, hanbai_tanka,
       hanbai_tanka * 2 AS "hanbai_tanka_x2"	-- <=hanbai_tanka��2�{�ɂ������̂� hanbai_tanka_2x�Ƃ��ďo��
  FROM Shohin;

/*****************************
��r���Z�q

<, >, = ���g����WHERE���Ŕ�r�\�B
�������A������̐����͒��� ����(����������'1', '10', '11', '2', '222', '3')
							   (		  1, 1-0, 1-1, 2, 2-2-2, 3�ƍl����ƕ�����₷��)

NULL���ǂ����𔻒f����̂ɂ́A IS NULL, IS NOT NULL ���Z�q���g����B
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NULL;		-- NULL�̍s��I��
 
SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NOT NULL;	-- NULL�łȂ��s��I��

