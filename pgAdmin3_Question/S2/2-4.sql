-- データ出力
SELECT	shohin_id	AS "id",
	shohin_mei	AS "namae",
	shiire_tanka	AS "tanka"
  FROM "Shohin"

/* 基本構造
SELECT	列データ AS "変更後の名前",	<= ASの後ろは必ず" "で囲む
	列データ AS "変更後の名前",
	...
	列データ AS "変更後の名前"	<= 最後にカンマはいらない
  FROM "テーブル名"
*/