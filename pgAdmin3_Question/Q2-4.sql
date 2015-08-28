--Q2-4
SELECT	 shohin_mei, shohin_bunrui, hanbai_tanka * 0.9 - shiire_tanka AS rieki
FROM	 "Shohin"
WHERE	 (shohin_bunrui = '事務用品' OR shohin_bunrui = 'キッチン用品') --shohin_bunrui を ORで限定
	 AND hanbai_tanka * 0.9 - shiire_tanka >= 100; --ここで riekiは使えない（SELECTよりWHEREのほうが先に実行されるため）