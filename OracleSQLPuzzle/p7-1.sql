�݌v���擾

�f�[�^�쐬�X�N���v�g
create Table sell(
ym   	integer,
money	integer);

insert into sell values(200010, 1500);
insert into sell values(200011, 1000);
insert into sell values(200012, 2000);
insert into sell values(200101, 2500);
insert into sell values(200102, 3000);
insert into sell values(200103,-2000);
insert into sell values(200104, 3000);

���ۂ̉�
SELECT	ym AS �N��,
	money AS ���z,
	SUM(money) OVER (ORDER BY ym) AS �݌v
FROM	sell
ORDER BY �N��;