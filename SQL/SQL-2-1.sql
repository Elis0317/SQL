/******************************

SELECT��: �e�[�u������f�[�^�����o�����Ɏg��
	SELECT	<��>
	FROM	<�e�[�u����>
	
******************************/

SELECT shohin_id, shohin_mei, shiire_tanka
  FROM Shohin;
  
  
SELECT *	-- *���g���ƁA�u���ׂẮv�i�����ł͂��ׂĂ̗�j�̈Ӗ��ɂȂ�B
  FROM Shohin;
  
  
SELECT shohin_id    AS id,		-- <���̗�̖��O> AS <�V������̖��O> �ɂ��A�R���\�[���ɕ\������錋�ʂ��ς��
       shohin_mei   AS namae,	-- AS �̌�낪���{��ł��\��Ȃ�
       shiire_tanka AS tanka
  FROM Shohin;
  
  
SELECT DISTINCT shohin_bunrui	-- SELECT�̒����DISTINCT��u�����ƂŁA�d�����Ȃ������ʂ��o�͂����
  FROM Shohin;					-- NULL���܂Ƃ܂�͂��邪�A�������Ɏc��
  
  
SELECT DISTINCT shohin_bunrui, torokubi	-- DISTINCT A, B �̏ꍇ�AA, B�Ö@\\�����ɏd�����Ă���g�ݍ��킹�݂̂�������
  FROM Shohin;
  
  
/*****************************
WHERE��ɂ��s�̑I��
	SELECT	<��>
	FROM	<�e�[�u����>
	WHERE	<������>;
	
	���̋�̏��Ԃ���邱�ƁB
*****************************/

SELECT shohin_mei, shohin_bunrui
  FROM Shohin
 WHERE shohin_bunrui = '�ߕ�'; -- <= shohin_bunrui == '�ߕ��f�̍s�̒����� shohin_mei, shohin_bunrin ���o��
 
 