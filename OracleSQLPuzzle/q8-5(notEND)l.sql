--未完
8-5 移動平均を求める
問題

終値推移テーブル
日付        終値
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

5日移動平均を求める。

出力結果
日付        終値   移動平均
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

データ作成スクリプト
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
SELECT	dat AS 日付, money AS 終値
,	case when count(*) over(order by dat) >= 5
--then avg(money) OVER (ORDER BY dat) else NULL end as 移動平均 --処理未実装
from tbl
order by 日付;