SELECT CASE WHEN GROUPING(shohin_bunrui) = 1 
            THEN 'è§ïiï™óﬁ çáåv' 
            ELSE shohin_bunrui END AS shohin_bunrui,
       CASE WHEN GROUPING(torokubi) = 1 
            THEN 'ìoò^ì˙ çáåv' 
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
       SUM(hanbai_tanka) AS sum_tanka
  FROM Shohin
 GROUP BY ROLLUP(shohin_bunrui, torokubi);