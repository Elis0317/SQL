SELECT shohin_id, shohin_mei
  FROM Shohin
 WHERE shohin_bunrui = '�L�b�`���p�i'
UNION
SELECT shohin_id, shohin_mei
  FROM Shohin2
 WHERE shohin_bunrui = '�L�b�`���p�i'
ORDER BY shohin_id;



/* ���ӎ����@
-- �񐔂��s��v�̂��߃G���[
SELECT shohin_id, shohin_mei
  FROM Shohin
UNION
SELECT shohin_id, shohin_mei, hanbai_tanka
  FROM Shohin2;
*/

/* ���ӎ����A
-- �f�[�^�^���s��v�̂��߃G���[
SELECT shohin_id, hanbai_tanka
  FROM Shohin
UNION
SELECT shohin_id, torokubi
  FROM Shohin2;
*/