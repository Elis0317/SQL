CREATE TABLE JoinProducts
(p_name VARCHAR(10) PRIMARY KEY
,price INTEGER );

BEGIN TRANSACTION;
INSERT INTO JoinProducts VALUES('りんご', 100);
INSERT INTO JoinProducts VALUES('みかん', 50);
INSERT INTO JoinProducts VALUES('バナナ', 80);
COMMIT;


CREATE TABLE Addresses
(a_name VARCHAR(10) PRIMARY KEY
,familY_id INTEGER NOT NULL
,address VARCHAR(32));

BEGIN TRANSACTION;
INSERT INTO Addresses VALUES ('前田　義明', 100, '東京都港区虎ノ門3-2-29');
INSERT INTO Addresses VALUES ('前田　由美', 100, '東京都港区虎ノ門3-2-92');
INSERT INTO Addresses VALUES ('加藤　茶', 200, '東京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES ('加藤　勝', 200, '東京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES ('ホームズ', 300, 'ベーカー街221B');
INSERT INTO Addresses VALUES ('ワトソン', 400, 'ベーカー街221B');
COMMIT ;


CREATE TABLE Product2
(p_name VARCHAR(10) PRIMARY KEY
,price INTEGER );

BEGIN TRANSACTION ;
INSERT INTO Product2 VALUES ('りんご', 50);
INSERT INTO Product2 VALUES ('みかん', 100);
INSERT INTO Product2 VALUES ('ぶどう', 50);
INSERT INTO Product2 VALUES ('スイカ', 80);
INSERT INTO Product2 VALUES ('レモン', 30);
INSERT INTO Product2 VALUES ('いちご', 100);
INSERT INTO Product2 VALUES ('バナナ', 100);
COMMIT ;