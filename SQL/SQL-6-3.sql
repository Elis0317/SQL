/*****************************
CASE��
	��������i�ꍇ�����j���L�q����Ƃ��Ɏg��
	CASE���͎���������ꏊ�Ȃ�ǂ��ɂł��L�q�\
	
CASE WHEN <�]����> THEN <��>
	 WHEN <�]����> THEN <��>
	 WHEN <�]����> THEN <��>
	 ...
	 ELSE <��>
END
*****************************/

--CASE���ŏ��i���ނ�A-C�̕�����̊��蓖��
SELECT shohin_mei,
       CASE WHEN shohin_bunrui = '�ߕ�'         THEN 'A�F' || shohin_bunrui	-- <= || �͕�����̌���
            WHEN shohin_bunrui = '�����p�i'     THEN 'B�F' || shohin_bunrui
            WHEN shohin_bunrui = '�L�b�`���p�i' THEN 'C�F' || shohin_bunrui
            ELSE NULL
       END AS abc_shohin_bunrui
  FROM Shohin;

-- ���i���ނ��Ƃɔ̔��P�������v�������ʂ��s��ϊ�����
SELECT SUM(CASE WHEN shohin_bunrui = '�ߕ�'         THEN hanbai_tanka ELSE 0 END) AS sum_tanka_ihuku,
       SUM(CASE WHEN shohin_bunrui = '�L�b�`���p�i' THEN hanbai_tanka ELSE 0 END) AS sum_tanka_kitchen,
       SUM(CASE WHEN shohin_bunrui = '�����p�i'     THEN hanbai_tanka ELSE 0 END) AS sum_tanka_jimu
  FROM Shohin;
  -- ���i���ނ��ߕ��ȂǓ���̒l�ƍ��v�����ꍇ�A���̏��i�̔̔��P�����o��
  -- ���݂��Ȃ��ꍇ��0��Ԃ