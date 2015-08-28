/*****************************
GROUPING演算子
	小計・合計を一度に求める
	1. ROLLUP, 2. CUBE, 3. GROUPING SETS

1. ROLLUP
	集約キーの組み合わせが異なる結果を一度に計算する
	GROUP BY句の集約キーリストに対して、ROLLUP (<列1>, <列2>, ...)のように使用
	
	ROLLUPは、
	1. GROUP BY ()				-- 集約キーなし(GROUP BY句がない場合と同じ = 全体の合計行のレコードを生成)
		超集合行と呼ばれる <= GROUP BY句で作られない合計の行のこと
		
	2. GROUP BY (shohin_bunrui)	-- 集約キー = shohin_bunrui
*****************************/

SELECT shohin_bunrui, SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui);
 	-- 結果は、商品分類の一番上のレコードにshohin_bunrui = NULL(キー値不明), sum_tanka = (合計)が表示される

-- 集約キーに商品分類、登録日を追加したケース
SELECT shohin_bunrui, torokubi, SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui, torokubi);
 
	/*結果は小計(キッチン用品、事務用品、衣服)の3種、その3つの合計の計4レコード（超集合行）が追加される
	つまり、下記3パターンの集約レベルの異なるパターンをUNIONでつないだもの
		1. GROUP BY(), 2. GROUP BY (shohin_bunrui), 3. GROUP BY (shohin_bunrui, torokubi)
			1.では商品分類、登録日がNULL, 2.では登録日がNULL


/*****************************
GROUPING関数
	超集合行のNULLとそれ以外のNULLを見分ける
		超集合行のNULLが見分けられたら、それだけを別の文字列に書き換え可能
		
	引数に取った列の値が超集合行のために発生したNULLなら1, それ以外なら0を返す
		=>戻り値が1の時は合計・小計といった文字列を指定するとより分かりやすい
	
GROUPING(<列データ>) AS <列データ>
*****************************/

--NULLの判別
SELECT GROUPING(shohin_bunrui) AS shohin_bunrui, 
            GROUPING(torokubi) AS torokubi, SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui, torokubi);

--超集合行のNULLを置換
SELECT CASE WHEN GROUPING(shohin_bunrui) = 1	--GROUPINGの値が1か0で処理を変更
            THEN '商品分類 合計' 
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 		--GROUPINGの値が1か0で処理を変更
            THEN '登録日 合計' 
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
            	--戻り値は日付型と文字列型両方を返す可能性があるため、型変換処理
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui, torokubi);


/*****************************
CUBE
	GROUP BY句に与えられた集約キーの｢すべての可能な組み合わせ」を一つの結果にまとめる
	キーが2つなら2^2 = 4, 3つなら2^3 = 8
	
	一つの集約キーを座標軸に見立て、データを積み上げるイメージ
*****************************/

SELECT CASE WHEN GROUPING(shohin_bunrui) = 1 
            THEN '商品分類 合計'
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 
            THEN '登録日 合計'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY CUBE(shohin_bunrui, torokubi);
	-- CUBEの集約キー:	1. GROUP BY(), 2. GROUP BY (shohin_bunrui),
	--			 		3. GROUP BY (torokubi), 4.GROUP BY (shohin_bunrui, torokubi)
	
	-- ROLLUPの集約キー:1. GROUP BY(), 2. GROUP BY (shohin_bunrui), 3. GROUP BY (shohin_bunrui, torokubi)

/*****************************
GROUPING SETS
	欲しい積み木だけ取得
	ROLLUP, CUBEで求めた結果の、一部のレコードだけ求めればいい場合に用いる
	非定形故に、使う機会はそう多くない
*****************************/

-- 商品分類と登録日、それぞれを単独で集約キーとした場合に限定する
	-- <=> 合計レコードと集約キーとして2つのキーを使ったレコードは不要

SELECT CASE WHEN GROUPING(shohin_bunrui) = 1 
            THEN '商品分類 合計'
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 
            THEN '登録日 合計'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY GROUPING SETS (shohin_bunrui, torokubi);