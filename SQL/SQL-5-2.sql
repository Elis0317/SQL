/*****************************
サブクエリ

	ビュー:		データを取り出すSELECT文だけを保存する方法
	サブクエリ	ビュー定義のSELECT文をそのままFROM句に持ち込んだもの
	
*****************************/

-- 商品分類ごとに商品数を集計するビュー
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
  FROM Shohin
 GROUP BY shohin_bunrui;

-- ビューが作成されていることの確認
SELECT shohin_bunrui, cnt_shohin
  FROM ShohinSum;


-- 商品分類ごとに商品数を集計するサブクエリ
SELECT shohin_bunrui, cnt_shohin
  FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
          FROM Shohin			-- FROM句に直接ビュー定義のSELECT文を書く
         GROUP BY shohin_bunrui) AS ShohinSum;	--AS ShohinSum と名付けた

/*****************************
サブクエリの基本
	SELECT ...		) 2. 外側のクエリ(SELECT文）が実行
	  FROM (
	  	SELECT ...	)
	  	  FROM ...	) 1. 内側のクエリ(サブクエリ）から実行
	  	 GROUP ...	)
	) AS ...

サブクエリの階層数の増加
	FROM句にさらにサブクエリを使うことで、入れ子を深くすることが可能。
	読みづらくなるのであまり入れすぎないように

サブクエリの名前
	名前を付ける必要があり、処理内容から考えた適切な名前を付ける必要がある。
	ASは省略可能。
*****************************/

/*****************************
スカラ・サブクエリ
	サブクエリ:			構造的にはテーブルと同じなので、基本的に複数行を結果として返す。
	スカラ・サブクエリ	「必ず1行1列だけの戻り値を返す」という制限を付けたサブクエリ
		戻り値が単一なので、サブクエリの戻り値を比較演算子(<, >, =, など)の入力として用いることができる。
*****************************/

-- 例: ｢販売単価が、全体の平均の販売単価より高い商品だけを検索する」

/* エラー
SELECT shohin_id, shohinmei, hanbai_tanka
  FROM Shohim
 WHERE hanbai_tanka > AVG(hanbai_tanka)		-- WHERE文に集約関数は書けない
*/

-- （前段階）販売単価の平均を求める
SELECT AVG(hanbai_tanka)
  FROM Shohin;

--WHERE文にこの結果をそのままクエリの右辺に代入する
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin
 WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)	-- 平均の販売単価を求めるスカラ・サブクエリ
                         FROM Shohin);			-- この分では、スカラ・サブクエリは平均値の2097.5に置き換わる


/*****************************
スカラ・サブクエリの規則
	スカラ・サブクエリを書ける場所は、定数や列名を書けることのできる場所すべて
		SELECT, GROUP BY, HAVING, ORDER BYなど、ほとんどあらゆる場所に書ける
	
	複数行を返さないことを確認して使う（複数行の時点でスカラ・サブクエリではない）
*****************************/