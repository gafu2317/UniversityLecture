/*
rep04: 第4回 演習課題レポート
提出日: 2025年5月3日
学籍番号: 35714121
名前: 福富隆大
*/

/*
(課題)
問題3.8 (教科書p.79)
関係
	subs(Set,Subset)
を定義せよ．ただし，SetとSubsetは集合を表すリストである．この関
係は，部分集合関係を調べるだけではなく，与えられた集合の可能な部
分集合をすべて生成するためにも使えるようにしたい．たとえば
	?- subs([a,b,c],S).
	S=[a,b,c];
	S=[b,c];
	S=[c];
	S=[];
	S=[a,c];
	S=[a];
	…
※注意事項：
subset/2はSWI-Prologの組込み述語ですでに用意されているので，述語名はsubsとすること．
*/

/*Prologプログラム*/
subs([], []).
subs([_|Xs], Ys) :- subs(Xs, Ys).
subs([X|Xs], [X|Ys]) :- subs(Xs, Ys).

/*
（実行例）
集合の全ての部分集合を生成するかどうかの確認
?- subs([a,b,c], S).
S = [a, b, c] ;
S = [a, b] ;
S = [a, c] ;
S = [a] ;
S = [b, c] ;
S = [b] ;
S = [c] ;
S = [].
特定の集合が部分集合かどうかを判定できるかの確認
?- subs([a,b,c], [a,c]).
true.
?- subs([a,b,c], [a,d]).
false.

[trace]  ?- subs([a,b,c], S).
   Call: (12) subs([a, b, c], _29908) ? creep
   Call: (13) subs([b, c], _29908) ? creep
   Call: (14) subs([c], _29908) ? creep
   Call: (15) subs([], _29908) ? creep
   Exit: (15) subs([], []) ? creep
   Exit: (14) subs([c], []) ? creep
   Exit: (13) subs([b, c], []) ? creep
   Exit: (12) subs([a, b, c], []) ? creep
S = [] .
*/

/*
(説明，考察，評価)
空集合同士になるまで同じものを引いていくことで部分集合を生成している。
先頭の文字を含むものと含まないものの両方を生成するために二つの述語を作成した。
*/

/*
(課題)
問題3.11 (教科書p.80)
関係
	flat(List,FlatList)
を定義せよ．ただしListはリストのリストで，FlatListはListの部分リスト(またはそのまた部分リスト)の要素が
平板なリストとなるように，Listを平滑化したものである．たとえば，
	?-flat([a,b,[c,d],[],[[[e]]],f],L).
	  L=[a,b,c,d,e,f]
※注意事項：
flatten/2はSWI-Prologの組込み述語ですでに用意されているので，述語名はflatとすること．
*/

/*Prologプログラム*/
flat([], []).
flat([H|T], FlatList) :-
    is_list(H),
    flat(H, FlatH),
    flat(T, FlatT),
    append(FlatH, FlatT, FlatList).
flat([H|T], [H|FlatT]) :-
    \+ is_list(H),
    flat(T, FlatT).
flat(X, [X]) :-
    \+ is_list(X).

