/*
rep07: 第7回 演習課題レポート
提出日: 2025年5月25日
学籍番号: 35714121
名前: 福富隆大
*/

/*
(課題)
問題6.2 (教科書p.153)
fを項のファイルとする．
findallterm(Term)
が，f中の項でTermとマッチする全てのものを端末に表示するように
手続きfindalltermを定義せよ．
Termがその過程で値の具体化を受けないようにせよ（具体化を受けると，ファイル中の後に出現する項と項とのマッチが阻止されてしまう）．
ファイルは各自用意し，その内容をレポートに記すこと．さらに実行例ではTermにユニファイ可能なものと不可能なものを複数混在させること．項のファイルを生成するときには，一つ一つの項の直後に終端記号（ピリオド）が必要である．たとえば，
p(a). atom. q(b(a)).
注意： 失敗としての否定not/1を使用する場合は以下の述語naf/1を定義すること
naf(P) :- P,!,fail.
naf(_).
*/

/*Prologプログラムと術後の説明*/

% 否定述語の定義
naf(P) :- P,!,fail.
naf(_).

% findallterm述語の定義
findallterm(Term) :-
    see('terms.txt'),
    findall_loop(Term),
    seen.

% ファイルから項を読み込んでマッチングを行うループ
findall_loop(Term) :-
    read(X),
    (X = end_of_file ->
        true
    ;
        (copy_term(Term, CopyTerm),
         CopyTerm = X ->
            write(X), nl
        ;
            true
        ),
        findall_loop(Term)
    ).

% テスト用ファイル terms.txt の内容:
% p(a).
% atom.
% q(b(a)).
% p(X).
% number(123).
% q(c).
% atom.
% r(p(a)).


