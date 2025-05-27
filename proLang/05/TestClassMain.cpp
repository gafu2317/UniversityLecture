#include <stdio.h>

// TestClassの定義
class TestClass
{
private://コロンを忘れずに
  int i;
  int j;
  void method_a(){printf("func a\n");};
public:
  int k;
  int l;
  void method_b(){printf("func b %d\n",i);};
  // method_aを呼び出す新しい関数
  void call_method_a(){
      printf("method_a()を呼び出す\n");
      return method_a();
  };
};

int main() {
    // TestClassのインスタンスを作成
    TestClass tc;
    
    // publicメンバへのアクセスと値の代入
    tc.k = 10;
    tc.l = 20;
    
    // publicメンバの値を表示
    printf("k = %d, l = %d\n", tc.k, tc.l);
    
    // method_bの呼び出し
    tc.method_b();
    
    // privateメンバへのアクセス試行（エラーになります）
    // tc.i = 30; // エラー：privateメンバにはアクセスできない
    // tc.j = 40; // エラー：privateメンバにはアクセスできない
    
    // method_aの呼び出し試行（エラーになります）
    // tc.method_a(); // エラー：privateメソッドにはアクセスできない
    
    // 新しく作成したpublicメソッドを通じてmethod_aを呼び出す
    tc.call_method_a();
    
    return 0;
}