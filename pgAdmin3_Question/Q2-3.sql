--Q2-3 例文
/*
SELECT	 shohin_mei, hanbai_tanka, shiire_tanka
FROM	 "Shohin"
WHERE	 hanbai_tanka - shiire_tanka >= 500
*/

/*　例1
SELECT	 shohin_mei, hanbai_tanka, shiire_tanka
FROM	 "Shohin"
WHERE	 shiire_tanka + 500 <= hanbai_tanka
*/

--例2
SELECT	 shohin_mei, hanbai_tanka, shiire_tanka
FROM	 "Shohin"
WHERE	 shiire_tanka <= hanbai_tanka - 500