/*
（実行例）
?- findallterm(p(X)).
p(a)
p(_15096)
true.

?- findallterm(atom).
atom
atom
true.

?- findallterm(q(Y)).
q(b(a))
q(c)
true.

?- findallterm(xyz).
true.
（何も表示されない - マッチする項がない）

[trace]  ?- findallterm(p(X)).
   Call: (12) findallterm(p(_20354)) ? creep
   Call: (13) see('terms.txt') ? creep
   Exit: (13) see('terms.txt') ? creep
   Call: (13) findall_loop(p(_20354)) ? creep
   Call: (14) read(_24078) ? creep
   Exit: (14) read(p(a)) ? creep
   Call: (14) p(a)=end_of_file ? creep
   Fail: (14) p(a)=end_of_file ? creep
   Redo: (13) findall_loop(p(_20354)) ? creep
   Call: (14) copy_term(p(_20354), _28122) ? creep
   Exit: (14) copy_term(p(_20354), p(_28938)) ? creep
   Call: (14) p(_28938)=p(a) ? creep
   Exit: (14) p(a)=p(a) ? creep
   Call: (14) write(p(a)) ? creep
p(a)
   Exit: (14) write(p(a)) ? creep
   Call: (14) nl ? creep

   Exit: (14) nl ? creep
   Call: (14) findall_loop(p(_20354)) ? creep
   Call: (15) read(_35384) ? creep
   Exit: (15) read(atom) ? creep
   Call: (15) atom=end_of_file ? creep
   Fail: (15) atom=end_of_file ? creep
   Redo: (14) findall_loop(p(_20354)) ? creep
   Call: (15) copy_term(p(_20354), _39424) ? creep
   Exit: (15) copy_term(p(_20354), p(_40240)) ? creep
   Call: (15) p(_40240)=atom ? creep
   Fail: (15) p(_40240)=atom ? creep
   Redo: (14) findall_loop(p(_20354)) ? creep
   Call: (15) true ? creep
   Exit: (15) true ? creep
   Call: (15) findall_loop(p(_20354)) ? creep
   Call: (16) read(_45880) ? creep
   Exit: (16) read(q(b(a))) ? creep
   Call: (16) q(b(a))=end_of_file ? creep
   Fail: (16) q(b(a))=end_of_file ? creep
   Redo: (15) findall_loop(p(_20354)) ? creep
   Call: (16) copy_term(p(_20354), _49928) ? creep
   Exit: (16) copy_term(p(_20354), p(_50744)) ? creep
   Call: (16) p(_50744)=q(b(a)) ? creep
   Fail: (16) p(_50744)=q(b(a)) ? creep
   Redo: (15) findall_loop(p(_20354)) ? creep
   Call: (16) true ? creep
   Exit: (16) true ? creep
   Call: (16) findall_loop(p(_20354)) ? creep
   Call: (17) read(_56384) ? creep
   Exit: (17) read(p(_57194)) ? creep
   Call: (17) p(_57194)=end_of_file ? creep
   Fail: (17) p(_57194)=end_of_file ? creep
   Redo: (16) findall_loop(p(_20354)) ? creep
   Call: (17) copy_term(p(_20354), _60428) ? creep
   Exit: (17) copy_term(p(_20354), p(_61244)) ? creep
   Call: (17) p(_61244)=p(_57194) ? creep
   Exit: (17) p(_57194)=p(_57194) ? creep
   Call: (17) write(p(_57194)) ? creep
p(_57194)
   Exit: (17) write(p(_57194)) ? creep
   Call: (17) nl ? creep

   Exit: (17) nl ? creep
   Call: (17) findall_loop(p(_20354)) ? creep
   Call: (18) read(_67690) ? creep
   Exit: (18) read(number(123)) ? creep
   Call: (18) number(123)=end_of_file ? creep
   Fail: (18) number(123)=end_of_file ? creep
   Redo: (17) findall_loop(p(_58)) ? creep
   Call: (18) copy_term(p(_58), _3388) ? creep
   Exit: (18) copy_term(p(_58), p(_4204)) ? creep
   Call: (18) p(_4204)=number(123) ? creep
   Fail: (18) p(_4204)=number(123) ? creep
   Redo: (17) findall_loop(p(_58)) ? creep
   Call: (18) true ? creep
   Exit: (18) true ? creep
   Call: (18) findall_loop(p(_58)) ? creep
   Call: (19) read(_9844) ? creep
   Exit: (19) read(q(c)) ? creep
   Call: (19) q(c)=end_of_file ? creep
   Fail: (19) q(c)=end_of_file ? creep
   Redo: (18) findall_loop(p(_58)) ? creep
   Call: (19) copy_term(p(_58), _13888) ? creep
   Exit: (19) copy_term(p(_58), p(_14704)) ? creep
   Call: (19) p(_14704)=q(c) ? creep
   Fail: (19) p(_14704)=q(c) ? creep
   Redo: (18) findall_loop(p(_58)) ? creep
   Call: (19) true ? creep
   Exit: (19) true ? creep
   Call: (19) findall_loop(p(_58)) ? creep
   Call: (20) read(_20344) ? creep
   Exit: (20) read(atom) ? creep
   Call: (20) atom=end_of_file ? creep
   Fail: (20) atom=end_of_file ? creep
   Redo: (19) findall_loop(p(_58)) ? creep
   Call: (20) copy_term(p(_58), _24384) ? creep
   Exit: (20) copy_term(p(_58), p(_25200)) ? creep
   Call: (20) p(_25200)=atom ? creep
   Fail: (20) p(_25200)=atom ? creep
   Redo: (19) findall_loop(p(_58)) ? creep
   Call: (20) true ? creep
   Exit: (20) true ? creep
   Call: (20) findall_loop(p(_58)) ? creep
   Call: (21) read(_30840) ? creep
   Exit: (21) read(r(p(a))) ? creep
   Call: (21) r(p(a))=end_of_file ? creep
   Fail: (21) r(p(a))=end_of_file ? creep
   Redo: (20) findall_loop(p(_58)) ? creep
   Call: (21) copy_term(p(_58), _34888) ? creep
   Exit: (21) copy_term(p(_58), p(_35704)) ? creep
   Call: (21) p(_35704)=r(p(a)) ? creep
   Fail: (21) p(_35704)=r(p(a)) ? creep
   Redo: (20) findall_loop(p(_58)) ? creep
   Call: (21) true ? creep
   Exit: (21) true ? creep
   Call: (21) findall_loop(p(_58)) ? creep
   Call: (22) read(_41344) ? creep
   Exit: (22) read(end_of_file) ? creep
   Call: (22) end_of_file=end_of_file ? creep
   Exit: (22) end_of_file=end_of_file ? creep
   Call: (22) true ? creep
   Exit: (22) true ? creep
   Exit: (21) findall_loop(p(_58)) ? creep
   Exit: (20) findall_loop(p(_58)) ? creep
   Exit: (19) findall_loop(p(_58)) ? creep
   Exit: (18) findall_loop(p(_58)) ? creep
   Exit: (17) findall_loop(p(_58)) ? creep
   Exit: (16) findall_loop(p(_58)) ? creep
   Exit: (15) findall_loop(p(_58)) ? creep
   Exit: (14) findall_loop(p(_58)) ? creep
   Exit: (13) findall_loop(p(_58)) ? creep
   Call: (13) seen ? creep
   Exit: (13) seen ? creep
   Exit: (12) findallterm(p(_58)) ? creep
true.
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
- copy_term/2を使用してTermのコピーを作成し、元のTermが具体化されないようにする
- ファイルから項を順次読み込み、コピーした項とマッチングを試行
- マッチした項のみを表示する
- p(X)の場合、p(a)とp(X)の両方にマッチ
- atomの場合、ファイル中の2つのatomにマッチ
- q(Y)の場合、q(b(a))とq(c)にマッチ
- xyzの場合、マッチする項がないため何も表示されない
*/

