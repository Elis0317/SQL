/*****************************

�������ʂ̕��ёւ�

ORDER BY��
	�\�����ꂽ�f�[�^�x�[�X�̕��ёւ��ɗp������
	SELECT���̍Ō�ɏ���
	
SELECT <��1>, <��2>, <��3>, ......
  FROM <�e�[�u����>
 ORDER BY <���בւ��̊�ƂȂ��1>, <���בւ��̊�ƂȂ��2>, ......(DESC); <= DESC������ƍ~����

�f�[�^��NULL������ꍇ�A�擪�������͖����ɗ���(�ǂ���ɗ��邩�͓��Ɍ��܂��Ă��Ȃ��j

*****************************/

SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin;
 ORDER BY hanbai_tenka;			-- �̔��P���̈�����(����)�ɕ��בւ�

SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin
 ORDER BY hanbai_tanka DESC;	-- �̔��P���̍�����(�~��)�ɕ��בւ�


SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin
ORDER BY hanbai_tanka, shohin_id;	--�̔��P���̈������ɕ��ׁA�����Ȃ�Ώ��iID�̏����Ƃ���


/*****************************

ORDER BY��ɂ����āA�\�[�g�L�[�� AS ���g���̂͋������(GROUP BY�ł͎g���Ȃ�)
	���s��: FROM => WHERE => GROUP BY => SELECT => ORDER BY

�܂��AORDER BY��ɂ�SELECT�Ɋ܂܂�Ă��Ȃ���A�W��֐����g�����Ƃ��ł���

*****************************/

--�G���[�𐶂��Ȃ�
SELECT shohin_id AS id, shohin_mei, hanbai_tanka AS ht, shiire_tanka
  FROM Shohin
 ORDER BY ht, id;	-- <= shohin_id �� id �ƕύX���ďo�͉\

SELECT shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin
 ORDER BY shohin_id;	-- <= SELECT�ɑ��݂��Ȃ���OK

SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
ORDER BY COUNT(*);	-- <= �W��֐��������Ă����삷��