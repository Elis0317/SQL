--Q1-1
CREATE TABLE Jyushoroku
	(toroku_bango	integer		NOT NULL,
	 namae		varchar(128)	NOT NULL,
	 jyusho		varchar(256)	NOT NULL,
	 tel_no		char(10),
	 mail_address	char(20),
	 PRIMARY KEY(toroku_bango));
	 
/* 基本構造
CREATE TABLE 名前	<= ""はいらない
	(列データ	型	(制約),	<= ,は最後の一つのみ
	 列データ	型	(制約),
	 ...
	 PRIMARY KEY(列データの一つ));	)と;を忘れない
*/