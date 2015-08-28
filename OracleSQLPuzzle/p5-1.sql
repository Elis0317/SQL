nvl関数の引数に集合関数
(PostgreSQLではCOALESCEを代用)

データ作成スクリプト
create table master
(
	f_num char(2),
	f_name varchar(4)
);

create table trans
(
	ymd date,
	f_num char(2),
	quantity integer
);

insert into master(f_num,f_name) values('a1','元町');
insert into master(f_num,f_name) values('a2','田原');
insert into master(f_num,f_name) values('a3','高岡');
insert into master(f_num,f_name) values('a4','三好');
insert into trans(ymd,f_num,quantity) values('2001/08/01','a1',100);
insert into trans(ymd,f_num,quantity) values('2001/08/01','a3',100);
insert into trans(ymd,f_num,quantity) values('2001/08/02','a1',150);
insert into trans(ymd,f_num,quantity) values('2001/08/02','a3',200);

回答
SELECT	M.f_num
,	M.f_name
,	COALESCE(SUM(T.quantity), 0)
	/*
	COALESCEは左から順に引数を見て、最初のNULLでない値を返す
	今回はSUM()がNULLでなければSUMを、NULLなら0を返す
	*/
FROM	master as M
  LEFT JOIN
	trans AS T
  ON	M.f_num = T.f_num
GROUP BY
	M.f_num
,	f_name
ORDER BY f_num
	