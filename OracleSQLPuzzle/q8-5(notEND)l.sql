--����
8-5 �ړ����ς����߂�
���

�I�l���ڃe�[�u��
���t        �I�l
----------  -----
2006/03/08     10
2006/03/09     30
2006/03/10     50
2006/03/11     70
2006/03/14     70
2006/03/15     80
2006/03/16     90
2006/03/17    100
2006/03/18    110
2006/03/22    100
2006/03/23     90

5���ړ����ς����߂�B

�o�͌���
���t        �I�l   �ړ�����
----------  ----  --------
2006/03/08    10      null
2006/03/09    30      null
2006/03/10    50      null
2006/03/11    70      null
2006/03/14    70        46
2006/03/15    80        60
2006/03/16    90        72
2006/03/17   100        82
2006/03/18   110        90
2006/03/22   100        96
2006/03/23    90        98

�f�[�^�쐬�X�N���v�g
CREATE TABLE tbl(
	dat DATE
,	money INTEGER);

INSERT INTO tbl VALUES('2006-03-08', 10);
INSERT INTO tbl VALUES('2006-03-09', 30);
INSERT INTO tbl VALUES('2006-03-10', 50);
INSERT INTO tbl VALUES('2006-03-11', 70);
INSERT INTO tbl VALUES('2006-03-14', 70);
INSERT INTO tbl VALUES('2006-03-15', 80);
INSERT INTO tbl VALUES('2006-03-16', 90);
INSERT INTO tbl VALUES('2006-03-17', 100);
INSERT INTO tbl VALUES('2006-03-18', 110);
INSERT INTO tbl VALUES('2006-03-22', 100);
INSERT INTO tbl VALUES('2006-03-23', 90);
SELECT	dat AS ���t, money AS �I�l
,	case when count(*) over(order by dat) >= 5
--then avg(money) OVER (ORDER BY dat) else NULL end as �ړ����� --����������
from tbl
order by ���t;