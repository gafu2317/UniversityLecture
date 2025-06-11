/*
rep05: 第5回 演習課題レポート
提出日: 2025年5月7日
学籍番号: 35714121
名前: 福富隆大
*/

/*
(課題)
練習4.2 (p.98)
家族データベースで双子を見つけるために，twins(Child1,Child2)という関係を定義せよ．
また，従兄弟を見つけるための述語cousin(P1,P2)という関係を定義せよ．
血縁関係等を参考に各自でDBをつくり確認すること．
※本問題の前提：同姓同名かつ同一生年月日の人物は存在しない
*/

/*Prologプログラムと術後の説明*/
mem(X,[X|_]). %p69のmemの定義
mem(X,[_|T]):-mem(X,T).
hasband(X) :- family(X,_,_). %Xは夫
wife(X) :- family(_,X,_). %Xは妻
child(X) :- family(_,_,Children),mem(X,Children). %Xは子供
exist(X) :- hasband(X);wife(X);child(X). %Xは存在する
dateofbirth(person(_,_,Date),Date). %person(名前,姓,生年月日)

% 双子を定義
twins(Child1, Child2) :-
    family(_, _, Children),  % 同じ家族から
    mem(Child1, Children),  % Child1はその家族の子供
    mem(Child2, Children),  % Child2もその家族の子供
    Child1 \= Child2,  % 同一人物ではない 変数が束縛された後で不等式チェック
    dateofbirth(Child1, Date),  % Child1の生年月日
    dateofbirth(Child2, Date).  % Child2も同じ生年月日

% 従兄弟関係を定義
cousins(Person1, Person2) :-
    parent(Parent1, Person1),
    parent(Parent2, Person2),
    siblings(Parent1, Parent2),
    Person1 \= Person2.

% 親子関係を定義
parent(Parent, Child) :- 
    family(Parent, _, Children), 
    mem(Child, Children).
parent(Parent, Child) :- 
    family(_, Parent, Children), 
    mem(Child, Children).

% 兄弟姉妹関係を定義
siblings(Person1, Person2) :-
    parent(Parent, Person1),
    parent(Parent, Person2),
    Person1 \= Person2,
    !.  % 最初の解が見つかったら他の解を探さない


% 家族データの例
/*
家系図的なもの
jhon
  │ peter
  │  ├ ritsuki
  ├ alice
  ├ bob
  │  ├ carol
  │ lisa
mary
*/
family(person(john, smith, date(1965,8,12)), person(mary, smith, date(1967,3,25)), 
      [person(alice, smith, date(1990,5,15)), person(bob, smith, date(1990,5,15))]).

family(person(bob, smith, date(1990,5,15)), person(lisa, smith, date(1970,6,18)), 
      [person(carol, smith, date(1992,3,20))]).

family(person(peter, michael, date(1940,2,5)), person(alice, smith, date(1990,5,15)), 
      [person(ritsuki, michael, date(1999,8,12))]).

