/*****************************
�_�����Z�q

NOT���Z�q NOT�ȍ~�ɏ����ꂽ���͂�ے肷��
*****************************/

SELECT shohin_mei, shohin_bunrui, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka >= 1000;		-- �̔��P����1000�ȏ�̃f�[�^�𒊏o

SELECT shohin_mei, shohin_bunrui, hanbai_tanka
  FROM Shohin
 WHERE NOT hanbai_tanka >= 1000;	-- �̔��P����1000�����̃f�[�^�𒊏o
 
 
/*****************************
AND���Z�q�AOR���Z�q

AND: �����Ƃ����藧�Ƃ�, OR: ���Ȃ��Ƃ���������藧�Ƃ�
AND��OR�𗼕��g�������́AAND�D��Ȃ̂ŁAOR��D�悵�����ꍇ��()���g������
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shohin_bunrui = '�L�b�`���p�i'
   AND hanbai_tanka >= 3000;		-- �L�b�`���p�i���̔��P����3000�ȏ�̂���

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shohin_bunrui = '�L�b�`���p�i'
    OR hanbai_tanka >= 3000;		-- �L�b�`���p�i�܂��͔̔��P����3000�ȏ�̂���


SELECT shohin_mei, shohin_bunrui, torokubi
  FROM Shohin
 WHERE shohin_bunrui = '�����p�i'
   AND torokubi = '2009-09-11'
    OR torokubi = '2009-09-20';		-- [�����p�i�œo�^����2009-09-11]�܂���[�o�^����2009-09-20]

SELECT shohin_mei, shohin_bunrui, torokubi
  FROM Shohin
 WHERE shohin_bunrui = '�����p�i'
   AND (   torokubi = '2009-09-11'
        OR torokubi = '2009-09-20');-- [�����p�i]��[�o�^����2009-09-11�܂���2009-09-20]

/*****************************
NULL���܂ޏꍇ�̐^���l

SQL�ł�NULL���r����ƁA�^�ł��U�ł��Ȃ��A[�s��(UNKNOWN)]�Ƃ����^���l��Ԃ��B
�Ȃ�ׂ��g��Ȃ��悤�ɋC�����邱�ƁB


��1�jAND (Y:�^ N:�U U:�s)

P	Q		P&Q
Y	Y		Y
Y	N		N
Y	U		U
N	Y		N
N	N		N
N	U		N
U	Y		U
U	N		N
U	U		U

��2�jOR

P	Q		P&Q
Y	Y		Y
Y	N		Y
Y	U		Y
N	Y		Y
N	N		N
N	U		U
U	Y		Y
U	N		U
U	U		U