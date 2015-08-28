nvl�֐��̈����ɏW���֐�
(PostgreSQL�ł�COALESCE���p)

�f�[�^�쐬�X�N���v�g
create table master
(
	f_num char(2),
	f_name varchar(4)
);

create table trans
(
	ymd date,
	f_num char(2),
	quantity integer
);

insert into master(f_num,f_name) values('a1','����');
insert into master(f_num,f_name) values('a2','�c��');
insert into master(f_num,f_name) values('a3','����');
insert into master(f_num,f_name) values('a4','�O�D');
insert into trans(ymd,f_num,quantity) values('2001/08/01','a1',100);
insert into trans(ymd,f_num,quantity) values('2001/08/01','a3',100);
insert into trans(ymd,f_num,quantity) values('2001/08/02','a1',150);
insert into trans(ymd,f_num,quantity) values('2001/08/02','a3',200);

��
SELECT	M.f_num
,	M.f_name
,	COALESCE(SUM(T.quantity), 0)
	/*
	COALESCE�͍����珇�Ɉ��������āA�ŏ���NULL�łȂ��l��Ԃ�
	�����SUM()��NULL�łȂ����SUM���ANULL�Ȃ�0��Ԃ�
	*/
FROM	master as M
  LEFT JOIN
	trans AS T
  ON	M.f_num = T.f_num
GROUP BY
	M.f_num
,	f_name
ORDER BY f_num
	