累計を取得

データ作成スクリプト
create Table sell(
ym   	integer,
money	integer);

insert into sell values(200010, 1500);
insert into sell values(200011, 1000);
insert into sell values(200012, 2000);
insert into sell values(200101, 2500);
insert into sell values(200102, 3000);
insert into sell values(200103,-2000);
insert into sell values(200104, 3000);

実際の回答
SELECT	ym AS 年月,
	money AS 金額,
	SUM(money) OVER (ORDER BY ym) AS 累計
FROM	sell
ORDER BY 年月;