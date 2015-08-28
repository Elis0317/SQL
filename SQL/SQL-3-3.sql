/*****************************

集約した結果に条件を指定

GROUP BY句によって分けられたグループに対して、さらに条件を指定したい
	WHEREはレコード(行)のみにしか条件を指定できない
		HAVING句を使う
		
HAVING句
SELECT <列名1>, <列名2>, <列名3>, ......
  FROM <テーブル名>
 GROUP BY <列名1>, <列名2>, <列名3>, ......
HAVING <グループの値に対する条件>

*****************************/

-- 商品分類によって分けられたときのカウントが、ちょうど2つのグループを表示する
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING COUNT(*) = 2;	


-- 商品分類によって分けられたグループのうち、販売単価の平均が2500以上のグル―プを表示する
SELECT shohin_bunrui, AVG(hanbai_tanka)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) >= 2500;	


/*****************************
HAVING句に書ける要素
	SELECT句と同じ(1) 定数 2) 集約関数 3) GROUP BYで指定した列名(集約キー))

	GROUP BY句に含まれていない列をHAVING句に入れると、エラーが生じる
		SELECT句でもHAVING句でも、一度集約が終わった後のテーブルを想像して、コードを書くとミスが減る

*****************************/

/* エラーコード例
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING shohin_mei = 'ボールペン';	-- <= shohin_meiはGROUP BY句に含まれていない
*/


/*****************************
集約キーに対する条件
	HAVING句よりもWHERE句に書くほうがよい
	
	WHERE句:	行に対する条件
	HAVING句	グループに対する条件
	
	単なる行に対する条件はWHEREを使うほうが混乱は少ない
*****************************/

--条件をHAVING句に
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui
HAVING shohin_bunrui = '衣服';

--条件をWHERE句に
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
WHERE shohin_bunrui = '衣服'
 GROUP BY shohin_bunrui;