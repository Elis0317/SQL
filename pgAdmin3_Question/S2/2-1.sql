-- データ出力
SELECT shohin_id, shohin_mei, shiire_tanka
  FROM "Shohin"

/* 基本構造
SELECT 列データ, 列データ, ... 列データ	<= 最後にカンマはいらない
  FROM "テーブル名"
  
  SELECTに*を入力した場合、全ての列データが出力される
*/