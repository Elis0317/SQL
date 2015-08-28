文字の検索

データ作成スクリプト
create table str(
key	char(4) PRIMARY KEY,
list	varchar(20)
);

insert into str values('A001', '01, 03, 06, 09');
insert into str values('A002', '01');
insert into str values('A003', null);
insert into str values('A004', '01, 02, 03, 05, 10');
insert into str values('A005', '03,08,10');

回答 (LIKE述語を使う)
SELECT	key
,	list
,	CASE
  WHEN	list LIKE '%01%'
	  THEN	'TRUE' ELSE	'FALSE'
  END	AS "Q1"
,	CASE
  WHEN	list LIKE '%01%' AND list LIKE '%03%'
	  THEN	'TRUE' ELSE	'FALSE'
  END	AS "Q2"
,	CASE
  WHEN	list LIKE '%01%' OR list LIKE '%08%'
	  THEN	'TRUE' ELSE	'FALSE'
  END	AS "Q3"
FROM	str