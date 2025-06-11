/*
rep03: 第3回 演習課題レポート
提出日: 2025年4月27日
学籍番号: 35714121
名前: 福富隆大
*/

/*
(課題)
問題3.1 (教科書p.72)
(a)リストLからその最後の３つの要素を消して別のリストL1を作る目標をconcを使って書け．
[ヒント：LはL1と３要素のリストの連接である．]
(b)リストLからその最初の３つの要素と最後の３つの要素を消したL2を作る目標の系列を書け
*/

/*Prologプログラム*/
conc([], L, L).
conc([X|L1],L2,[X|L3]) :- conc(L1,L2,L3).
q3_1_a(L,L1) :- conc(L1,[_,_,_],L).
q3_1_b(L,L2) :- conc(L1,[_,_,_],L),conc([_,_,_],L2,L1).

/*
（実行例）
?- q3_1_a([a,b,c,d,e,f,g], L1).
L1 = [a, b, c, d] ;
false.
?- q3_1_b([a,b,c,d,e,f,g,h,i,j], L2).
L2 = [d, e, f, g] ;
false.

[trace]  ?- q3_1_a([a,b,c,d,e,f,g], L1).
   Call: (12) q3_1_a([a, b, c, d, e, f, g], _22326) ? creep
   Call: (13) conc(_22326, [_23728, _23734, _23740], [a, b, c, d, e, f, g]) ? creep
   Call: (14) conc(_24562, [_23728, _23734, _23740], [b, c, d, e, f, g]) ? creep
   Call: (15) conc(_25382, [_23728, _23734, _23740], [c, d, e, f, g]) ? creep
   Call: (16) conc(_26202, [_23728, _23734, _23740], [d, e, f, g]) ? creep
   Call: (17) conc(_27022, [_23728, _23734, _23740], [e, f, g]) ? creep
   Exit: (17) conc([], [e, f, g], [e, f, g]) ? creep
   Exit: (16) conc([d], [e, f, g], [d, e, f, g]) ? creep
   Exit: (15) conc([c, d], [e, f, g], [c, d, e, f, g]) ? creep
   Exit: (14) conc([b, c, d], [e, f, g], [b, c, d, e, f, g]) ? creep
   Exit: (13) conc([a, b, c, d], [e, f, g], [a, b, c, d, e, f, g]) ? creep
   Exit: (12) q3_1_a([a, b, c, d, e, f, g], [a, b, c, d]) ? creep
L1 = [a, b, c, d] .

[trace]  ?- q3_1_b([a,b,c,d,e,f,g,h,i,j], L2).
   Call: (12) q3_1_b([a, b, c, d, e, f, g, h|...], _1318) ? creep
   Call: (13) conc(_2768, [_2772, _2778, _2784], [a, b, c, d, e, f, g, h|...]) ? creep
   Call: (14) conc(_3606, [_2772, _2778, _2784], [b, c, d, e, f, g, h, i|...]) ? creep
   Call: (15) conc(_4426, [_2772, _2778, _2784], [c, d, e, f, g, h, i, j]) ? creep
   Call: (16) conc(_5246, [_2772, _2778, _2784], [d, e, f, g, h, i, j]) ? creep
   Call: (17) conc(_6066, [_2772, _2778, _2784], [e, f, g, h, i, j]) ? creep
   Call: (18) conc(_6886, [_2772, _2778, _2784], [f, g, h, i, j]) ? creep
   Call: (19) conc(_7706, [_2772, _2778, _2784], [g, h, i, j]) ? creep
   Call: (20) conc(_8526, [_2772, _2778, _2784], [h, i, j]) ? creep
   Exit: (20) conc([], [h, i, j], [h, i, j]) ? creep
   Exit: (19) conc([g], [h, i, j], [g, h, i, j]) ? creep
   Exit: (18) conc([f, g], [h, i, j], [f, g, h, i, j]) ? creep
   Exit: (17) conc([e, f, g], [h, i, j], [e, f, g, h, i, j]) ? creep
   Exit: (16) conc([d, e, f, g], [h, i, j], [d, e, f, g, h, i, j]) ? creep
   Exit: (15) conc([c, d, e, f, g], [h, i, j], [c, d, e, f, g, h, i, j]) ? creep
   Exit: (14) conc([b, c, d, e, f, g], [h, i, j], [b, c, d, e, f, g, h, i|...]) ? creep
   Exit: (13) conc([a, b, c, d, e, f, g], [h, i, j], [a, b, c, d, e, f, g, h|...]) ? creep
   Call: (13) conc([_15856, _15862, _15868], _1318, [a, b, c, d, e, f, g]) ? creep
   Call: (14) conc([_15862, _15868], _1318, [b, c, d, e, f, g]) ? creep
   Call: (15) conc([_15868], _1318, [c, d, e, f, g]) ? creep
   Call: (16) conc([], _1318, [d, e, f, g]) ? creep
   Exit: (16) conc([], [d, e, f, g], [d, e, f, g]) ? creep
   Exit: (15) conc([c], [d, e, f, g], [c, d, e, f, g]) ? creep
   Exit: (14) conc([b, c], [d, e, f, g], [b, c, d, e, f, g]) ? creep
   Exit: (13) conc([a, b, c], [d, e, f, g], [a, b, c, d, e, f, g]) ? creep
   Exit: (12) q3_1_b([a, b, c, d, e, f, g, h|...], [d, e, f, g]) ? creep
L2 = [d, e, f, g] .
*/

