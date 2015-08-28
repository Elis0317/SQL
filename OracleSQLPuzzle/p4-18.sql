日本語の条件文にドモルガンの法則

データ作成スクリプト
create table mainT
(
	a_code integer
,	b_code char(2)
,	a_suuchi integer
,	b_suuchi integer
,	c_code char(1)
,	d_code char(4)
,	kbn integer
);

insert into mainT values(10,'xx',  1,  10,'b','xx01',99);
insert into mainT values(10,'xx',  1,  10,'a','xx01',99);
insert into mainT values(10,'yy', 10, 100,'b','yy01',99);
insert into mainT values(10,'yy', 10, 100,'a','yy01',99);
insert into mainT values(10,'xx',100,1000,'b','xx02',99);
insert into mainT values(10,'yy',100,1000,'a','yy02',99);
insert into mainT values(10,'xx', 50, 500,'b','xx02',10);
insert into mainT values(10,'xx', 50, 500,'a','xx02',10);
insert into mainT values(10,'xx', 80, 800,'b','xx02',20);
insert into mainT values(10,'yy', 80, 800,'a','yy02',20);
insert into mainT values(10,'yy', 60, 600,'b','yy03',30);
insert into mainT values(10,'yy', 40, 400,'a','yy03',30);
insert into mainT values(20,'xx',  1,  10,'b','xx01',99);
insert into mainT values(20,'xx',  1,  10,'a','xx01',99);
insert into mainT values(20,'yy', 10, 200,'b','yy01',99);
insert into mainT values(20,'yy', 10, 100,'a','yy01',99);
insert into mainT values(50,'xx',111, 123,'a','xx01',22);
insert into mainT values(50,'yy',333, 123,'b','xx01',22);
	
create table subT
(
	d_code char(4)
,	kbn integer
);
insert into subT values('xx01',99);
insert into subT values('yy01',99);
insert into subT values('xx02',99);
insert into subT values('yy02',99);
insert into subT values('xx03',99);
insert into subT values('yy03',99);

回答
