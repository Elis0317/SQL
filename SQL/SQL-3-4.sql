/*****************************

検索結果の並び替え

ORDER BY句
	表示されたデータベースの並び替えに用いられる
	SELECT文の最後に書く
	
SELECT <列名1>, <列名2>, <列名3>, ......
  FROM <テーブル名>
 ORDER BY <並べ替えの基準となる列1>, <並べ替えの基準となる列2>, ......(DESC); <= DESCを入れると降順に

データにNULLがある場合、先頭もしくは末尾に来る(どちらに来るかは特に決まっていない）

*****************************/

SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin;
 ORDER BY hanbai_tenka;			-- 販売単価の安い順(昇順)に並べ替え

SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin
 ORDER BY hanbai_tanka DESC;	-- 販売単価の高い順(降順)に並べ替え


SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin
ORDER BY hanbai_tanka, shohin_id;	--販売単価の安い順に並べ、同じならば商品IDの昇順とする


/*****************************

ORDER BY句において、ソートキーに AS を使うのは許可される(GROUP BYでは使えない)
	実行順: FROM => WHERE => GROUP BY => SELECT => ORDER BY

また、ORDER BY句にはSELECTに含まれていない列、集約関数も使うことができる

*****************************/

--エラーを生じない
SELECT shohin_id AS id, shohin_mei, hanbai_tanka AS ht, shiire_tanka
  FROM Shohin
 ORDER BY ht, id;	-- <= shohin_id を id と変更して出力可能

SELECT shohin_mei, hanbai_tanka, shiire_tanka
  FROM Shohin
 ORDER BY shohin_id;	-- <= SELECTに存在しないがOK

SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
ORDER BY COUNT(*);	-- <= 集約関数を書いても動作する