/*
（成功例と失敗例）
双子はbobとaliceで、従兄弟はritsukiとtomです。
双子が適切に出力されるかの確認
?- twins(person(bob, smith, date(1990,5,15)), X).
X = person(alice, smith, date(1990, 5, 15)) ;
false.
?- twins(person(alice, smith, date(1990, 5, 15)), X).
X = person(bob, smith, date(1990, 5, 15)) ;
false.
?- twins(X,Y).
X = person(alice, smith, date(1990, 5, 15)),
Y = person(bob, smith, date(1990, 5, 15)) ;
X = person(bob, smith, date(1990, 5, 15)),
Y = person(alice, smith, date(1990, 5, 15)) ;
false.
?- twins(person(john, smith, date(1965,8,12)),Y).
false.
従兄弟が適切に出力されるかの確認
?- cousins(person(carol, smith, date(1992,3,20)),X).
X = person(ritsuki, michael, date(1999, 8, 12)) ;
false.
?- cousins(person(ritsuki, michael, date(1999,8,12)),X).
X = person(carol, smith, date(1992, 3, 20)) ;
false.
?- cousins(person(john, smith, date(1965,8,12)),X).
false.
?- cousins(Y,X).
Y = person(carol, smith, date(1992, 3, 20)),
X = person(ritsuki, michael, date(1999, 8, 12)) ;
Y = person(ritsuki, michael, date(1999, 8, 12)),
X = person(carol, smith, date(1992, 3, 20)) ;
false.


[trace]  ?- twins(person(bob, smith, date(1990,5,15)), X).
   Call: (12) twins(person(bob, smith, date(1990, 5, 15)), _30344) ? creep
   Call: (13) family(_31760, _31762, _31686) ? creep
   Exit: (13) family(person(john, smith, date(1965, 8, 12)), person(mary, smith, date(1967, 3, 25)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (13) mem(person(bob, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (14) mem(person(bob, smith, date(1990, 5, 15)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (14) mem(person(bob, smith, date(1990, 5, 15)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (13) mem(person(bob, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (13) mem(_30344, [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (13) mem(person(alice, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (13) person(bob, smith, date(1990, 5, 15))\=person(alice, smith, date(1990, 5, 15)) ? creep
   Exit: (13) person(bob, smith, date(1990, 5, 15))\=person(alice, smith, date(1990, 5, 15)) ? creep
   Call: (13) dateofbirth(person(bob, smith, date(1990, 5, 15)), _39872) ? creep
   Exit: (13) dateofbirth(person(bob, smith, date(1990, 5, 15)), date(1990, 5, 15)) ? creep
   Call: (13) dateofbirth(person(alice, smith, date(1990, 5, 15)), date(1990, 5, 15)) ? creep
   Exit: (13) dateofbirth(person(alice, smith, date(1990, 5, 15)), date(1990, 5, 15)) ? creep
   Exit: (12) twins(person(bob, smith, date(1990, 5, 15)), person(alice, smith, date(1990, 5, 15))) ? creep
X = person(alice, smith, date(1990, 5, 15)) .


[trace]  ?- twins(person(bob, smith, date(1990,5,15)), X).
   Call: (12) twins(person(bob, smith, date(1990, 5, 15)), _30344) ? creep
   Call: (13) family(_31760, _31762, _31686) ? creep
   Exit: (13) family(person(john, smith, date(1965, 8, 12)), person(mary, smith, date(1967, 3, 25)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (13) mem(person(bob, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (14) mem(person(bob, smith, date(1990, 5, 15)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (14) mem(person(bob, smith, date(1990, 5, 15)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (13) mem(person(bob, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (13) mem(_30344, [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (13) mem(person(alice, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (13) person(bob, smith, date(1990, 5, 15))\=person(alice, smith, date(1990, 5, 15)) ? creep
   Exit: (13) person(bob, smith, date(1990, 5, 15))\=person(alice, smith, date(1990, 5, 15)) ? creep
   Call: (13) dateofbirth(person(bob, smith, date(1990, 5, 15)), _39872) ? creep
   Exit: (13) dateofbirth(person(bob, smith, date(1990, 5, 15)), date(1990, 5, 15)) ? creep
   Call: (13) dateofbirth(person(alice, smith, date(1990, 5, 15)), date(1990, 5, 15)) ? creep
   Exit: (13) dateofbirth(person(alice, smith, date(1990, 5, 15)), date(1990, 5, 15)) ? creep
   Exit: (12) twins(person(bob, smith, date(1990, 5, 15)), person(alice, smith, date(1990, 5, 15))) ? creep
X = person(alice, smith, date(1990, 5, 15)) .

[trace]  ?- cousins(person(carol, smith, date(1992,3,20)),X).
   Call: (12) cousins(person(carol, smith, date(1992, 3, 20)), _47780) ? creep
   Call: (13) parent(_49134, person(carol, smith, date(1992, 3, 20))) ? creep
   Call: (14) family(_49134, _50022, _49946) ? creep
   Exit: (14) family(person(john, smith, date(1965, 8, 12)), person(mary, smith, date(1967, 3, 25)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (14) mem(person(carol, smith, date(1992, 3, 20)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (15) mem(person(carol, smith, date(1992, 3, 20)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (16) mem(person(carol, smith, date(1992, 3, 20)), []) ? creep
   Fail: (16) mem(person(carol, smith, date(1992, 3, 20)), []) ? creep
   Fail: (15) mem(person(carol, smith, date(1992, 3, 20)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Fail: (14) mem(person(carol, smith, date(1992, 3, 20)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Redo: (14) family(_49134, _56586, _49946) ? creep
   Exit: (14) family(person(bob, smith, date(1990, 5, 15)), person(lisa, smith, date(1970, 6, 18)), [person(carol, smith, date(1992, 3, 20))]) ? creep
   Call: (14) mem(person(carol, smith, date(1992, 3, 20)), [person(carol, smith, date(1992, 3, 20))]) ? creep
   Exit: (14) mem(person(carol, smith, date(1992, 3, 20)), [person(carol, smith, date(1992, 3, 20))]) ? creep
   Exit: (13) parent(person(bob, smith, date(1990, 5, 15)), person(carol, smith, date(1992, 3, 20))) ? creep
   Call: (13) parent(_60624, _47780) ? creep
   Call: (14) family(_60624, _61512, _61436) ? creep
   Exit: (14) family(person(john, smith, date(1965, 8, 12)), person(mary, smith, date(1967, 3, 25)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (14) mem(_47780, [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (14) mem(person(alice, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (13) parent(person(john, smith, date(1965, 8, 12)), person(alice, smith, date(1990, 5, 15))) ? creep
   Call: (13) siblings(person(bob, smith, date(1990, 5, 15)), person(john, smith, date(1965, 8, 12))) ? creep
   Call: (14) parent(_66382, person(bob, smith, date(1990, 5, 15))) ? creep
   Call: (15) family(_66382, _67270, _67194) ? creep
   Exit: (15) family(person(john, smith, date(1965, 8, 12)), person(mary, smith, date(1967, 3, 25)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (15) mem(person(bob, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (16) mem(person(bob, smith, date(1990, 5, 15)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (16) mem(person(bob, smith, date(1990, 5, 15)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (15) mem(person(bob, smith, date(1990, 5, 15)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Exit: (14) parent(person(john, smith, date(1965, 8, 12)), person(bob, smith, date(1990, 5, 15))) ? creep
   Call: (14) parent(person(john, smith, date(1965, 8, 12)), person(john, smith, date(1965, 8, 12))) ? creep
   Call: (15) family(person(john, smith, date(1965, 8, 12)), _73836, _73760) ? creep
   Exit: (15) family(person(john, smith, date(1965, 8, 12)), person(mary, smith, date(1967, 3, 25)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (15) mem(person(john, smith, date(1965, 8, 12)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (16) mem(person(john, smith, date(1965, 8, 12)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Call: (17) mem(person(john, smith, date(1965, 8, 12)), []) ? creep
   Fail: (17) mem(person(john, smith, date(1965, 8, 12)), []) ? creep
   Fail: (16) mem(person(john, smith, date(1965, 8, 12)), [person(bob, smith, date(1990, 5, 15))]) ? creep
   Fail: (15) mem(person(john, smith, date(1965, 8, 12)), [person(alice, smith, date(1990, 5, 15)), person(bob, smith, date(1990, 5, 15))]) ? creep
無限ループになっていたので中断
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
今回働いているかは問題に関係なかったので省きました。
片方を指定してもう片方の双子を出力させる方は想定どうりだった。両方を変数で指定するとXとYが逆の組み合わせも出力されてしまった。
しかし、これは述語のミスではなく仕様に近いもので直すのが正しいのかわからなかったのでそのままにした。
もし、これを直すとしたら、twinsの定義の最後に名前を昇順にするようなものを追加すればいい。
双子がいない人物を試すとfalseが出力されることを確認できた。
従兄弟の場合の双子の時と同じように両方を変数にするとXとYが逆の組み合わせも出力されてしまったが同じ理由でそのままにした。
解決方法も同じである。
*/

