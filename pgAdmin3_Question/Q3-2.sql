--Q3-1
/* 間違い文
SELECT	 shohin_id, SUM(shohin_mei)
FROM	 "Shohin"
GROUP BY shohin_bunrui
WHERE	 torokubi > '2009-09-01'

1. SELECT句に、GROUP BY句で指定しない列(shohin_id)を記述している
2. SUM()の引数に文字列(shohin_mei)をしている
	SUMの引数に指定できるのは数値型のみ
3. GROUP BY句がWHERE句より前にある
*/

--Q3-2
SELECT	 shohin_bunrui, SUM(hanbai_tanka), SUM(shiire_tanka)
FROM	 "Shohin"
GROUP BY shohin_bunrui	--グループ化
HAVING	 SUM(hanbai_tanka) >= SUM(shiire_tanka) * 1.5	--販売単価の合計が、仕入れ単価の合計の1.5倍を上回るものをソート

--Q3-3
/*torokubiが日付の降順。よって、
ORDER BY torokubi DESC;


