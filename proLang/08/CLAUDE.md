# プログラミング言語論レポート

## レポート4-1：クラスを使ってみる

* 名前と学籍番号をデータとして持ち，showメソッドで名前と学籍番号を表示できるクラスを作成せよ
  * なお，名前と学籍番号を設定するための公開メソッドも必要
* main関数で上記インスタンスを作成し，上のクラスの機能を確認するコードを作成せよ
  * 文字列はstringクラスを利用してもよいし，Cの文字列をつかってもよい．stringをちょっと調べて使えるようになった方が楽？

## レポート4-2：分割コンパイル 

```c++
#include <stdio.h>
class Stack
{
private:
int array[50];
int pos;
public:
Stack()
{
pos = 0;
}
void push(int x)
{
array[pos] = x;
pos++;
}
int pop()
{
pos--;
return array[pos];
}
};
int main()
{
Stack s;
s.push(1);
s.push(2);
s.push(3);
printf("%d¥n",s.pop());
printf("%d¥n",s.pop());
printf("%d¥n",s.pop());
}
```

* スライド中のスタッククラスを次の形でファイルを分けよ．
  * ヘッダファイル: stack.hpp (この中でメソッドの実装は書かない)
  * クラス定義ファイル: stack.cpp (すべてのメソッド実装を書く)
  * ユーザプログラム: main.cpp(冒頭で#include “stack.hpp”とする)
* 分割したファイルをコンパイルして動作を確認せよ．
  * コマンド：g++ -o stack stack.cpp main.cpp
* 適切なMakefileを作り，makeコマンドを利用してコンパイルせよ
  * コマンド：make でコンパイルが終わるMakefileを作成する
* スタッククラスに格納されている要素の個数を返す公開メソッドを追加せよ．

## レポート5-1：コンストラクタ・デストラクタ

席の数，机の数，プロジェクタの数，黒板の数をメンバ変
数に持つクラスを作り，コンストラクタで初期化せよ
* まず，何もしないコンストラクタをまず作り，メンバ変数の値を表示せよ．
* 次に，席，机，プロジェクタ，黒板の数を変更できるコンストラクタをオーバーロード（引数の型が異なれば複数のコンストラクタを定義できる）し，同様に表示せよ
  * ヒント：class Kyoshitsuに対して，下記コンストラクタを作成
  * Kyoshitsu(int zaseki, int tsukue, int projector, int kokuban)

## レポート5-2：継承

```c++
#include <stdio.h>
class IntArray{
private:
int size;
int* array;
public:
IntArray(int _size){
size = _size;
array = new int[size];
for (int i = 0; i < size; i++) array[i] = 0;
}
~IntArray(){
delete[] array;
printf("destructor called¥n");
}
void print_array(){
for (int i = 0; i < size; i++) 
printf("%d: %d¥n",i, array[i]);
}
};
int main(){
IntArray a(4);
a.print_array();
}

```

動的１次元配列のクラスIntArrayから継承して（簡単のため12ページのコードでprivateになっているところをprotectedに変えること），新しいクラスを作成せよ．
ただし，新しいクラスは，配列の各要素に数値を設定する公開メソットsetと，配列内の数値の合計を返す公開メソッドsumを持つものとする．

## レポート6-1

* Object クラスは抽象クラスであり，純粋仮想関数としてdouble area() を持つ．
  * Objectクラスの派生クラスとして，Rectangle クラスとCircleクラスがある
  * 例えば、Rectangle クラスの場合は、対角の２点を保持，円なら半径や直径などを持つとする
  * area メソッドは、面積を返すメソッドである
* 以上のクラスについて動作テストするコードを書け

## レポート6-2：ジェネリックな関数

* （１）次ページmin1.cpp を読み、中身を理解せよ．その上でプログラムを実行し，
その動作を確認せよ．
* （２）ジェネリック関数find_min関数は不完全である．最小値の表示を行うように改
良せよ．ただし、Double クラスに手を加えてはいけない．
* （３）Char （文字）クラスをComparableインターフェースの派生クラスとして実装
せよ．
* （４）mainでCharクラスの配列に対して，find_minを適用してみよ．ただし、(1)で
作ったfind_minに手を加えてはいけない．
* （５）名前と年齢を含むPersonクラスを派生クラスとして定義せよ．年齢が最小の
データが表示されるプログラムを作成せよ．ただし，(1)で作ったfind_minに手を加え
てはいけない．

```c++
#include <stdio.h>
class Comparable
{
public:
virtual void print() = 0;
virtual bool LTE(Comparable* a) = 0;   
};
class Double: public Comparable
{
private:
double val;
public:
Double(double v) {val = v;}
bool LTE(Comparable* a) {
if (val <= (static_cast<Double*>(a)->val)) return true;
else return false;
}
void print() {printf("%f¥n", val);}
};
Comparable* x[10];
void find_min()
{
for (int i = 0; i < 10; i++) {
x[i]->print();
}
}
int main()
{
for (int i = 0; i < 10; i++) {
x[i] = new Double((i-3)*(i-3)+1);
}
find_min();
}
```