/*
(課題)
練習4.5 (p.105)
acceptsの実行時のループは，たとえばそこまでの動作回数を数えることにより回避できる．
そうすると，シュミレータはある決められた長さの道だけを探すように求められる．acceptsをそのように修正せよ．
教科書P.104のaccepts/2のプログラムでは無限ループに陥るようなオートマトンを用意して動作確認を行うこと．
※ヒント：許される最大動作数を第３引数に加えよ
     accepts(State,String,Max_moves)
*/

/*Prologプログラムと術後の説明*/
% 状態の定義
state(q0).
state(q1).

% 終了状態の定義
final(q1).

% 遷移関係の定義
trans(q0, a, q0).  % q0から'a'を読んでq0に戻る（自己ループ）
trans(q0, b, q1).  % q0から'b'を読んでq1に進む

accepts(State, [], _) :- 
    final(State).  % 空文字列で終了状態なら受理

accepts(_, _, 0) :- 
    !, fail.  % 最大動作回数に達したら失敗

accepts(State, [X|Xs], Max_moves) :- 
    Max_moves > 0,  % まだ動作回数に余裕がある
    trans(State, X, NewState),  % 遷移を行う
    NewMax is Max_moves - 1,  % 動作回数を減らす
    accepts(NewState, Xs, NewMax).  % 再帰的に続ける

