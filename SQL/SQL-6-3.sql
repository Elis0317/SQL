/*****************************
CASE式
	条件分岐（場合分け）を記述するときに使う
	CASE式は式が書ける場所ならどこにでも記述可能
	
CASE WHEN <評価式> THEN <式>
	 WHEN <評価式> THEN <式>
	 WHEN <評価式> THEN <式>
	 ...
	 ELSE <式>
END
*****************************/

--CASE式で商品分類にA-Cの文字列の割り当て
SELECT shohin_mei,
       CASE WHEN shohin_bunrui = '衣服'         THEN 'A：' || shohin_bunrui	-- <= || は文字列の結合
            WHEN shohin_bunrui = '事務用品'     THEN 'B：' || shohin_bunrui
            WHEN shohin_bunrui = 'キッチン用品' THEN 'C：' || shohin_bunrui
            ELSE NULL
       END AS abc_shohin_bunrui
  FROM Shohin;

-- 商品分類ごとに販売単価を合計した結果を行列変換する
SELECT SUM(CASE WHEN shohin_bunrui = '衣服'         THEN hanbai_tanka ELSE 0 END) AS sum_tanka_ihuku,
       SUM(CASE WHEN shohin_bunrui = 'キッチン用品' THEN hanbai_tanka ELSE 0 END) AS sum_tanka_kitchen,
       SUM(CASE WHEN shohin_bunrui = '事務用品'     THEN hanbai_tanka ELSE 0 END) AS sum_tanka_jimu
  FROM Shohin;
  -- 商品分類が衣服など特定の値と合致した場合、その商品の販売単価を出力
  -- 存在しない場合は0を返す