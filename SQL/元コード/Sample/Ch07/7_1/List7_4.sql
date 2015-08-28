SELECT shohin_id, shohin_mei
  FROM Shohin
 WHERE shohin_bunrui = 'キッチン用品'
UNION
SELECT shohin_id, shohin_mei
  FROM Shohin2
 WHERE shohin_bunrui = 'キッチン用品'
ORDER BY shohin_id;



/* 注意事項①
-- 列数が不一致のためエラー
SELECT shohin_id, shohin_mei
  FROM Shohin
UNION
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin2;
*/

/* 注意事項②
-- データ型が不一致のためエラー
SELECT shohin_id, hanbai_tanka
  FROM Shohin
UNION
SELECT shohin_id, torokubi
  FROM Shohin2;
*/