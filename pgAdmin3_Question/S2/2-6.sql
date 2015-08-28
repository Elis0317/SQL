-- 定数の入力
SELECT	'商品'		AS "mojiretsu", --レコードに'商品'が出力されるmojiretsuレコードを、出力結果に追加する
	38		AS "kazu",
	'2009-02-24'	AS "hizuke",
	shohin_id,
	shohin_mei

  FROM "Shohin"

/* 基本構造
SELECT	定数 AS "変更後の名前",	<= ASの後ろは必ず" "で囲む
	列データ AS "変更後の名前",
	...
	列データ AS "変更後の名前"	<= 最後にカンマはいらない
  FROM "テーブル名"
*/