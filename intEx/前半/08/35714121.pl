/*
rep08: 第8回 演習課題レポート
提出日: 2025年6月2日
学籍番号: 35714121
名前: 福富隆大
*/

/*
(課題)
問題7.3 (教科書p.175)
述語ground(Term)を，具体化されていない変数がTermに含まれない なら真となるように定義せよ．※ただし，組み込み述語にgroundが 定義されているので，gndとして定義せよ．
*/

/* Prologプログラムと術後の説明 */
gnd(Term) :- 
    \+ \+ Term = Term.  % 二重否定を使用して変数の具体化をチェック

/* 
解説:
\+ \+ Term = Term は二重否定を使用しています。
最初の \+ は「失敗すれば成功」という否定です。
Term = Term は常に成功しますが、変数が含まれる場合は変数が具体化されます。
二重否定により、変数の具体化が行われた後に元の状態に戻ります。
もし Term に変数が含まれていれば、具体化された変数は元に戻りますが、
変数が含まれていなければ何も変化しません。
この性質を利用して、Term に変数が含まれていないかをチェックしています。
*/

/*
（実行例）
?- gnd(a).
true.

?- gnd(f(a,b)).
true.

?- gnd(X).
false.

?- gnd(f(a,X)).
false.

?- gnd(f(a,g(b,c))).
true.

[trace]  ?- gnd(a).
   Call: (12) gnd(a) ? creep
   Call: (13) true ? creep
   Exit: (13) true ? creep
   Exit: (12) gnd(a) ? creep
true.
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
- gnd(a) の場合: a は変数を含まないアトムなので成功します。
- gnd(f(a,b)) の場合: f(a,b) は変数を含まない複合項なので成功します。
- gnd(X) の場合: X は変数なので失敗します。
- gnd(f(a,X)) の場合: 複合項 f(a,X) に変数 X が含まれているので失敗します。
- gnd(f(a,g(b,c))) の場合: 複合項内にネストされた項も含めて変数がないので成功します。
*/

/*
(課題)
問題7.5 (教科書p.175)
subsumes(Term1,Term2)
という関係を，Term1がTerm2と等しいか一般的であるように定義せよ．
たとえば，

?- subsumes(X,c).
yes
?- subsumes(g(X),g(t(Y))).
yes
?- subsumes(f(X,X),f(a,b)).
no

つまり，subsumes(Term1,Term2)は以下の式を満足するときに真を 返す述語とする． HB(Term1)⊇HB(Term2)
ここでHB(T)は項Tのエルブラン基底の集合を表す．
ただし，組み込み述語にsubsumesが定義されているので， subsumeとして定義せよ ヒント： 項の構造に注目して問題の宣言的意味を満足するようにプログラム すると良い．（エルブラン領域を手続き的に求めて集合の大小関係 を比較しようとする場合，HBは一般的に無限となり得るため，解法 として適さない．）
*/

/* Prologプログラムと術後の説明 */
subsume(Term1, Term2) :-
    \+ \+ (Term1 = Term2, gnd(Term2)).

/* 
解説:
subsume(Term1, Term2) は Term1 が Term2 と等しいか、より一般的である場合に真となります。
実装では、Term1 と Term2 を単一化し、Term2 が具体化された状態で変数がないかをチェックします。
\+ \+ を使用することで、単一化による変数の束縛を一時的に行い、その後元の状態に戻します。
Term1 が Term2 より一般的である場合、Term1 の変数は Term2 の対応する部分と単一化できますが、
f(X,X) と f(a,b) のように、同じ変数が異なる値と単一化しなければならない場合は失敗します。
*/

