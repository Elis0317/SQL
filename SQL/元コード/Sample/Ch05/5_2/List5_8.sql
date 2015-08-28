-- 商品分類ごとに商品数を集計するビュー
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui;

-- ビューが作成されていることの確認
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;



/* ShohinSumを削除する場合
DROP VIEW ShohinSum;
*/