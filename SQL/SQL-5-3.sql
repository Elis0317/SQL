/*****************************
���փT�u�N�G��
	�e�[�u���̈ꕔ�̃��R�[�h�W���Ɍ��肵����r���s���ꍇ�ɗp����
*****************************/

/*
��: �u���i���ނ��Ɓv�ɕ��ϔ̔��P�����r����
�L�b�`���p�i: [���i��, �̔��P��] = [('�', 3000), ('���͓�', 6800), ('�t�H�[�N', 500), ('���낵����', 880)]
	�̂Ƃ��A���ω��z�� 2795�~
	
	�O���[�v���̕��ω��z��荂�����i�́A��ƈ��͓�
	������A�L�b�`���p�i�A�ߕ��A�����p�i�S�Ĉ�C�ɏo�͂�����
*/

-- ���i���ޕʂɕ��ω��z�����߂�
SELECT AVG(hanbai_tanka)
  FROM Shohin
 GROUP BY shohin_bunrui;

/* ���̂܂܎��s���Ă��G���[
SELECT shohin_id, shohinmei, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)		
                         FROM Shohin
                        GROUP BY shohin_bunrui);
                        
AVG(hanbai_tanka)...�̓L�b�`���p�i�A�ߕ��A�����p�i3�̕��ϒl��Ԃ��Ă��܂�(2795, 2500, 300)����
*/

SELECT shohin_bunrui, shohin_mei, hanbai_tanka
  FROM Shohin AS S1
 WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                         FROM Shohin AS S2
                        WHERE S1.shohin_bunrui = S2.shohin_bunrui	--���փT�u�N�G��
                        GROUP BY shohin_bunrui);

/*****************************
WHERE S1.shohin_bunrui = S2.shohin_bunrui
	�e���i�̔̔��P���ƕ��ϒP���̔�r���A�u�������i���ނ̒��Łv�s��

��r�Ώۂ������e�[�u�����������߁A��ʂ��邽�߂�S1, S2�ƕt����
	���փT�u�N�G���ł́A�e�[�u���̕ʖ���񖼂̑O�� <�e�[�u����>.<��>�̌`���ŋL�q����K�v������

	���������͕K���T�u�N�G���̒��ɏ�������
SELECT shohin_bunrui, shohin_mei, hanbai_tanka
  FROM Shohin AS S1
 WHERE S1.shohin_bunrui = S2.shohin_bunrui			=> �X�R�[�v�O�Ȃ̂ŃG���[�𐶂���
   AND hanbai_tanka > (SELECT AVG(hanbai_tanka)		)
                         FROM Shohin AS S2			) S2�̃X�R�[�v�͂��̃T�u�N�G����
                        GROUP BY shohin_bunrui);	)