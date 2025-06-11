/*
rep02: 第2回 演習課題レポート
提出日: 2025年4月20日
学籍番号: 35714121
名前: 福富隆大
*/

/*
練習1.2 (教科書p.6)
parent関係に関する次の質問をPrologで表せ．
(a) Patの親は誰か．
(b) Lizは子どもをもつか．
(c) Patの祖父母は誰か．
% [述語の説明]
% parent(X,Y): XはYの親である
*/

/*Prologプログラム*/
parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

/*
(実行例)
(a)
?- parent(X,pat).
X = bob.
(b)
?- parent(liz,Child).
false.
(c)
?- parent(Parent,pat),parent(Grandparent,Parent).
Parent = bob,
Grandparent = pam ;
Parent = bob,
Grandparent = tom.

*/

/*
(説明，考察，評価)
(a)
patの親はボブ
(b)
リズに子供はいない
(c)
patの祖父母はpamとtomである
*/

/*
練習1.5 (教科書p.12)
parentとsisterという関係を用いてaunt(X,Y)を定義せよ．
ヒント: aunt関係に対して図1.3の形式のグラフを書くと分かりやすい．
*/

/*Prologプログラム*/
female(pam).
female(liz).
female(pat).
female(ann).
mele(tom).
mele(bob).
male(jim).
different(X,Y) :- X \== Y.
sister(X,Y) :- female(X), parent(Z,X), parent(Z,Y), different(X,Y).
aunt(X,Y) :- sister(X,Z), parent(Z,Y).

/*
（実行例）
?- aunt(X,Y).
X = liz,
Y = ann ;
X = liz,
Y = pat ;
X = pat,
Y = jim ;
X = ann,
Y = jim.
*/

/*
(説明，考察，評価)
sister関係を定義することでaunt関係を定義することができた
lizはannとpatのおばで、patとannはjimのおばであることがわかった。
*/

/*
練習1.6 (教科書p.18) 
次に示すもう１つのpredecessor関係の定義について考察せよ．
predecessor2(X,Z) :- parent(X,Z).
predecessor2(X,Z) :- parent(Y,Z), predecessor2(X,Y).
ヒント: これもpredecessorの適切な定義と思えるだろうか． 図1.7のグラフを修正してこの新しい定義とそのグラフが対応するようにできるだろうか．
※注意事項：
図1.8の例題を参照して演習を行うこと．
SWI-Prologにはdifferentは定義されていないため，図1.8の例題 プログラムに加えて以下のルールを追加すること．
different(X,Y) :- X \== Y.
練習1.6 では 図1.8の例題と述語名を変更すること
(例) predecessor => predecessor2
*/

/*Prologプログラム*/
offspring(X,Y) :- parent(X,Y).
mother(X,Y) :- female(X), parent(X,Y).
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).
predecessor(X,Z) :- parent(X,Z).
predecessor(X,Z) :- parent(X,Y), predecessor(Y,Z).
predecessor2(X,Z) :- parent(X,Z).
predecessor2(X,Z) :- parent(Y,Z), predecessor2(X,Y).

/*
（実行例）
?- trace, predecessor(tom, jim).
   Call: (13) predecessor(tom, jim) ? creep
   Call: (14) parent(tom, jim) ? creep
   Fail: (14) parent(tom, jim) ? creep
   Redo: (13) predecessor(tom, jim) ? creep
   Call: (14) parent(tom, _18342) ? creep
   Exit: (14) parent(tom, bob) ? creep
   Call: (14) predecessor(bob, jim) ? creep
   Call: (15) parent(bob, jim) ? creep
   Fail: (15) parent(bob, jim) ? creep
   Redo: (14) predecessor(bob, jim) ? creep
   Call: (15) parent(bob, _23204) ? creep
   Exit: (15) parent(bob, ann) ? creep
   Call: (15) predecessor(ann, jim) ? creep
   Call: (16) parent(ann, jim) ? creep
   Fail: (16) parent(ann, jim) ? creep
   Redo: (15) predecessor(ann, jim) ? creep
   Call: (16) parent(ann, _28066) ? creep
   Fail: (16) parent(ann, _28066) ? creep
   Fail: (15) predecessor(ann, jim) ? creep
   Redo: (15) parent(bob, _23204) ? creep
   Exit: (15) parent(bob, pat) ? creep
   Call: (15) predecessor(pat, jim) ? creep
   Call: (16) parent(pat, jim) ? creep
   Exit: (16) parent(pat, jim) ? creep
   Exit: (15) predecessor(pat, jim) ? creep
   Exit: (14) predecessor(bob, jim) ? creep
   Exit: (13) predecessor(tom, jim) ? creep
true .

[trace]  ?- trace, predecessor2(tom, jim).
   Call: (13) predecessor2(tom, jim) ? creep
   Call: (14) parent(tom, jim) ? creep
   Fail: (14) parent(tom, jim) ? creep
   Redo: (13) predecessor2(tom, jim) ? creep
   Call: (14) parent(_43430, jim) ? creep
   Exit: (14) parent(pat, jim) ? creep
   Call: (14) predecessor2(tom, pat) ? creep
   Call: (15) parent(tom, pat) ? creep
   Fail: (15) parent(tom, pat) ? creep
   Redo: (14) predecessor2(tom, pat) ? creep
   Call: (15) parent(_48292, pat) ? creep
   Exit: (15) parent(bob, pat) ? creep
   Call: (15) predecessor2(tom, bob) ? creep
   Call: (16) parent(tom, bob) ? creep
   Exit: (16) parent(tom, bob) ? creep
   Exit: (15) predecessor2(tom, bob) ? creep
   Exit: (14) predecessor2(tom, pat) ? creep
   Exit: (13) predecessor2(tom, jim) ? creep
true .
*/

