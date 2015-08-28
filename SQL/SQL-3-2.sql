/*****************************

テーブルからグループへの切り分け
	今までテーブル全体を一つのグループとしてみなしていたが、GROUP BYによって複数のグループに切り分けられる

SELECT <列名1>,<列名2>,<列名3>, ......
  FROM <テーブル名>
 GROUP BY <列名1>,<列名2>,<列名3>, ......; <=GROUP BYに指定する列のことは集約キー、グループ化列と呼ばれる
 
 NULLも一つのグループに分類される（NULL同士も集まる)
 
*****************************/

SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui;	-- <= 商品IDから、商品分類を基準とした表に変化
 
 
/*****************************

WHEREとGROUP BYの併用
	書き順: SELECT => FROM => WHERE => GROUP BY
	実行順: FROM => WHERE => GROUP BY => SELECT
		見た目の並び順と実行順が違うので注意

*****************************/

SELECT shiire_tanka, COUNT(*)	-- 4. shiire_tanka列を表示、COUNT計算
  FROM Shohin					-- 1. Shohinテーブルを呼び出す
 WHERE shohin_bunrui = '衣服'	-- 2. 商品分類が衣服のものを絞り込む
 GROUP BY shiire_tanka;			-- 3. 仕入れ単価でグループ化
 
 --	Shohinテーブルを呼び出す => 商品分類が衣服のものを絞り込む => 
 --	仕入れ単価でグループ化 => shiire_tanka列を表示、COUNT計算


/*****************************
集約関数とGROUP BY句に関する、よくある間違い


1. SELECT句に余計な列を書く
	集約関数を使うとき、SELECT句に書くことができるのは、
		1) 定数 2) 集約関数 3) GROUP BYで指定した列名(集約キー)
		
	集約キーと他のデータは、必ずしも1対1対応になるとは限らないため
	（集約キーに多―して複数の値が存在する列をSELECT句に含めるのは論理的に不可能)


2. GROUP BY句に(ASを使った)列の別名を書く
	SELECT句に含めた項目には、ASを使うことで表示用の別名をつけることができた
	 => GROUP BY句はSELECTより先に起動するので、GROUP BY句はこの時点でSELECT句でつけた別名を知らない


3. GROUP BY句を使って結果を選択した時、表示される結果は規則がある?
	SELECTによって表示される結果は全くのランダム
		=>並び順をソートする場合、SELECT文で指定する必要がある


4. WHERE句に集約関数を書く
	WHERE句には条件を指定できるが、集約関数を書くことはできない
	<= 集約関数を書けるのはSELECT句、HAVING句、(ORDER BY句)のみ
*****************************/

/* 1のエラー例
SELECT shohin_mei, shiire_tanka, COUNT(*)	-- shohin_meiはGROUP BYに書かれていない
  FROM Shohin
 GROUP BY shiire_tanka;
 */

/* 2のエラー例
SELECT shohin_bunrui AS sb, COUNT(*)	--3. ここで付けられたAS sbを
  FROM Shohin							--1.
 GROUP BY sb;							--2. GROUPはまだ知らない
 */

/* 4のエラー例
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 WHERE COUNT(*) = 2				--count = 2の行だけ表示したいと言っても、この書き方は不可
 GROUP BY shohin_bunrui;
 */