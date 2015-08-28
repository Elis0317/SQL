/*****************************
論理演算子

NOT演算子 NOT以降に書かれた文章を否定する
*****************************/

SELECT shohin_mei, shohin_bunrui, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka >= 1000;		-- 販売単価が1000以上のデータを抽出

SELECT shohin_mei, shohin_bunrui, hanbai_tanka
  FROM Shohin
 WHERE NOT hanbai_tanka >= 1000;	-- 販売単価が1000未満のデータを抽出
 
 
/*****************************
AND演算子、OR演算子

AND: 両方とも成り立つとき, OR: 少なくとも一方が成り立つとき
ANDとORを両方使った時は、AND優先なので、ORを優先したい場合は()を使うこと
*****************************/

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shohin_bunrui = 'キッチン用品'
   AND hanbai_tanka >= 3000;		-- キッチン用品かつ販売単価が3000以上のもの

SELECT shohin_mei, shiire_tanka
  FROM Shohin
 WHERE shohin_bunrui = 'キッチン用品'
    OR hanbai_tanka >= 3000;		-- キッチン用品または販売単価が3000以上のもの


SELECT shohin_mei, shohin_bunrui, torokubi
  FROM Shohin
 WHERE shohin_bunrui = '事務用品'
   AND torokubi = '2009-09-11'
    OR torokubi = '2009-09-20';		-- [事務用品で登録日が2009-09-11]または[登録日が2009-09-20]

SELECT shohin_mei, shohin_bunrui, torokubi
  FROM Shohin
 WHERE shohin_bunrui = '事務用品'
   AND (   torokubi = '2009-09-11'
        OR torokubi = '2009-09-20');-- [事務用品]で[登録日が2009-09-11または2009-09-20]

/*****************************
NULLを含む場合の真理値

SQLではNULLを比較すると、真でも偽でもない、[不明(UNKNOWN)]という真理値を返す。
なるべく使わないように気をつけること。


例1）AND (Y:真 N:偽 U:不)

P	Q		P&Q
Y	Y		Y
Y	N		N
Y	U		U
N	Y		N
N	N		N
N	U		N
U	Y		U
U	N		N
U	U		U

例2）OR

P	Q		P&Q
Y	Y		Y
Y	N		Y
Y	U		Y
N	Y		Y
N	N		N
N	U		U
U	Y		Y
U	N		U
U	U		U