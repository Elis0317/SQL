sum�֐���decode�֐�

�f�[�^�쐬�X�N���v�g
create Table sale(
month   char(1),
item char(1),
money integer
);

insert into sale values('1','A',1000);
insert into sale values('1','B',2000);
insert into sale values('1','C',1700);
insert into sale values('2','A',1200);
insert into sale values('2','C',1800);
insert into sale values('3','A',2500);
insert into sale values('3','B',3000);

���ۂ̉�
SELECT	item
,	sum(CASE WHEN month = '1' THEN money ELSE 0 END) as "1��"
,	sum(CASE WHEN month = '2' THEN money ELSE 0 END) as "2��"
,	sum(CASE WHEN month = '3' THEN money ELSE 0 END) as "3��"
,	sum(money) as ���z�v
FROM sale
GROUP BY item
ORDER BY item;