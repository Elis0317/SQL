case式による他分岐

データ作成スクリプト
create table ta(
Y integer,
Z integer);

create table tb(
Z integer,
val1 varchar(12));

create table tc as select * from tb;
create table td as select * from tb;

insert into ta(Y,Z) values(1,1);
insert into ta(Y,Z) values(1,2);
insert into ta(Y,Z) values(1,3);
insert into tb(Z,val1) values(1,'tb1');
insert into tb(Z,val1) values(3,'tb3');
insert into tb(Z,val1) values(5,'tb5');

insert into ta(Y,Z) values(2,4);
insert into ta(Y,Z) values(2,5);
insert into ta(Y,Z) values(2,6);
insert into tc(Z,val1) values(3,'tc3');
insert into tc(Z,val1) values(5,'tc5');

insert into ta(Y,Z) values(3,7);
insert into ta(Y,Z) values(3,8);
insert into ta(Y,Z) values(3,9);
insert into td(Z,val1) values(8,'td8');
insert into td(Z,val1) values(9,'td9');
commit;

自分の回答
SELECT	ta.Y
,	ta.Z
,	CASE
  WHEN	ta.Y = 1
	  THEN	tb.val1
  WHEN	ta.Y = 2
	  THEN	tc.val1
  WHEN	ta.Y = 3
	  THEN	td.val1
  END	as val1
FROM	ta
  LEFT JOIN tb
	  ON	tb.Z = ta.Z
  LEFT JOIN tc
	  ON	tc.Z = ta.Z
  LEFT JOIN td
	  ON	td.Z = ta.Z
order by Y,Z;

実際の回答
select Y,Z,
case Y
when 1 then (select b.val1 from tb b where b.Z=a.Z)
when 2 then (select b.val1 from tc b where b.Z=a.Z)
when 3 then (select b.val1 from td b where b.Z=a.Z) end as val1
from ta a
order by Y,Z;