/*
(説明，考察，評価)
[_,_,_]という要素を使うことでリストの最初の三つの要素や最後の三つの要素を消した。
*/

/*
(課題)
問題3.2 (教科書p.73)
関係las(Item,List)を，ItemがListの最後の要素であるように定義せよ．
(a)conc関係を使うプログラムと，
(b)concを使わないプログラムの2つを書け．
※注意事項：
last/2はSWI-Prologの組込み述語ですでに用意されているので，述語名は(a)lasa,(b)lasbとすること．
*/

/*Prologプログラム*/
lasa(Item, List) :- conc(_, [Item], List).
lasb(Item, [Item]).
lasb(Item, [_|Tail]) :- lasb(Item, Tail).

/*
（実行例）
?- lasa(c, [a,b,c]).
true ;
false.
?- lasb(c, [a,b,c]).
true ;
false.

[trace]  ?- lasa(c, [a,b,c]).
   Call: (12) lasa(c, [a, b, c]) ? creep
   Call: (13) conc(_27524, [c], [a, b, c]) ? creep
   Call: (14) conc(_28270, [c], [b, c]) ? creep
   Call: (15) conc(_29090, [c], [c]) ? creep
   Exit: (15) conc([], [c], [c]) ? creep
   Exit: (14) conc([b], [c], [b, c]) ? creep
   Exit: (13) conc([a, b], [c], [a, b, c]) ? creep
   Exit: (12) lasa(c, [a, b, c]) ? creep
true .

[trace]  ?- lasb(c, [a,b,c]).
   Call: (12) lasb(c, [a, b, c]) ? creep
   Call: (13) lasb(c, [b, c]) ? creep
   Call: (14) lasb(c, [c]) ? creep
   Exit: (14) lasb(c, [c]) ? creep
   Exit: (13) lasb(c, [b, c]) ? creep
   Exit: (12) lasb(c, [a, b, c]) ? creep
true .
*/

/*
(説明，考察，評価)
concを使う方は任意のリストと最後の要素をつなげてlistを作ることで実装している。
concを使わない方はリストのheadを一つずつ消していき、最後の要素がそのリストの要素と一致していたらtrueになるという方法で実装している。
*/

/*
(課題)
問題3.4 (教科書p.79)
リストを逆転させる関係rev(List,ReversedList)を定義せよ，たとえばrev([a,b,c,d],[d,c,b,a]).
※注意事項：
reverse/2はSWI-Prologの組込み述語ですでに用意されているので，述語名はrevとすること．
*/

/*Prologプログラム*/
rev(List, ReversedList) :- rev_acc(List, [], ReversedList).
rev_acc([], Acc, Acc).
rev_acc([H|T], Acc, Result) :- rev_acc(T, [H|Acc], Result).

/*
（実行例）
?- rev([a,b,c,d], X).
X = [d, c, b, a].

[trace]  ?- rev([a,b,c,d], X).
   Call: (12) rev([a, b, c, d], _44246) ? creep
   Call: (13) rev_acc([a, b, c, d], [], _44246) ? creep
   Call: (14) rev_acc([b, c, d], [a], _44246) ? creep
   Call: (15) rev_acc([c, d], [b, a], _44246) ? creep
   Call: (16) rev_acc([d], [c, b, a], _44246) ? creep
   Call: (17) rev_acc([], [d, c, b, a], _44246) ? creep
   Exit: (17) rev_acc([], [d, c, b, a], [d, c, b, a]) ? creep
   Exit: (16) rev_acc([d], [c, b, a], [d, c, b, a]) ? creep
   Exit: (15) rev_acc([c, d], [b, a], [d, c, b, a]) ? creep
   Exit: (14) rev_acc([b, c, d], [a], [d, c, b, a]) ? creep
   Exit: (13) rev_acc([a, b, c, d], [], [d, c, b, a]) ? creep
   Exit: (12) rev([a, b, c, d], [d, c, b, a]) ? creep
X = [d, c, b, a].
*/

/*
(説明，考察，評価)
補助述語を使用して実装した。rev_accではリストの要素を一つずつ取り出し移動させることで逆順にしている。
*/

/*
(課題)
問題3.9 (教科書p.79)関係
dividelist(List,List1,List2)を，Listの要素がほぼ同じ長さのList1とList2に分割されるように定義せよ．たとえばdividelist([a,b,c,d,e],[a,c,e],[b,d]).
*/

/*Prologプログラム*/
dividelist([], [], []).
dividelist([X], [X], []).
dividelist([X,Y|Rest], [X|Rest1], [Y|Rest2]) :- dividelist(Rest, Rest1, Rest2).

/*
（実行例）
?- dividelist([a,b,c,d,e], List1, List2).
List1 = [a, c, e],
List2 = [b, d] ;
false.

[trace]  ?- dividelist([a,b,c,d,e], List1, List2).
   Call: (12) dividelist([a, b, c, d, e], _56998, _57000) ? creep
   Call: (13) dividelist([c, d, e], _58420, _58426) ? creep
   Call: (14) dividelist([e], _59246, _59252) ? creep
   Exit: (14) dividelist([e], [e], []) ? creep
   Exit: (13) dividelist([c, d, e], [c, e], [d]) ? creep
   Exit: (12) dividelist([a, b, c, d, e], [a, c, e], [b, d]) ? creep
List1 = [a, c, e],
List2 = [b, d] .
*/

/*
(説明，考察，評価)
リストの前二つの要素を一つずつ振り分けていくことで実装している。リストの長さが奇数と偶数の二つの場合があるので終了条件を二つ書いている。
*/

