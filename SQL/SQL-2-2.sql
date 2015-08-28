/*****************************
算術演算子

SQL文には、WHERE文に計算式を記入可能。
ただし、NULLを含んだ計算式は全てNULLになるので注意 ※(NULL / 0 = NULL,エラーにならない)
*****************************/

SELECT shohin_mei, hanbai_tanka,
       hanbai_tanka * 2 AS "hanbai_tanka_x2"	-- <=hanbai_tankaを2倍にしたものを hanbai_tanka_2xとして出力
  FROM Shohin;

/*****************************
比較演算子

<, >, = を使ってWHERE文で比較可能。
ただし、文字列の数字は注意 ※例(小さい順に'1', '10', '11', '2', '222', '3')
							   (		  1, 1-0, 1-1, 2, 2-2-2, 3と考えると分かりやすい)

NULLかどうかを判断するのには、 IS NULL, IS NOT NULL 演算子が使われる。
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NULL;		-- NULLの行を選択
 
SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shiire_tanka IS NOT NULL;	-- NULLでない行を選択

