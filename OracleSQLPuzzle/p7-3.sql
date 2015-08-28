sum関数とdecode関数

データ作成スクリプト
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

実際の回答
SELECT	item
,	sum(CASE WHEN month = '1' THEN money ELSE 0 END) as "1月"
,	sum(CASE WHEN month = '2' THEN money ELSE 0 END) as "2月"
,	sum(CASE WHEN month = '3' THEN money ELSE 0 END) as "3月"
,	sum(money) as 金額計
FROM sale
GROUP BY item
ORDER BY item;