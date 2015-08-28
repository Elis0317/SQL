/******************************

SELECT文: テーブルからデータを取り出す時に使う
	SELECT	<列名>
	FROM	<テーブル名>
	
******************************/

SELECT shohin_id, shohin_mei, shiire_tanka
  FROM Shohin;
  
  
SELECT *	-- *を使うと、「すべての」（ここではすべての列）の意味になる。
  FROM Shohin;
  
  
SELECT shohin_id    AS id,		-- <元の列の名前> AS <新しい列の名前> により、コンソールに表示される結果が変わる
       shohin_mei   AS namae,	-- AS の後ろが日本語でも構わない
       shiire_tanka AS tanka
  FROM Shohin;
  
  
SELECT DISTINCT shohin_bunrui	-- SELECTの直後にDISTINCTを置くことで、重複を省いた結果が出力される
  FROM Shohin;					-- NULLもまとまりはするが、消えずに残る
  
  
SELECT DISTINCT shohin_bunrui, torokubi	-- DISTINCT A, B の場合、A, B療法\\両方に重複している組み合わせのみが消える
  FROM Shohin;
  
  
/*****************************
WHERE句による行の選択
	SELECT	<列名>
	FROM	<テーブル名>
	WHERE	<条件式>;
	
	この句の順番を守ること。
*****************************/

SELECT shohin_mei, shohin_bunrui
  FROM Shohin
 WHERE shohin_bunrui = '衣服'; -- <= shohin_bunrui == '衣服’の行の中から shohin_mei, shohin_bunrin を出力
 
 