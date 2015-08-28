8-1 同一グループ件数と、最小かを取得
問題

マスタテーブル
分類Code   補助分類Code
--------   ------------
    001            01
    001            02
    001            03
    001            04
    002            01
    002            02
    003            99
    004            05
    005            77

マスタテーブルから、
同一の分類Code、補助分類Codeのレコード数と、
同一の分類Code、補助分類Codeの中で、最小の補助分類Codeなら1そうでなければ0、
を出力する。

出力結果
分類Code   補助分類Code  同一グループ件数  IsMin
--------   ------------  --------------  ------
    001            01                4       1
    001            02                4       0
    001            03                4       0
    001            04                4       0
    002            01                2       1
    002            02                2       0
    003            99                1       1
    004            05                1       1
    005            77                1       1

データ作成スクリプト
CREATE TABLE master(
	Code1 char(3),
	Code2 char(2));

insert into master VALUES ('001', '01');
insert into master VALUES ('001', '02');
insert into master VALUES ('001', '03');
insert into master VALUES ('001', '04');
insert into master VALUES ('002', '01');
insert into master VALUES ('002', '02');
insert into master VALUES ('003', '99');
insert into master VALUES ('004', '05');
insert into master VALUES ('005', '77');

回答
SELECT	Code1 AS 分類Code, Code2 AS 補助分類Code
,	COUNT(*) OVER (PARTITION BY Code1) AS 同一グループ件数
,	CASE WHEN Code2 = MIN(Code2) OVER (PARTITION BY Code1)
	THEN 1 ELSE 0 END AS IsMin
FROM	master