/*
（実行例）
基本的な平坦化
?- flat([a, b, [c, d], e], X).
X = [a, b, c, d, e].
空のリストを含むリストの平坦化
?-  flat([a, [], b], X).
X = [a, b].
深いネストを含むリストの平坦化
?- flat([a, [b, [c, [d]]], e], X).
X = [a, b, c, d, e].

[trace]  ?- flat([a, b, [c, d], e], X).
   Call: (12) flat([a, b, [c, d], e], _2172) ? creep
   Call: (13) is_list(a) ? creep
   Fail: (13) is_list(a) ? creep
   Redo: (12) flat([a, b, [c, d], e], _2172) ? creep
   Call: (13) is_list(a) ? creep
   Fail: (13) is_list(a) ? creep
   Redo: (12) flat([a, b, [c, d], e], [a|_5990]) ? creep
   Call: (13) flat([b, [c, d], e], _5990) ? creep
   Call: (14) is_list(b) ? creep
   Fail: (14) is_list(b) ? creep
   Redo: (13) flat([b, [c, d], e], _5990) ? creep
   Call: (14) is_list(b) ? creep
   Fail: (14) is_list(b) ? creep
   Redo: (13) flat([b, [c, d], e], [b|_11650]) ? creep
   Call: (14) flat([[c, d], e], _11650) ? creep
   Call: (15) is_list([c, d]) ? creep
   Exit: (15) is_list([c, d]) ? creep
   Call: (15) flat([c, d], _16496) ? creep
   Call: (16) is_list(c) ? creep
   Fail: (16) is_list(c) ? creep
   Redo: (15) flat([c, d], _16496) ? creep
   Call: (16) is_list(c) ? creep
   Fail: (16) is_list(c) ? creep
   Redo: (15) flat([c, d], [c|_19734]) ? creep
   Call: (16) flat([d], _19734) ? creep
   Call: (17) is_list(d) ? creep
   Fail: (17) is_list(d) ? creep
   Redo: (16) flat([d], _19734) ? creep
   Call: (17) is_list(d) ? creep
   Fail: (17) is_list(d) ? creep
   Redo: (16) flat([d], [d|_25394]) ? creep
   Call: (17) flat([], _25394) ? creep
   Exit: (17) flat([], []) ? creep
   Exit: (16) flat([d], [d]) ? creep
   Exit: (15) flat([c, d], [c, d]) ? creep
   Call: (15) flat([e], _31058) ? creep
   Call: (16) is_list(e) ? creep
   Fail: (16) is_list(e) ? creep
   Redo: (15) flat([e], _31058) ? creep
   Call: (16) is_list(e) ? creep
   Fail: (16) is_list(e) ? creep
   Redo: (15) flat([e], [e|_184]) ? creep
   Call: (16) flat([], _184) ? creep
   Exit: (16) flat([], []) ? creep
   Exit: (15) flat([e], [e]) ? creep
   Call: (15) lists:append([c, d], [e], _162) ? creep
   Exit: (15) lists:append([c, d], [e], [c, d, e]) ? creep
   Exit: (14) flat([[c, d], e], [c, d, e]) ? creep
   Exit: (13) flat([b, [c, d], e], [b, c, d, e]) ? creep
   Exit: (12) flat([a, b, [c, d], e], [a, b, c, d, e]) ? creep
X = [a, b, c, d, e] .
*/

/*
(説明，考察，評価)
ヘッドがリストなら平坦化してリストに追加し、これを再起的に呼び出して実装ている。
*/

/*
(課題)
問題3.12 (教科書p.85)
    :- op(300,xfx,plays).
    :- op(200,xfy,and).
というオペレータ定義を仮定すると，次の2つの項は構文的に正しいオブジェクトである．
    Term1 = jimmy plays football and squash
    Term2 = susan plays tennis and basketball and volleyball
これらの項はPrologによりいかに解釈されるか．その主関数子と構造を示せ．
※注意事項：
教科書記載の例以外の文を用意して動作を確認すること．

*/

/*Prologプログラム*/
:- op(300,xfx,plays).
:- op(200,xfy,and).

/*
（実行例）
?- write_canonical(susan plays tennis and basketball and volleyball).
plays(susan,and(tennis,and(basketball,volleyball)))
true.

[trace]  ?- write_canonical(susan plays tennis and basketball and volleyball).
plays(susan,and(tennis,and(basketball,volleyball)))
true.
*/

/*
(説明，考察，評価)
主関数子: plays
plays(susan, and(tennis, and(basketball, volleyball)))
playsが優先度３００なので主関数はplaysである。
and演算子は右結合性（xfy）を持つため、複数のandが連続する場合は右側から結合される。
*/

