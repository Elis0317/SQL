最大値のデータと外部結合

データ作成スクリプト
create table TabA(
Key1  char(1),
Data1 char(1));

create table TabB(
Key1  char(1),
Key2  char(1),
Data2 char(1));

insert into TabA values('1','2');
insert into TabA values('2','2');
insert into TabA values('3','1');
insert into TabB values('1','4','p');
insert into TabB values('1','8','f');
insert into TabB values('3','3','q');

実際の回答
SELECT S1.Key1,S2.Key2,S1.Data1,S2.Data2
from TabA  AS S1
  LEFT JOIN
	(SELECT	Key1,Key2,Data2
	,	max(Key2) over(partition by Key1) as max_Key2
		--分析関数を使用してKey2の最大値を取得
	FROM	TabB
	) AS S2
  ON	S2.Key2 = S2.max_Key2
  AND	S1.Key1 = S2.Key1
  	--結合条件はKey1と、TabAのKey2とTabBのKey2の最大値、2種に設定