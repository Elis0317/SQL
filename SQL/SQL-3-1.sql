/*****************************
�e�[�u���̏W��ƌ���
*****************************/


/*****************************
�W��֐�
1. COUNT
	�e�[�u���̃��R�[�h��(�s���𐔂���)
2. SUM
	�e�[�u���̐��l��̃f�[�^�����v����
3. AVG
	�e�[�u���̐��l��̃f�[�^�𕽋ς���
4. MAX
	�e�[�u���̔C�ӂ̗�̃f�[�^�̍ő�l�����߂�
5. MIN
	�e�[�u���̔C�ӂ̗�̃f�[�^�̍ŏ��l�����߂�
*****************************/

--�e�[�u���̍s���𐔂���
SELECT COUNT(*)	--����: �S��(*)
  FROM Shohin;
  
SELECT COUNT(shiire_tanka)	-- NULL���������f�[�^�̓J�E���g����Ȃ�
  FROM Shohin;				--	�߂�l = ���R�[�h�� - NULL�̐�

--���v�����߂�
SELECT SUM(hanbai_tanka)
  FROM Shohin;

SELECT SUM(hanbai_tanka), SUM(shiire_tanka)	--�����v�Z�������A���2�s�ɂ���̂��������\
  FROM Shohin;								--NULL�̃f�[�^�͖������Čv�Z����

--���ϒl�����߂�
SELECT AVG(hanbai_tanka), AVG(shiire_tanka)	--NULL�̃f�[�^�͖������Čv�Z����(NULL = 0�Ƃ��Čv�Z���Ȃ��j
  FROM Shohin;
  
--�ő�l�E�ŏ��l�����߂�
SELECT MAX(hanbai_tanka), MIN(shiire_tanka)
  FROM Shohin;
  

--�d���l�������ďW��֐����g��(�l�̎�ނ����߂�)
	--DISTINCT(�d���s���Ȃ��Č��ʂ𓾂�j��(COUNT�⑼�̊֐��Ɂj�g����I

-- �� (count == 3)
SELECT COUNT(DISTINCT shohin_bunrui)	-- ���i���ނ̏d���l�����O���A���ꂩ�炻�̌��ʂ̍s���𐔂���
  FROM Shohin;
  
-- �~ (count == 8)
SELECT DISTINCT COUNT(shohin_bunrui)	-- �ŏ��ɏ��i���ނ̍s���𐔂��A���ꂩ�炻�̌��ʂ̏d���l�����O
  FROM Shohin;