他レコードに対する存在チェック

データ作成スクリプト
create table t1(
ID   integer,
Kind char(1) check (Kind in('A','B')),
Disc char(4),
primary key (ID,Kind));

insert into t1(ID,Kind,Disc) values(1,'A','aaaa');
insert into t1(ID,Kind,Disc) values(1,'B','bbbb');
insert into t1(ID,Kind,Disc) values(2,'A','xxxx');
insert into t1(ID,Kind,Disc) values(3,'A','yyyy');
insert into t1(ID,Kind,Disc) values(3,'B','zzzz');
insert into t1(ID,Kind,Disc) values(4,'B','ssss');

実際の回答
SELECT	ID
,	Kind
,	Disc
FROM	t1 AS S1
where	Kind = 'B'
  OR	(
	Kind = 'A'
	AND not exists
		(
		SELECT	*
		FROM	t1 AS S2
		WHERE	S2.ID = S1.ID
		AND	S2.Kind = 'B'
		)
	)