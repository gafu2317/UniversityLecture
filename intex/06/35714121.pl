/*
rep06: 第6回 演習課題レポート
提出日: 2025年5月19日
学籍番号: 35714121
名前: 福富隆大
*/

/*
(課題)
問題5.2 (教科書p.133)
次の関係は正数，零，負数の３つに数を分類する．

class(Number,positive) :- Number>0.
class(0,zero).
class(Number,negative) :- Number<0.

この手続きを，カットを使ってもっと効率的に定義せよ．
※様々なケースを試してみて正しいことを確かめよ．
*/

/*Prologプログラムと術後の説明*/
class(Number, positive) :- Number > 0, !.
class(0, zero) :- !.
class(Number, negative).

/*
（実行例）
?- class(5, X).
X = positive.

?-  class(0, X).
X = zero.

?- class(-3, X).
X = negative.

?- class(5, zero).
false.

[trace]  ?- class(5, X).
   Call: (12) class(5, _24906) ? creep
   Call: (13) 5>0 ? creep
   Exit: (13) 5>0 ? creep
   Exit: (12) class(5, positive) ? creep
X = positive.
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
カットを使うことで数値が生の場合にはpositiveを返しバックトラックを防止できる
同様に0の場合もzeroを返す
それ以外の場合は自動的にnegativeを返すようにしている
これによって不要な探索を省くことができる
数値でないものを与えるとfalseが返る
*/

/*
(課題)
問題5.3 (教科書p.133)
数のリストを正数のリスト（0も含む）と，負のリストに分割する手続き　split(Numbers,Positives,Negatives)を定義せよ．たとえば，split([3,-1,0,5,-2],[3,0,5],[-1,-2])
カットを使うプログラム splitA/3と，使わないプログラム splitB/3の２つを考えよ．
*/

/*Prologプログラムと術後の説明*/
% カットを使うバージョン
splitA([], [], []).
splitA([H|T], [H|P], N) :- H >= 0, !, splitA(T, P, N).
splitA([H|T], P, [H|N]) :- splitA(T, P, N).

% カットを使わないバージョン
splitB([], [], []).
splitB([H|T], [H|P], N) :- H >= 0, splitB(T, P, N).
splitB([H|T], P, [H|N]) :- H < 0, splitB(T, P, N).

/*
（実行例）
?- splitA([3,-1,0,5,-2], P, N).
P = [3, 0, 5],
N = [-1, -2].

?- splitB([3,-1,0,5,-2], P, N).
P = [3, 0, 5],
N = [-1, -2] .

?- splitA([], P, N).
P = N, N = [].

?- splitA([0,0,0], P, N).
P = [0, 0, 0],
N = [].

?- splitA([-1,-2,-3], P, N).
P = [],
N = [-1, -2, -3].

?- splitA([3,-1,0,5,-2], [5,3,0], [-1,-2]).
false.

?- splitB([3,-1,0,5,-2], [5,3,0], [-1,-2]).
false.

?- splitA([3,-1,0,5,-2], [3,0,5], [-2,-1]).
false.

?- splitB([3,-1,0,5,-2], [3,0,5], [-2,-1]).
false.

[trace]  ?- splitA([3,-1,0,5,-2], P, N).
   Call: (12) splitA([3, -1, 0, 5, -2], _17162, _17164) ? creep
   Call: (13) 3>=0 ? creep
   Exit: (13) 3>=0 ? creep
   Call: (13) splitA([-1, 0, 5, -2], _18592, _17164) ? creep
   Call: (14) -1>=0 ? creep
   Fail: (14) -1>=0 ? creep
   Redo: (13) splitA([-1, 0, 5, -2], _18592, _17164) ? creep
   Call: (14) splitA([0, 5, -2], _18592, _23472) ? creep
   Call: (15) 0>=0 ? creep
   Exit: (15) 0>=0 ? creep
   Call: (15) splitA([5, -2], _24292, _23472) ? creep
   Call: (16) 5>=0 ? creep
   Exit: (16) 5>=0 ? creep
   Call: (16) splitA([-2], _26732, _23472) ? creep
   Call: (17) -2>=0 ? creep
   Fail: (17) -2>=0 ? creep
   Redo: (16) splitA([-2], _26732, _23472) ? creep
   Call: (17) splitA([], _26732, _31612) ? creep
   Exit: (17) splitA([], [], []) ? creep
   Exit: (16) splitA([-2], [], [-2]) ? creep
   Exit: (15) splitA([5, -2], [5], [-2]) ? creep
   Exit: (14) splitA([0, 5, -2], [0, 5], [-2]) ? creep
   Exit: (13) splitA([-1, 0, 5, -2], [0, 5], [-1, -2]) ? creep
   Exit: (12) splitA([3, -1, 0, 5, -2], [3, 0, 5], [-1, -2]) ? creep
P = [3, 0, 5],
N = [-1, -2].
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
splitAはカットを使用しているため、要素が０以上の場合は最初の節が選ばれ、それ以外は自動的に２番目の節が選ばれる
splitBはカットを使用せず、明示的に条件分岐を記述しているので書く要素にたいして条件をチェックしている
そのため、splitAの方が効率的に動作する
正の数や負の数の要素の順序が異なる場合はfalseが返る
*/

