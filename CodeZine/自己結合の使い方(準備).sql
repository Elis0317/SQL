CREATE TABLE JoinProducts
(p_name VARCHAR(10) PRIMARY KEY
,price INTEGER );

BEGIN TRANSACTION;
INSERT INTO JoinProducts VALUES('���', 100);
INSERT INTO JoinProducts VALUES('�݂���', 50);
INSERT INTO JoinProducts VALUES('�o�i�i', 80);
COMMIT;


CREATE TABLE Addresses
(a_name VARCHAR(10) PRIMARY KEY
,familY_id INTEGER NOT NULL
,address VARCHAR(32));

BEGIN TRANSACTION;
INSERT INTO Addresses VALUES ('�O�c�@�`��', 100, '�����s�`��Ճm��3-2-29');
INSERT INTO Addresses VALUES ('�O�c�@�R��', 100, '�����s�`��Ճm��3-2-92');
INSERT INTO Addresses VALUES ('�����@��', 200, '�����s�V�h�搼�V�h2-8-1');
INSERT INTO Addresses VALUES ('�����@��', 200, '�����s�V�h�搼�V�h2-8-1');
INSERT INTO Addresses VALUES ('�z�[���Y', 300, '�x�[�J�[�X221B');
INSERT INTO Addresses VALUES ('���g�\��', 400, '�x�[�J�[�X221B');
COMMIT ;


CREATE TABLE Product2
(p_name VARCHAR(10) PRIMARY KEY
,price INTEGER );

BEGIN TRANSACTION ;
INSERT INTO Product2 VALUES ('���', 50);
INSERT INTO Product2 VALUES ('�݂���', 100);
INSERT INTO Product2 VALUES ('�Ԃǂ�', 50);
INSERT INTO Product2 VALUES ('�X�C�J', 80);
INSERT INTO Product2 VALUES ('������', 30);
INSERT INTO Product2 VALUES ('������', 100);
INSERT INTO Product2 VALUES ('�o�i�i', 100);
COMMIT ;