/*
(課題)
問題3.21 (教科書p.92)
手続き
    bet(N1,N2,X)
が，与えられた２つの整数N1,N2に対して，制約N1≦X≦N2を満たすすべての整数Xをバックトラックにより
生成するよう定義せよ．
※注意事項：
between/3はSWI-Prologの組込み述語ですでに用意されているので，述語名はbetとすること．
*/

/*Prologプログラム*/
bet(N, N, N).
bet(N1, N2, N1) :- 
    N1 < N2.
bet(N1, N2, X) :- 
    N1 < N2, 
    N1Next is N1 + 1, 
    bet(N1Next, N2, X).

/*
（実行例）
基本的な例
?- bet(1, 5, X).
X = 1 ;
X = 2 ;
X = 3 ;
X = 4 ;
X = 5 ;
false.
falseになる例
?-  bet(5, 3, X).
false.

[trace]  ?- bet(1, 5, X).
   Call: (12) bet(1, 5, _13598) ? creep
   Call: (13) 1<5 ? creep
   Exit: (13) 1<5 ? creep
   Exit: (12) bet(1, 5, 1) ? creep
X = 1 .
*/

/*
(説明，考察，評価)
N1とN2を比較し小さい方から順に答えを出していくように実装した。
*/

/*
(課題)
問題3.9-別解
conc(A, B, C)とlength(D, E)(p.90)を用いてdividelist(F, G, H)の別解dividelist2(F, G, H)を定義せよ． lengthは組込み述語が存在するので述語名をlenとせよ．
※ヒント：
分割された二つのリストの長さの差が１以下であればよい．concのバックトラックをうまく利用する
*/

/*Prologプログラム*/
conc([], L, L).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).
len([], 0).
len([_|T], N) :- len(T, N1), N is N1 + 1.
dividelist2(List, List1, List2) :-
    conc(List1, List2, List),
    len(List1, Len1),
    len(List2, Len2),
    Diff is abs(Len1 - Len2),
    Diff =< 1.

