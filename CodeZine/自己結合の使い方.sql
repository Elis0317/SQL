組み合わせを取得する

順序対(ordered pair)-並び順を意識
非順序対(unordered pair)-順序を意識しない
順序対は、<1, 2>のように尖った括弧で、非順序対は{1, 2}のような括弧で表記

順序対は、順序が違えば別物 <1, 2> ≠ <2, 1>
非順序対の場合は順序を無視 {1, 2} = {2, 1}

順序対-直積を作ればよい
SELECT	P1.p_name AS name_1, P2.p_name AS name_2
FROM	JoinProducts P1, JoinProducts P2;

順序対を非順序対へ
SELECT	P1.p_name AS name_1, P2.p_name AS name_2
FROM	JoinProducts P1, JoinProducts P2
WHERE	P1.p_name > P2.p_name


「同じ家族だけど住所が不一致なレコード」を検出する
SELECT	DISTINCT A1.a_name, A1.address
FROM	Addresses A1,
	Addresses A2
WHERE	A1.family_id = A2.family_id
AND	A1.address <> A2.address ;


商品分析(値段が同じ商品の組み合わせ)
SELECT	DISTINCT a.p_name, a.price
FROM	Product2 AS a, Product2 AS b
WHERE	a.p_name <> b.p_name
AND	a.price = b.price

※相関サブクエリを用いた書き方
--練習問題


ランキング