/*
（実行例）
?- subsume(X, c).
true.

?- subsume(g(X), g(t(Y))).
true.

?- subsume(f(X,X), f(a,b)).
false.

?- subsume(f(X,Y), f(a,b)).
true.

?- subsume(f(a,X), f(a,b)).
true.

[trace]  ?- subsume(X, c).
   Call: (12) subsume(_8798, c) ? creep
   Call: (13) _8798=c ? creep
   Exit: (13) c=c ? creep
   Call: (13) gnd(c) ? creep
   Call: (14) true ? creep
   Exit: (14) true ? creep
   Exit: (13) gnd(c) ? creep
   Exit: (12) subsume(_8798, c) ? creep
true.
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
- subsume(X, c) の場合: 変数 X は任意の項と単一化できるため、c を包含します。成功します。
- subsume(g(X), g(t(Y))) の場合: g(X) は g(t(Y)) より一般的です。X は t(Y) と単一化できるため成功します。
- subsume(f(X,X), f(a,b)) の場合: f(X,X) では X が同じ値でなければならないのに対し、f(a,b) では a と b が異なるため、単一化に失敗します。
- subsume(f(X,Y), f(a,b)) の場合: 異なる変数 X と Y はそれぞれ a と b と単一化できるため成功します。
- subsume(f(a,X), f(a,b)) の場合: f(a,X) の X は b と単一化できるため成功します。
*/

/*
(課題)
問題7.8 (教科書p.185)
与えられた集合(集合はリストで表わされるとする)のすべての部分集合の集合を 計算するために，関係powerset(Set,Subsets)をbagofを用いて定義せよ
※rep04問題3.8で作成した部分集合を生成する述語subsを用いて定義すること
*/

/* Prologプログラムと術後の説明 */
% 部分集合を生成する述語 subs
subs([], []).
subs([H|T], [H|R]) :- subs(T, R).
subs([_|T], R) :- subs(T, R).

% べき集合を生成する述語 powerset
powerset(Set, Subsets) :-
    bagof(Subset, subs(Set, Subset), Subsets).

/* 
解説:
powerset(Set, Subsets) は、与えられた集合 Set のすべての部分集合を Subsets として返します。
実装では、bagof/3 を使用して、subs(Set, Subset) を満たすすべての Subset を収集します。

subs/2 は以下のように動作します：
1. 空リストの部分集合は空リストのみです。
2. [H|T] の部分集合は、H を含む T の部分集合と、H を含まない T の部分集合です。
   - subs([H|T], [H|R]) :- subs(T, R). は、H を含む部分集合を生成します。
   - subs([_|T], R) :- subs(T, R). は、H を含まない部分集合を生成します。

bagof/3 はこれらの部分集合をすべて収集し、リストとして返します。
*/

/*
（実行例）
?- powerset([], Subsets).
Subsets = [[]].

?- powerset([a], Subsets).
Subsets = [[a], []].

?- powerset([a,b], Subsets).
Subsets = [[a, b], [a], [b], []].

?- powerset([a,b,c], Subsets).
Subsets = [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []].

?- powerset([a,a], Subsets).
Subsets = [[a, a], [a], [a], []].

?- powerset(X, Subsets).
ERROR: Stack limit (1.0Gb) exceeded

[trace]  ?- powerset([], Subsets).
   Call: (12) powerset([], _17998) ? creep
^  Call: (13) bagof(_19300, subs([], _19300), _17998) ? creep
   Call: (18) subs([], _19300) ? creep
   Exit: (18) subs([], []) ? creep
^  Exit: (13) bagof(_19300, user:subs([], _19300), [[]]) ? creep
   Exit: (12) powerset([], [[]]) ? creep
Subsets = [[]].
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
- powerset([], Subsets) の場合: 空集合の部分集合は空集合のみなので、Subsets = [[]] となります。
- powerset([a], Subsets) の場合: [a] の部分集合は [a] と [] なので、Subsets = [[a], []] となります。
- powerset([a,b], Subsets) の場合: [a,b] の部分集合は [a, b], [a], [b], [] なので、Subsets = [[a, b], [a], [b], []] となります。
- powerset([a,b,c], Subsets) の場合: 8つの部分集合が生成されます。
- powerset([a,a], Subsets) の場合: Prolog ではリストの要素が重複していても区別するため、[a,a] の部分集合として重複を含む結果が返されます。これは数学的な集合の定義とは異なる挙動です。
- powerset(X, Subsets) の場合: 入力が具体化されていないため、エラーが発生します。bagof は変数 X に対して操作できないためです。
*/
