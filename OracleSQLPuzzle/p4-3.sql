select���1��1�̌���

�f�[�^�쐬�X�N���v�g
create table tbl1(
tbl1_ID integer,
name1   varchar(4),
tbl2_ID integer);

insert into tbl1 values (1,'�R�c',1);
insert into tbl1 values (2,'����',2);
insert into tbl1 values (3,'���',3);
insert into tbl1 values (4,'�r�c',null);

create table tbl2(
tbl2_ID integer,
tel     varchar(12));

insert into tbl2 values (1,'052-111-xxxx');
insert into tbl2 values (2,'052-222-xxxx');
insert into tbl2 values (3,'052-333-xxxx');

create table tbl3(
tbl3_ID integer,
tbl2_ID integer,
mail    varchar(15));

insert into tbl3 values (1,1,'yamada@test.com');
insert into tbl3 values (2,2,'sato@test.com');
commit;

��
SELECT	tbl1.name1, tbl2.tel, tbl3.mail
FROM	tbl1
  LEFT JOIN tbl2
  ON	tbl2.tbl2_id = tbl1.tbl2_id
  LEFT JOIN tbl3
  ON	tbl3.tbl2_id = tbl2.tbl2_id