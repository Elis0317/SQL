3-1 select��ŊO������
���

Table1         Table2        Table3
FK1  Val1      FK1  FK3      FK3  Val3
---  ----      ---  ---      ---  ----
111  aaaa      222  555      555  dddd
222  bbbb      333  666      888  eeee
333  cccc      444  777      999  ffff

Table1��Val1�A
Table1��FK1(Table2�̊O���L�[)�ɕR�Â�
Table2��FK3(Table3�̊O���L�[)�ɕR�Â�Table3��Val3
���擾����B(�擾�ł��Ȃ����null�Ƃ���)

�o�͌���
FK1  Val1  Val3
---  ----  ----
111  aaaa  null
222  bbbb  dddd
333  cccc  null

SELECT	CASE WHEN EXISTS(
		SELECT * FROM table2 AS B WHERE A.Col1 = B.Col1
		THEN (SELECT Col1 FROM table2 AS B WHERE A.Col1 = B.Col1) ELSE Col1
	END AS Col1
,	CASE WHEN EXISTS(
		SELECT * FROM table2 AS B WHERE A.Col2 = B.Col2
		THEN (SELECT Col2 FROM table2 AS B WHERE A.Col2 = B.Col2) ELSE Col2
	END AS Col2
,	CASE WHEN EXISTS(
		SELECT * FROM table2 AS B WHERE A.Col3 = B.Col3
		THEN (SELECT Col3 FROM table2 AS B WHERE A.Col3 = B.Col3) ELSE Col3
	END AS Col3
FROM	Table1 AS A
ORDER BY Col1

3-3 null�łȂ��f�[�^�̒��ōŏ��̃f�[�^���擾
���

Table1��Val1��null�łȂ��f�[�^�̒���Val2���ŏ��̃f�[�^�́AVal3���擾����B
�������ATable1��Val1���S��null�̏ꍇ�́AVal2���ŏ��̃f�[�^�́AVal3���擾����B

------------------------
�p�^�[��1
Val1  Val2  Val3
----  ----  ----
1111  3333  5555
2222  4444  6666
null  1111  7777

�o�͌���
Val3
----
5555

------------------------
�p�^�[��2
Val1  Val2  Val3
----  ----  ----
null  3333  5555
null  4444  6666
null  1111  7777

�o�͌���
Val3
----
7777

��
SELECT	Val3
FROM	(SELECT	Val3,
	Row_Number() over(order by (CASE WHEN Val1 IS NULL THEN 0 ELSE 1 END),Val2) as rn
        from Table1)
 where rn = 1;

