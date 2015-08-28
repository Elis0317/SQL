/*****************************
ウィンドウ関数(OLAP関数)
	OLAP: Online Analytical Processing
	データベースを使ってリアルタイムに(=オンラインで）データ分析を行う処理のこと
		例） 市場分析、財務諸表作成、計画作成...

<ウィンドウ関数> OVER ([PARTITION BY <列リスト>]
							ORDER BY <ソート用列リスト>)
	
	ウィンドウ関数として使える関数
		1. 集約関数(SUM, AVG, COUNT, MAX, MIN)
		2. ウィンドウ専用関数(RANK, DENSE_RANK, ROW_NUMBERなど)
	
	ウィンドウ関数はGROUP BY句のカット機能とORDER BY句の順序づけの両方を持っている
		ただし、PARTITION句には、GROUP BY句が持つような集約機能はない
	
	PARTITION BYによって区切られたレコードの集合を｢ウィンドウ」と呼ぶ
		ウィンドウは｢範囲｣を示す
		
	PARTITION BYは必須ではない
		指定しないと、テーブル全体が一つの大きなウィンドウとして扱われる
*****************************/

/*****************************
ウィンドウ専用関数
	ウィンドウ専用関数は引数を取らない => （）内は常に空
	
RANK関数
例) Shohinテーブルに含まれる8つの商品について、商品分類別に販売単価の安い順で並べたランキング表を作る

PARTITION BY
	順位を付けるための範囲

ORDER BY
	どの列を、どんな順序で順位を付けるか
	ASC/DESKを使うことで昇順か降順を決められる（ASCは省略可能）
	
RANK, DENSE_RANK, ROW_NUMBERの違い
	同順位が複数出た時の処理が違う
	RANK:		同順位が複数レコード出た場合、後続の順位は飛ぶ。
			1位が3レコード => 1, 1, 1, 4...
	DENSE_RANK:	同順位が複数レコード存在しても、後続の順位は飛ばない。
			1位が3レコード => 1, 1, 1, 2...
	ROW_NUMBER_:同順位が複数レコード出た場合、DBMSが適当な順序で連番を付与する。
			1位が3レコード => 1, 2, 3, 4...

ウィンドウ関数の使う場所
	基本的にSELECT句のみ
		ウィンドウ関数は、WHERE句やGROUP BY句による処理が終わった｢結果｣に対して作用する
		=> ランキングを出した後にWHERE句やGROUP BY句でレコードが減少・集約されたらランキングは意味をなさない
*****************************/

SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
       RANK () OVER (PARTITION BY shohin_bunrui	--商品分類ごとの順位を出すため
                         ORDER BY hanbai_tanka) AS ranking	--順位付けの基準（ここでは販売単価）
  FROM Shohin;
  
SELECT shohin_mei, shohin_bunrui, hanbai_tanka, 
       RANK () OVER (ORDER BY hanbai_tanka) AS ranking
  FROM Shohin;


SELECT shohin_mei, shohin_bunrui, hanbai_tanka, 
       RANK () OVER (ORDER BY hanbai_tanka) AS ranking,
       DENSE_RANK () OVER (ORDER BY hanbai_tanka) AS dense_ranking,
       ROW_NUMBER () OVER (ORDER BY hanbai_tanka) AS row_num
 FROM Shohin;


/*****************************
集約関数をウィンドウ関数に
	集計対象は自分よりも上のレコードだけ
	自分のレコード(カレントレコード）を基準に集計対象を判断する
	
SUM関数
	累計を示す
	レコード1: データ1の合計, レコード2: データ1+データ2の合計, レコード3: データ1+データ2+データ3の合計...
	
AVG関数
	自分より上のレコードの平均を示す
	レコード1: (データ1)/1, レコード2: (データ1+データ2)/2, レコード3: (データ1+データ2+データ3)/3...
*****************************/

SELECT shohin_id, shohin_mei, hanbai_tanka,
       SUM (hanbai_tanka) OVER (ORDER BY shohin_id) AS current_sum
       -- ORDER BY句で指定した商品ID順にデータを並べ、自分よりも小さい商品IDを持つ商品の販売単価を合計
  FROM Shohin;

SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG (hanbai_tanka) OVER (ORDER BY shohin_id) AS current_avg
  FROM Shohin;


/*****************************
フレーム
	ウィンドウの中でさらに集計範囲を細かく設定
	ORDER BY句の後ろに範囲指定のキーワードを使用
	
移動平均の算出
	｢ここ最近のデータ」の平均を出すときに使う (ここ1週間、ここ3カ月、ここ10年...)
	
ROWS(行), PRECEDING(前の)
	ROWS 2 PRECEIDING: 2行前まで
	=> 自分(カレントレコード), 自分より1行前のレコード, 自分より2行前のレコード の3行、というフレーム指定
	
	FOLLOWING(後の)を使うと、～行後までという指定が可能
		PRECEIDINGとFOLLOWの組み合わせも可能
			ROWS BETWEEN 1 PRECEIDING AND 1 FOLLOWING	(1行前から1行後まで)
*****************************/

SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG (hanbai_tanka) OVER (ORDER BY shohin_id
                                ROWS 2 PRECEDING) AS moving_avg
  FROM Shohin;
  
SELECT shohin_id, shohin_mei, hanbai_tanka,
       AVG (hanbai_tanka) OVER (ORDER BY shohin_id
                                ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
  FROM Shohin;

/*****************************
ORDER BYの仕様
	OVER 内のORDER BYにはウィンドウ関数がどういう順序で計算するかを決める役割しかない
	=> OVER 内のORDER BYで指定した順に結果が並ぶとは限らない

	文末にORDER BYを(合計で2回）使わないと、指定した順番に並ばない可能性がある
*****************************/

SELECT shohin_mei, shohin_bunrui, hanbai_tanka, 
       RANK () OVER (ORDER BY hanbai_tanka) AS ranking
  FROM Shohin
 ORDER BY ranking;