/*
(説明，考察，評価)
predecessor2もpredecessorの適切な定義と言える。
両者の違いは子孫方向にさがすか、親方向にさがすかの違いである。
*/


/*
問題2.1 (教科書p.34)
次のどれが構文的に正しいPrologオブジェクトであるか．それらはどんな種類のオブジェクト（アトム，数，変数，構造）か．
(a)Diana
(b)diana
(c)'Diana'
(d)_diana
(e)'Diana goes south'
(f)goes(diana,south)
(g)45
(h)5(X,Y)
(i)+(north,west)
(j)three(Black(Cats))
*/

/*
(説明，考察，評価)
(a)正しい変数オブジェクト
(b)正しいアトムオブジェクト
(c)正しいアトムオブジェクト
(d)正しい変数オブジェクト
(e)正しいアトムオブジェクト
(f)正しい構造オブジェクト
(g)正しい数オブジェクト
(h)正しくないオブジェクト
(i)正しい構造オブジェクト
(j)正しい構造オブジェクト
*/

/*
問題2.3 (教科書p.40)
次のマッチング操作は成功するか失敗するか．成功するなら，結果としてどのような変数の変数の具体化が得られるか．
(a)point(A,B)=point(1,2)
(b)point(A,B)=point(X,Y,Z)
(c)plus(2,2)=4
(d)+(2,D)=+(E,2) 
(e)triangle(point(-1,0),P2,P3)=triangle(P1,point(1,0),point(0,Y))
この結果得られる具体化は三角形のあるクラスを定義する．この三角形がどのようなものかを記述せよ．
*/

/*
（実行例）
?- point(A,B)=point(1,2).
A = 1,
B = 2.
?- point(A,B)=point(X,Y,Z).
false.
?- plus(2,2)=4.
false.
?- '+'(2,D)='+'(E,2).
D = E, E = 2.
?- triangle(point(-1,0),P2,P3)=triangle(P1,point(1,0),point(0,Y)).
P2 = point(1, 0),
P3 = point(0, Y),
P1 = point(-1, 0).
*/

/*
(説明，考察，評価)
(a)はどちらの引数も二つなので成功
(b)は引数の数が異なるので失敗する。
(c)はオブジェクトが異なるので失敗する
(e)自分の環境では+でエラーが出たので、+ではなく'(+)'を使っている。同じファンクタで引数も同じ数なので成功する。
(d)この具体化は(-1,0)(1,0)に頂点があり、Y軸上に最後の頂点がある三角形を表している。よって2等編三角形である。
*/

/*
問題2.5 (教科書p.40)
矩形がrectangle(P1,P2,P3,P4)という項で表現されていると仮定せよ．ただしPは矩形の頂点で，正方向に順序づけられているとする．
Rが水平と垂直な辺をもった矩形である場合に真となる関係 regular(R) を定義せよ．
*/

/*Prologプログラム*/
horizontal(point(X1,Y), point(X2,Y)) :- X1 \= X2.
vertical(point(X,Y1), point(X,Y2)) :- Y1 \= Y2.
regular(rectangle(P1,P2,P3,P4)) :-
    (horizontal(P1,P2); vertical(P1,P2)),
    (horizontal(P2,P3); vertical(P2,P3)),
    (horizontal(P3,P4); vertical(P3,P4)),
    (horizontal(P4,P1); vertical(P4,P1)),
    P1 \= P3,
    P2 \= P4.
/*
（実行例）
?- regular(rectangle(point(0,0), point(0,1), point(1,1), point(1,0))).
true ;
false.
?- regular(rectangle(point(0,0), point(1,2), point(3,1), point(2,-1))).
false.
*/

/*
(説明，考察，評価)
水平と垂直な辺を持つ矩形を表す述語を定義して、水平と垂直な変を持った矩形を表す述語を定義した。
*/