/*
(課題)
問題5.6 (教科書p.137)
canunify(List1,Term,List2)という述語を定義せよ．
ここで，List2はTermとマッチする List1の要素から作られるリストである．
ただし，このマッチによって値の具体化はなされないとする．
例えば，

?- canunify([X,b,t(Y)],t(a),List).
List=[X,t(Y)]

X,Yとt(a)とのマッチによって具体化が生じるけれども， X,Yは具体化されてはいけない点に注意せよ
ヒント：not(Term1=Term2)を用いよ．Term1=Term2なら not(Term1=Term2)は失敗して，生じた具体化は無効になる．
注意： not/1については以下の述語naf/1を用いて実装せよ．
naf(P) :- P,!,fail.
naf(_).
*/

/*Prologプログラムと術後の説明*/
% not/1の代わりにnaf/1を使用
naf(P) :- P, !, fail.
naf(_).

% canunify述語の定義
canunify([], _, []).
canunify([H|T], Term, [H|Rest]) :-
    \+ \+(H = Term),  % 具体化せずにマッチするかチェック
    canunify(T, Term, Rest).
canunify([H|T], Term, Rest) :-
    \+ (H = Term),    % マッチしない場合
    canunify(T, Term, Rest).

/*
（実行例）
?- canunify([X,b,t(Y)], t(a), List).
List = [X, t(Y)] .

?-  canunify([a,b,c], b, List).
List = [b] .

?- canunify([a,b,c], d, List).
List = [].

?- canunify([X,Y,Z], Z, List).
List = [X, Y, Z] .

?-  canunify([], anything, List).
List = [].

?- canunify([X,b,t(Y)], t(a), [X]).
false.

[trace]  ?- canunify([X,b,t(Y)], t(a), List).
   Call: (12) canunify([_6830, b, t(_6842)], t(a), _6860) ? creep
   Call: (13) _6830=t(a) ? creep
   Exit: (13) t(a)=t(a) ? creep
   Call: (13) canunify([b, t(_6842)], t(a), _8318) ? creep
   Call: (14) b=t(a) ? creep
   Fail: (14) b=t(a) ? creep
   Redo: (13) canunify([b, t(_6842)], t(a), [b|_10758]) ? creep
   Call: (14) b=t(a) ? creep
   Fail: (14) b=t(a) ? creep
   Redo: (13) canunify([b, t(_6842)], t(a), _8318) ? creep
   Call: (14) canunify([t(_6842)], t(a), _8318) ? creep
   Call: (15) t(_6842)=t(a) ? creep
   Exit: (15) t(a)=t(a) ? creep
   Call: (15) canunify([], t(a), _16446) ? creep
   Exit: (15) canunify([], t(a), []) ? creep
   Exit: (14) canunify([t(_6842)], t(a), [t(_6842)]) ? creep
   Exit: (13) canunify([b, t(_6842)], t(a), [t(_6842)]) ? creep
   Exit: (12) canunify([_6830, b, t(_6842)], t(a), [_6830, t(_6842)]) ? creep
List = [X, t(Y)] .
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
canuifyはリスト内の各要素が指定されたTermとマッチするかをチェックし、マッチした要素を新しいリストに追加する
具体化は行わないため、XやYなどの変数はそのまま残る
\+ naf(H = Term)を使用して、Hが実際にTermとマッチするかどうかをチェックするが、その結果として生じる可能性のある具体化は防止される。これにより、例えばXやt(Y)はt(a)とマッチする可能性があるが、マッチングの結果としてXやYが具体化されることない。
*/

