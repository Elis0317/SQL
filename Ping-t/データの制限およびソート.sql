問題ID： 7618

LIKE演算子を使用すると、指定した文字パターンに一致した行を検索できます。
文字パターンには、任意の1文字と一致する「_」や、0文字以上の任意の文字列と一致する「%」といった、ワイルドカードを利用できます。
ワイルドカードをリテラルの一部として使用する場合は、ESCAPEオプションを指定してワイルドカードをリテラルとして扱えるようにしなければなりません。

設問では「W」がエスケープ文字として指定されています。ですので「W」の直後に来るワイルドカードは、通常のリテラルとして扱われます。



問題ID： 7614

WHERE manager_id = NULL;
設問のSQL文では、MANAGER_ID列がNULLである行を検索していますが、IS NULL演算子を使用していません。
NULL値に対して=(等号)などの比較演算子を使用した場合、条件の判定がNULL値となり検索結果は1行も表示されません。（エラーにはなりません）

