/*****************************
�E�B���h�E�֐�(OLAP�֐�)
	OLAP: Online Analytical Processing
	�f�[�^�x�[�X���g���ă��A���^�C����(=�I�����C���Łj�f�[�^���͂��s�������̂���
		��j �s�ꕪ�́A�������\�쐬�A�v��쐬...

<�E�B���h�E�֐�> OVER ([PARTITION BY <�񃊃X�g>]
							ORDER BY <�\�[�g�p�񃊃X�g>)
	
	�E�B���h�E�֐��Ƃ��Ďg����֐�
		1. �W��֐�(SUM, AVG, COUNT, MAX, MIN)
		2. �E�B���h�E��p�֐�(RANK, DENSE_RANK, ROW_NUMBER�Ȃ�)
	
	�E�B���h�E�֐���GROUP BY��̃J�b�g�@�\��ORDER BY��̏����Â��̗����������Ă���
		�������APARTITION��ɂ́AGROUP BY�傪���悤�ȏW��@�\�͂Ȃ�
	
	PARTITION BY�ɂ���ċ�؂�ꂽ���R�[�h�̏W����E�B���h�E�v�ƌĂ�
		�E�B���h�E�͢�͈ͣ������
		
	PARTITION BY�͕K�{�ł͂Ȃ�
		�w�肵�Ȃ��ƁA�e�[�u���S�̂���̑傫�ȃE�B���h�E�Ƃ��Ĉ�����
*****************************/

/*****************************
�E�B���h�E��p�֐�
	�E�B���h�E��p�֐��͈��������Ȃ� => �i�j���͏�ɋ�
	
RANK�֐�
��) Shohin�e�[�u���Ɋ܂܂��8�̏��i�ɂ��āA���i���ޕʂɔ̔��P���̈������ŕ��ׂ������L���O�\�����

PARTITION BY
	���ʂ�t���邽�߂͈̔�

ORDER BY
	�ǂ̗���A�ǂ�ȏ����ŏ��ʂ�t���邩
	ASC/DESK���g�����Ƃŏ������~�������߂���iASC�͏ȗ��\�j
	
RANK, DENSE_RANK, ROW_NUMBER�̈Ⴂ
	�����ʂ������o�����̏������Ⴄ
	RANK:		�����ʂ��������R�[�h�o���ꍇ�A�㑱�̏��ʂ͔�ԁB
			1�ʂ�3���R�[�h => 1, 1, 1, 4...
	DENSE_RANK:	�����ʂ��������R�[�h���݂��Ă��A�㑱�̏��ʂ͔�΂Ȃ��B
			1�ʂ�3���R�[�h => 1, 1, 1, 2...
	ROW_NUMBER_:�����ʂ��������R�[�h�o���ꍇ�ADBMS���K���ȏ����ŘA�Ԃ�t�^����B
			1�ʂ�3���R�[�h => 1, 2, 3, 4...

�E�B���h�E�֐��̎g���ꏊ
	��{�I��SELECT��̂�
		�E�B���h�E�֐��́AWHERE���GROUP BY��ɂ�鏈�����I���������ʣ�ɑ΂��č�p����
		=> �����L���O���o�������WHERE���GROUP BY��Ń��R�[�h�������E�W�񂳂ꂽ�烉���L���O�͈Ӗ����Ȃ��Ȃ�
*****************************/

SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
       RANK () OVER (PARTITION BY shohin_bunrui	--���i���ނ��Ƃ̏��ʂ��o������
                         ORDER BY hanbai_tanka) AS ranking	--���ʕt���̊�i�����ł͔̔��P���j
  FROM Shohin;
  
SELECT shohin_mei, shohin_bunrui, hanbai_tanka, 
       RANK () OVER (ORDER BY hanbai_tanka) AS ranking
  FROM Shohin;


SELECT shohin_mei, shohin_bunrui, hanbai_tanka, 
       RANK () OVER (ORDER BY hanbai_tanka) AS ranking,
       DENSE_RANK () OVER (ORDER BY hanbai_tanka) AS dense_ranking,
       ROW_NUMBER () OVER (ORDER BY hanbai_tanka) AS row_num
 FROM Shohin;


/*****************************
�W��֐����E�B���h�E�֐���
	�W�v�Ώۂ͎���������̃��R�[�h����
	�����̃��R�[�h(�J�����g���R�[�h�j����ɏW�v�Ώۂ𔻒f����
	
SUM�֐�
	�݌v������
	���R�[�h1: �f�[�^1�̍��v, ���R�[�h2: �f�[�^1+�f�[�^2�̍��v, ���R�[�h3: �f�[�^1+�f�[�^2+�f�[�^3�̍��v...
	
AVG�֐�
	��������̃��R�[�h�̕��ς�����
	���R�[�h1: (�f�[�^1)/1, ���R�[�h2: (�f�[�^1+�f�[�^2)/2, ���R�[�h3: (�f�[�^1+�f�[�^2+�f�[�^3)/3...
*****************************/

SELECT shohin_id, shohin_mei, hanbai_tanka,
       SUM (hanbai_tanka) OVER (ORDER BY shohin_id) AS current_sum
       -- ORDER BY��Ŏw�肵�����iID���Ƀf�[�^����ׁA�����������������iID�������i�̔̔��P�������v
  FROM Shohin;

SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG (hanbai_tanka) OVER (ORDER BY shohin_id) AS current_avg
  FROM Shohin;


/*****************************
�t���[��
	�E�B���h�E�̒��ł���ɏW�v�͈͂��ׂ����ݒ�
	ORDER BY��̌��ɔ͈͎w��̃L�[���[�h���g�p
	
�ړ����ς̎Z�o
	������ŋ߂̃f�[�^�v�̕��ς��o���Ƃ��Ɏg�� (����1�T�ԁA����3�J���A����10�N...)
	
ROWS(�s), PRECEDING(�O��)
	ROWS 2 PRECEIDING: 2�s�O�܂�
	=> ����(�J�����g���R�[�h), �������1�s�O�̃��R�[�h, �������2�s�O�̃��R�[�h ��3�s�A�Ƃ����t���[���w��
	
	FOLLOWING(���)���g���ƁA�`�s��܂łƂ����w�肪�\
		PRECEIDING��FOLLOW�̑g�ݍ��킹���\
			ROWS BETWEEN 1 PRECEIDING AND 1 FOLLOWING	(1�s�O����1�s��܂�)
*****************************/

SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG (hanbai_tanka) OVER (ORDER BY shohin_id
                                ROWS 2 PRECEDING) AS moving_avg
  FROM Shohin;
  
SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG (hanbai_tanka) OVER (ORDER BY shohin_id
                                ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
  FROM Shohin;

/*****************************
ORDER BY�̎d�l
	OVER ����ORDER BY�ɂ̓E�B���h�E�֐����ǂ����������Ōv�Z���邩�����߂���������Ȃ�
	=> OVER ����ORDER BY�Ŏw�肵�����Ɍ��ʂ����ԂƂ͌���Ȃ�

	������ORDER BY��(���v��2��j�g��Ȃ��ƁA�w�肵�����Ԃɕ��΂Ȃ��\��������
*****************************/

SELECT shohin_mei, shohin_bunrui, hanbai_tanka, 
       RANK () OVER (ORDER BY hanbai_tanka) AS ranking
  FROM Shohin
 ORDER BY ranking;