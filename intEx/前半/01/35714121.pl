% rep01: 第1回 演習課題レポート
% 提出日: 2025年4月9日
% 学籍番号: 35714121
% 名前: 福富隆大
%
% 練習X.Y △△関係を解くプログラム （テキスト???ページ）
% [述語の説明]
% parent(X,Y): XはYの親である
% father(X,Y): XはYの父親である
% male(X): Xは男である
% ancester(X,Y):  XはYの祖先である
% ...
%
% /*Prologプログラム*/
parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
male(tom).
male(bob).
father(X, Y) :- parent(X, Y),  male(X).
ancester(X,Y) :- parent(X,Y).
ancester(X,Y) :- parent(X,Y), ancester(X, Y).


/*
（実行例）
?- parent(tom, bob).
true .
...
*/

/*
(説明，考察，評価)
prologならではの実行を確かめることができた
...
*/
