�g�ݍ��킹���擾����

������(ordered pair)-���я����ӎ�
�񏇏���(unordered pair)-�������ӎ����Ȃ�
�����΂́A<1, 2>�̂悤�ɐ�������ʂŁA�񏇏��΂�{1, 2}�̂悤�Ȋ��ʂŕ\�L

�����΂́A�������Ⴆ�Εʕ� <1, 2> �� <2, 1>
�񏇏��΂̏ꍇ�͏����𖳎� {1, 2} = {2, 1}

������-���ς����΂悢
SELECT	P1.p_name AS name_1, P2.p_name AS name_2
FROM	JoinProducts P1, JoinProducts P2;

�����΂�񏇏��΂�
SELECT	P1.p_name AS name_1, P2.p_name AS name_2
FROM	JoinProducts P1, JoinProducts P2
WHERE	P1.p_name > P2.p_name


�u�����Ƒ������ǏZ�����s��v�ȃ��R�[�h�v�����o����
SELECT	DISTINCT A1.a_name, A1.address
FROM	Addresses A1,
	Addresses A2
WHERE	A1.family_id = A2.family_id
AND	A1.address <> A2.address ;


���i����(�l�i���������i�̑g�ݍ��킹)
SELECT	DISTINCT a.p_name, a.price
FROM	Product2 AS a, Product2 AS b
WHERE	a.p_name <> b.p_name
AND	a.price = b.price

�����փT�u�N�G����p����������
--���K���


�����L���O