/*
（実行例）
偶数のリストの分割
?- dividelist2([a,b,c,d], L1, L2).
L1 = [a, b],
L2 = [c, d] ;
false.
奇数のリストの分割
?- dividelist2([a,b,c,d,e], L1, L2).
L1 = [a, b],
L2 = [c, d, e] ;
L1 = [a, b, c],
L2 = [d, e] ;
false.
リストを含むリストの分割
?- dividelist2([a,b,c,d,[e]], L1, L2).
L1 = [a, b],
L2 = [c, d, [e]] ;
L1 = [a, b, c],
L2 = [d, [e]] ;
false.

[trace]  ?- dividelist2([a,b,c,d], L1, L2).
   Call: (12) dividelist2([a, b, c, d], _20418, _20420) ? creep
   Call: (13) conc(_20418, _20420, [a, b, c, d]) ? creep
   Exit: (13) conc([], [a, b, c, d], [a, b, c, d]) ? creep
   Call: (13) len([], _23446) ? creep
   Exit: (13) len([], 0) ? creep
   Call: (13) len([a, b, c, d], _25068) ? creep
   Call: (14) len([b, c, d], _25880) ? creep
   Call: (15) len([c, d], _26692) ? creep
   Call: (16) len([d], _27504) ? creep
   Call: (17) len([], _28316) ? creep
   Exit: (17) len([], 0) ? creep
   Call: (17) _27504 is 0+1 ? creep
   Exit: (17) 1 is 0+1 ? creep
   Exit: (16) len([d], 1) ? creep
   Call: (16) _26692 is 1+1 ? creep
   Exit: (16) 2 is 1+1 ? creep
   Exit: (15) len([c, d], 2) ? creep
   Call: (15) _25880 is 2+1 ? creep
   Exit: (15) 3 is 2+1 ? creep
   Exit: (14) len([b, c, d], 3) ? creep
   Call: (14) _25068 is 3+1 ? creep
   Exit: (14) 4 is 3+1 ? creep
   Exit: (13) len([a, b, c, d], 4) ? creep
   Call: (13) _39682 is abs(0-4) ? creep
   Exit: (13) 4 is abs(0-4) ? creep
   Call: (13) 4=<1 ? creep
   Fail: (13) 4=<1 ? creep
   Redo: (13) conc(_20418, _20420, [a, b, c, d]) ? creep
   Call: (14) conc(_43752, _20420, [b, c, d]) ? creep
   Exit: (14) conc([], [b, c, d], [b, c, d]) ? creep
   Exit: (13) conc([a], [b, c, d], [a, b, c, d]) ? creep
   Call: (13) len([a], _46196) ? creep
   Call: (14) len([], _47008) ? creep
   Exit: (14) len([], 0) ? creep
   Call: (14) _46196 is 0+1 ? creep
   Exit: (14) 1 is 0+1 ? creep
   Exit: (13) len([a], 1) ? creep
   Call: (13) len([b, c, d], _51066) ? creep
   Call: (14) len([c, d], _51878) ? creep
   Call: (15) len([d], _52690) ? creep
   Call: (16) len([], _53502) ? creep
   Exit: (16) len([], 0) ? creep
   Call: (16) _52690 is 0+1 ? creep
   Exit: (16) 1 is 0+1 ? creep
   Exit: (15) len([d], 1) ? creep
   Call: (15) _51878 is 1+1 ? creep
   Exit: (15) 2 is 1+1 ? creep
   Exit: (14) len([c, d], 2) ? creep
   Call: (14) _51066 is 2+1 ? creep
   Exit: (14) 3 is 2+1 ? creep
   Exit: (13) len([b, c, d], 3) ? creep
   Call: (13) _62432 is abs(1-3) ? creep
   Exit: (13) 2 is abs(1-3) ? creep
   Call: (13) 2=<1 ? creep
   Fail: (13) 2=<1 ? creep
   Redo: (14) conc(_43752, _20420, [b, c, d]) ? creep
   Call: (15) conc(_66502, _20420, [c, d]) ? creep
   Exit: (15) conc([], [c, d], [c, d]) ? creep
   Exit: (14) conc([b], [c, d], [b, c, d]) ? creep
   Exit: (13) conc([a, b], [c, d], [a, b, c, d]) ? creep
   Call: (13) len([a, b], _1660) ? creep
   Call: (14) len([b], _2472) ? creep
   Call: (15) len([], _3284) ? creep
   Exit: (15) len([], 0) ? creep
   Call: (15) _2472 is 0+1 ? creep
   Exit: (15) 1 is 0+1 ? creep
   Exit: (14) len([b], 1) ? creep
   Call: (14) _1660 is 1+1 ? creep
   Exit: (14) 2 is 1+1 ? creep
   Exit: (13) len([a, b], 2) ? creep
   Call: (13) len([c, d], _9778) ? creep
   Call: (14) len([d], _10590) ? creep
   Call: (15) len([], _11402) ? creep
   Exit: (15) len([], 0) ? creep
   Call: (15) _10590 is 0+1 ? creep
   Exit: (15) 1 is 0+1 ? creep
   Exit: (14) len([d], 1) ? creep
   Call: (14) _9778 is 1+1 ? creep
   Exit: (14) 2 is 1+1 ? creep
   Exit: (13) len([c, d], 2) ? creep
   Call: (13) _17896 is abs(2-2) ? creep
   Exit: (13) 0 is abs(2-2) ? creep
   Call: (13) 0=<1 ? creep
   Exit: (13) 0=<1 ? creep
   Exit: (12) dividelist2([a, b, c, d], [a, b], [c, d]) ? creep
L1 = [a, b],
L2 = [c, d] .
*/

/*
(説明，考察，評価)
リストを分割し、長さを測ってそのさが１以下であることを確かめている。
*/