/*
(課題)
問題6.3（教科書p.155）
squeeze手続きを一般化して，カンマも扱えるようにせよ．カンマのすぐ前の空白はすべて削除し，カンマのあとには1つの空白を入れねばならないとする．また，カンマが連続している場合は一つだけになるように削除すること．
この問題に関してはtraceを必須としない．
traceを行いたい場合はseeでファイルを読み込んでからsqueezeを実行すること．
*/

/*Prologプログラムと術後の説明*/

squeeze :-
    squeeze_state(normal),
    !.  

squeeze_state(State) :-
    get0(C),
    (C = -1 ; C = end_of_file ->
        !  
    ;
        next_state(State, C, NewState),
        squeeze_state(NewState)
    ).

% 状態遷移と出力
next_state(normal, 32, space) :- !.  % 空白を見つけた

next_state(normal, 44, after_comma) :- !,  % カンマを見つけた
    put(44).

next_state(normal, C, normal) :- !,  % 通常文字
    put(C).

next_state(space, 32, space) :- !.  % 連続空白（何もしない）

next_state(space, 44, after_comma) :- !,  % 空白後のカンマ
    put(44).  % 空白は出力せずカンマのみ

next_state(space, C, normal) :- !,  % 空白後の通常文字
    put(32),  % 空白を出力
    put(C).   % 文字を出力

next_state(after_comma, 32, after_comma) :- !.  % カンマ後の空白（スキップ）

next_state(after_comma, 44, after_comma) :- !.  % 連続カンマ（スキップ）

next_state(after_comma, C, normal) :- !,  % カンマ後の通常文字
    put(32),  % 空白を1つ出力
    put(C).   % 文字を出力

% テスト用ファイル test1.txt の内容:
% hello  ,  world  ,,  test

% テスト用ファイル test2.txt の内容:
% a , b,,,c   ,d

/*
（実行例）
?- see('test1.txt'), squeeze, seen.
hello, world, test
true.

?- see('test2.txt'), squeeze, seen.
a, b, c, d
true.
*/

/*
(どのような処理が行われて成功または失敗したかの考察)
- 状態機械アプローチにより、文字の文脈に応じた適切な処理を実現
- normal状態：通常の文字処理、空白やカンマを検出すると状態遷移
- space状態：空白を検出した状態、次の文字によって空白の出力を決定
- after_comma状態：カンマ後の状態、連続する空白やカンマをスキップ
- カット(!)により確定的な処理を行い、バックトラッキングによるエラーを防止
- ファイル終端(-1, end_of_file)の適切な処理により無限ループを回避

具体的な状態遷移：
1. "hello  ,  world" の処理例
   - 'h','e','l','l','o': normal状態で順次出力
   - ' ': normal→space状態（空白は保留）
   - ' ': space状態継続（連続空白をスキップ）
   - ',': space→after_comma状態（空白を出力せずカンマのみ出力）
   - ' ': after_comma状態継続（カンマ後空白をスキップ）
   - 'w': after_comma→normal状態（空白1つ+文字を出力）

2. 連続カンマ ",,,c" の処理例
   - ',': カンマを出力してafter_comma状態
   - ',': after_comma状態でスキップ（連続カンマを統合）
   - ',': 同様にスキップ
   - 'c': 空白1つ+'c'を出力してnormal状態

エラーが解決できなかったので書き方を根本から変えた
この方式により、複雑な文字の先読みや戻し処理なしに正確な整形が実現される
*/
