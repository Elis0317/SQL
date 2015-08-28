/*****************************
相関サブクエリ
	テーブルの一部のレコード集合に限定した比較を行う場合に用いる
*****************************/

/*
例: 「商品分類ごと」に平均販売単価を比較する
キッチン用品: [商品名, 販売単価] = [('包丁', 3000), ('圧力鍋', 6800), ('フォーク', 500), ('おろしがね', 880)]
	のとき、平均価額は 2795円
	
	グループ内の平均価額より高い商品は、包丁と圧力鍋
	これを、キッチン用品、衣服、事務用品全て一気に出力したい
*/

-- 商品分類別に平均価額を求める
SELECT AVG(hanbai_tanka)
  FROM Shohin
 GROUP BY shohin_bunrui;

/* そのまま実行してもエラー
SELECT shohin_id, shohinmei, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)		
                         FROM Shohin
                        GROUP BY shohin_bunrui);
                        
AVG(hanbai_tanka)...はキッチン用品、衣服、事務用品3つの平均値を返してしまう(2795, 2500, 300)ため
*/

SELECT shohin_bunrui, shohin_mei, hanbai_tanka
  FROM Shohin AS S1
 WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                         FROM Shohin AS S2
                        WHERE S1.shohin_bunrui = S2.shohin_bunrui	--相関サブクエリ
                        GROUP BY shohin_bunrui);

/*****************************
WHERE S1.shohin_bunrui = S2.shohin_bunrui
	各商品の販売単価と平均単価の比較を、「同じ商品分類の中で」行う

比較対象が同じテーブルだったため、区別するためにS1, S2と付けた
	相関サブクエリでは、テーブルの別名を列名の前に <テーブル名>.<列名>の形式で記述する必要がある

	結合条件は必ずサブクエリの中に書くこと
SELECT shohin_bunrui, shohin_mei, hanbai_tanka
  FROM Shohin AS S1
 WHERE S1.shohin_bunrui = S2.shohin_bunrui			=> スコープ外なのでエラーを生じる
   AND hanbai_tanka > (SELECT AVG(hanbai_tanka)		)
                         FROM Shohin AS S2			) S2のスコープはこのサブクエリ内
                        GROUP BY shohin_bunrui);	)