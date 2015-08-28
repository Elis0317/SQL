合計が2位以内のデータを取得

データ作成スクリプト
create table tbl(
key1  char(1),
key2  char(2),
money integer);

insert into money values('A','A1', 10);
insert into money values('A','A1', 20);
insert into money values('A','A1', 30);
insert into money values('A','A2',120);
insert into money values('B','B1', 50);
insert into money values('B','B1', 60);
insert into money values('B','B1', 70);
insert into money values('B','B2', 10);
insert into money values('B','B2', 30);
insert into money values('B','B3', 70);
insert into money values('C','C1', 20);
insert into money values('C','C2', 20);
insert into money values('C','C3', 20);
insert into money values('C','C4', 10);
insert into money values('C','C5',  0);

実際の回答
SELECT	key1
,	key2
,	money
FROM
(
	SELECT	key1
	,	key2
	,	sum(money) as money
	,	dense_rank() over(partition by key1 order by sum(money) desc) as Rank
	FROM tbl
	GROUP BY
		key1,key2
)	AS list
WHERE	Rank <= 2
ORDER BY
	key1
,	Rank
,	key2;