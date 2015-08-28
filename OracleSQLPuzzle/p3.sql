3-1 select句で外部結合
問題

Table1         Table2        Table3
FK1  Val1      FK1  FK3      FK3  Val3
---  ----      ---  ---      ---  ----
111  aaaa      222  555      555  dddd
222  bbbb      333  666      888  eeee
333  cccc      444  777      999  ffff

Table1のVal1、
Table1のFK1(Table2の外部キー)に紐づく
Table2のFK3(Table3の外部キー)に紐づくTable3のVal3
を取得する。(取得できなければnullとする)

出力結果
FK1  Val1  Val3
---  ----  ----
111  aaaa  null
222  bbbb  dddd
333  cccc  null

SELECT	CASE WHEN EXISTS(
		SELECT * FROM table2 AS B WHERE A.Col1 = B.Col1
		THEN (SELECT Col1 FROM table2 AS B WHERE A.Col1 = B.Col1) ELSE Col1
	END AS Col1
,	CASE WHEN EXISTS(
		SELECT * FROM table2 AS B WHERE A.Col2 = B.Col2
		THEN (SELECT Col2 FROM table2 AS B WHERE A.Col2 = B.Col2) ELSE Col2
	END AS Col2
,	CASE WHEN EXISTS(
		SELECT * FROM table2 AS B WHERE A.Col3 = B.Col3
		THEN (SELECT Col3 FROM table2 AS B WHERE A.Col3 = B.Col3) ELSE Col3
	END AS Col3
FROM	Table1 AS A
ORDER BY Col1

3-3 nullでないデータの中で最小のデータを取得
問題

Table1のVal1がnullでないデータの中でVal2が最小のデータの、Val3を取得する。
ただし、Table1のVal1が全てnullの場合は、Val2が最小のデータの、Val3を取得する。

------------------------
パターン1
Val1  Val2  Val3
----  ----  ----
1111  3333  5555
2222  4444  6666
null  1111  7777

出力結果
Val3
----
5555

------------------------
パターン2
Val1  Val2  Val3
----  ----  ----
null  3333  5555
null  4444  6666
null  1111  7777

出力結果
Val3
----
7777

回答
SELECT	Val3
FROM	(SELECT	Val3,
	Row_Number() over(order by (CASE WHEN Val1 IS NULL THEN 0 ELSE 1 END),Val2) as rn
        from Table1)
 where rn = 1;

