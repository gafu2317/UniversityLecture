#include <stdio.h>

int main() {
    // スタックの実装（最大20レベルの再帰をサポート）
    int stack[20];  // 引数のスタック
    int result[20]; // 結果のスタック
    int sp = 0;     // スタックポインタ
    
    int n, ans;
    
    // ユーザー入力
    printf("階乗を計算する数値を入力してください: ");
    scanf("%d", &n);
    
    // エラー処理
    if (n < 0) {
        printf("エラー: 負の数の階乗は定義されていません。\n");
        return 1;
    }
    
    // 初期値をスタックにプッシュ
    stack[sp] = n;
    sp++;
    
    // 疑似関数の開始点
factorial_start:
    // スタックから値を取得（ポップはしない）
    n = stack[sp-1];
    
    // 基底ケース: 0! = 1
    if (n <= 1) {
        result[sp-1] = 1;
        goto factorial_end;
    }
    
    // 再帰ケース: n! = n * (n-1)!
    // (n-1)の値をスタックにプッシュ
    stack[sp] = n - 1;
    sp++;
    
    // 「再帰呼び出し」
    goto factorial_start;
    
factorial_end:
    // スタックポインタを減らす（「関数から戻る」）
    sp--;
    
    // スタックが空でない場合（まだ「呼び出し元」がある）
    if (sp > 0) {
        // 現在の結果を取得
        int current_result = result[sp];
        
        // 呼び出し元の引数を取得
        int caller_arg = stack[sp-1];
        
        // 呼び出し元の結果を計算（n * (n-1)!）
        result[sp-1] = caller_arg * current_result;
        
        // 呼び出し元の「関数」に戻る
        goto factorial_end;
    } else {
        // すべての「関数呼び出し」が完了
        ans = result[0];
        printf("%dの階乗は %d です。\n", stack[0], ans);
    }
    
    return 0;
}