/*
（成功例と失敗例）
無限ループ
?- accepts(q0, [a,a,a], 10).
false.
終了する場合
?- accepts(q0, [a,a,a,b], 10).
true ;
false.
規定回数以内に終わらない場合
?- accepts(q0, [a,a,a,a,a,a,a,a,a,a,b], 5).
false.
規定回数以内に終わる場合
?- accepts(q0, [a,a,a,a,a,a,a,a,a,a,b], 15).
true ;
false.

[trace]  ?-  accepts(q0, [a,a,a,b], 10).
   Call: (12) accepts(q0, [a, a, a, b], 10) ? creep
   Call: (13) 10>0 ? creep
   Exit: (13) 10>0 ? creep
   Call: (13) trans(q0, a, _13996) ? creep
   Exit: (13) trans(q0, a, q0) ? creep
   Call: (13) _15592 is 10+ -1 ? creep
   Exit: (13) 9 is 10+ -1 ? creep
   Call: (13) accepts(q0, [a, a, b], 9) ? creep
   Call: (14) 9>0 ? creep
   Exit: (14) 9>0 ? creep
   Call: (14) trans(q0, a, _19548) ? creep
   Exit: (14) trans(q0, a, q0) ? creep
   Call: (14) _21144 is 9+ -1 ? creep
   Exit: (14) 8 is 9+ -1 ? creep
   Call: (14) accepts(q0, [a, b], 8) ? creep
   Call: (15) 8>0 ? creep
   Exit: (15) 8>0 ? creep
   Call: (15) trans(q0, a, _25100) ? creep
   Exit: (15) trans(q0, a, q0) ? creep
   Call: (15) _26696 is 8+ -1 ? creep
   Exit: (15) 7 is 8+ -1 ? creep
   Call: (15) accepts(q0, [b], 7) ? creep
   Call: (16) 7>0 ? creep
   Exit: (16) 7>0 ? creep
   Call: (16) trans(q0, b, _30652) ? creep
   Exit: (16) trans(q0, b, q1) ? creep
   Call: (16) _32248 is 7+ -1 ? creep
   Exit: (16) 6 is 7+ -1 ? creep
   Call: (16) accepts(q1, [], 6) ? creep
   Call: (17) final(q1) ? creep
   Exit: (17) final(q1) ? creep
   Exit: (16) accepts(q1, [], 6) ? creep
   Exit: (15) accepts(q0, [b], 7) ? creep
   Exit: (14) accepts(q0, [a, b], 8) ? creep
   Exit: (13) accepts(q0, [a, a, b], 9) ? creep
   Exit: (12) accepts(q0, [a, a, a, b], 10) ? creep
true .
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
Max_movesを指定し、その回数以内に終わらない場合はfalseが出力される。
その結果無限ループを防ぐことができた。しかし、入力的には終わることができても規定回数以内に終わることができないものはfalseが出力されるようになってしまった。
これは規定回数に達したらその後に終了できるかを判定せずにfalseを出力しているためである。
*/

