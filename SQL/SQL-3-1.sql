/*****************************
テーブルの集約と検索
*****************************/


/*****************************
集約関数
1. COUNT
	テーブルのレコード数(行数を数える)
2. SUM
	テーブルの数値列のデータを合計する
3. AVG
	テーブルの数値列のデータを平均する
4. MAX
	テーブルの任意の列のデータの最大値を求める
5. MIN
	テーブルの任意の列のデータの最小値を求める
*****************************/

--テーブルの行数を数える
SELECT COUNT(*)	--引数: 全て(*)
  FROM Shohin;
  
SELECT COUNT(shiire_tanka)	-- NULLが入ったデータはカウントされない
  FROM Shohin;				--	戻り値 = レコード数 - NULLの数

--合計を求める
SELECT SUM(hanbai_tanka)
  FROM Shohin;

SELECT SUM(hanbai_tanka), SUM(shiire_tanka)	--複数計算式を入れ、列を2行にするのももちろん可能
  FROM Shohin;								--NULLのデータは無視して計算する

--平均値を求める
SELECT AVG(hanbai_tanka), AVG(shiire_tanka)	--NULLのデータは無視して計算する(NULL = 0として計算しない）
  FROM Shohin;
  
--最大値・最小値を求める
SELECT MAX(hanbai_tanka), MIN(shiire_tanka)
  FROM Shohin;
  

--重複値を除いて集約関数を使う(値の種類を求める)
	--DISTINCT(重複行を省いて結果を得る）が(COUNTや他の関数に）使える！

-- ○ (count == 3)
SELECT COUNT(DISTINCT shohin_bunrui)	-- 商品分類の重複値を除外し、それからその結果の行数を数える
  FROM Shohin;
  
-- × (count == 8)
SELECT DISTINCT COUNT(shohin_bunrui)	-- 最初に商品分類の行数を数え、それからその結果の重複値を除外
  FROM Shohin;