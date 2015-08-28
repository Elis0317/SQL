/*****************************
GROUPING���Z�q
	���v�E���v����x�ɋ��߂�
	1. ROLLUP, 2. CUBE, 3. GROUPING SETS

1. ROLLUP
	�W��L�[�̑g�ݍ��킹���قȂ錋�ʂ���x�Ɍv�Z����
	GROUP BY��̏W��L�[���X�g�ɑ΂��āAROLLUP (<��1>, <��2>, ...)�̂悤�Ɏg�p
	
	ROLLUP�́A
	1. GROUP BY ()				-- �W��L�[�Ȃ�(GROUP BY�傪�Ȃ��ꍇ�Ɠ��� = �S�̂̍��v�s�̃��R�[�h�𐶐�)
		���W���s�ƌĂ΂�� <= GROUP BY��ō���Ȃ����v�̍s�̂���
		
	2. GROUP BY (shohin_bunrui)	-- �W��L�[ = shohin_bunrui
*****************************/

SELECT shohin_bunrui, SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui);
 	-- ���ʂ́A���i���ނ̈�ԏ�̃��R�[�h��shohin_bunrui = NULL(�L�[�l�s��), sum_tanka = (���v)���\�������

-- �W��L�[�ɏ��i���ށA�o�^����ǉ������P�[�X
SELECT shohin_bunrui, torokubi, SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui, torokubi);
 
	/*���ʂ͏��v(�L�b�`���p�i�A�����p�i�A�ߕ�)��3��A����3�̍��v�̌v4���R�[�h�i���W���s�j���ǉ������
	�܂�A���L3�p�^�[���̏W�񃌃x���̈قȂ�p�^�[����UNION�łȂ�������
		1. GROUP BY(), 2. GROUP BY (shohin_bunrui), 3. GROUP BY (shohin_bunrui, torokubi)
			1.�ł͏��i���ށA�o�^����NULL, 2.�ł͓o�^����NULL


/*****************************
GROUPING�֐�
	���W���s��NULL�Ƃ���ȊO��NULL����������
		���W���s��NULL����������ꂽ��A���ꂾ����ʂ̕�����ɏ��������\
		
	�����Ɏ������̒l�����W���s�̂��߂ɔ�������NULL�Ȃ�1, ����ȊO�Ȃ�0��Ԃ�
		=>�߂�l��1�̎��͍��v�E���v�Ƃ�������������w�肷��Ƃ�蕪����₷��
	
GROUPING(<��f�[�^>) AS <��f�[�^>
*****************************/

--NULL�̔���
SELECT GROUPING(shohin_bunrui) AS shohin_bunrui, 
            GROUPING(torokubi) AS torokubi, SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui, torokubi);

--���W���s��NULL��u��
SELECT CASE WHEN GROUPING(shohin_bunrui) = 1	--GROUPING�̒l��1��0�ŏ�����ύX
            THEN '���i���� ���v' 
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 		--GROUPING�̒l��1��0�ŏ�����ύX
            THEN '�o�^�� ���v' 
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
            	--�߂�l�͓��t�^�ƕ�����^������Ԃ��\�������邽�߁A�^�ϊ�����
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui, torokubi);


/*****************************
CUBE
	GROUP BY��ɗ^����ꂽ�W��L�[�̢���ׂẲ\�ȑg�ݍ��킹�v����̌��ʂɂ܂Ƃ߂�
	�L�[��2�Ȃ�2^2 = 4, 3�Ȃ�2^3 = 8
	
	��̏W��L�[�����W���Ɍ����āA�f�[�^��ςݏグ��C���[�W
*****************************/

SELECT CASE WHEN GROUPING(shohin_bunrui) = 1 
            THEN '���i���� ���v'
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 
            THEN '�o�^�� ���v'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY CUBE(shohin_bunrui, torokubi);
	-- CUBE�̏W��L�[:	1. GROUP BY(), 2. GROUP BY (shohin_bunrui),
	--			 		3. GROUP BY (torokubi), 4.GROUP BY (shohin_bunrui, torokubi)
	
	-- ROLLUP�̏W��L�[:1. GROUP BY(), 2. GROUP BY (shohin_bunrui), 3. GROUP BY (shohin_bunrui, torokubi)

/*****************************
GROUPING SETS
	�~�����ςݖ؂����擾
	ROLLUP, CUBE�ŋ��߂����ʂ́A�ꕔ�̃��R�[�h�������߂�΂����ꍇ�ɗp����
	���`�̂ɁA�g���@��͂��������Ȃ�
*****************************/

-- ���i���ނƓo�^���A���ꂼ���P�ƂŏW��L�[�Ƃ����ꍇ�Ɍ��肷��
	-- <=> ���v���R�[�h�ƏW��L�[�Ƃ���2�̃L�[���g�������R�[�h�͕s�v

SELECT CASE WHEN GROUPING(shohin_bunrui) = 1 
            THEN '���i���� ���v'
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 
            THEN '�o�^�� ���v'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY GROUPING SETS (shohin_bunrui, torokubi);