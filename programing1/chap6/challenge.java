package chap6;

public class challenge {
    public static void main(String[] args) {
        // 1から9までの数字を操作するための配列を用意
        char[] operations = {'+', '-', '*', ' '};

        // 1から9までの数字の間に演算子を入れる
        for (int i = 0; i < operations.length; i++) {
            for (int j = 0; j < operations.length; j++) {
                for (int k = 0; k < operations.length; k++) {
                    for (int l = 0; l < operations.length; l++) {
                        for (int m = 0; m < operations.length; m++) {
                            for (int n = 0; n < operations.length; n++) {
                                for (int o = 0; o < operations.length; o++) {
                                  for (int p = 0; p < operations.length; p++) {
                                    String formula = "1" + operations[i] + "2" + operations[j] + "3" +
                                            operations[k] + "4" + operations[l] + "5" + operations[m] +
                                            "6" + operations[n] + "7" + operations[o] + "8" + operations[p] + "9";
                                    formula = formula.replaceAll(" ", "");//空白を削除
                                    if (eval(formula) == 100) {//式を計算して100になるかどうか
                                        System.out.println(formula + " = 100");//100になったら出力
                                    }
                                  }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // 文字列としての式を評価して結果を返すメソッド
    public static int eval(final String str) {
        return new Object() {
            int pos = -1, ch;//posは文字列の位置、chは現在の文字

            void nextChar() {
                ch = (++pos < str.length()) ? str.charAt(pos) : -1;//posが文字列の長さより小さいときは次の文字を読み込む、そうでないときは-1を代入
            }

            boolean eat(int charToEat) {//引数の文字と現在の文字が一致するかどうか
                while (ch == ' ') nextChar();//空白を読み飛ばす
                if (ch == charToEat) {//引数の文字と現在の文字が一致するとき
                    nextChar();//次の文字を読み込む
                    return true;
                }
                return false;
            }

            int parse() {//式を評価する
                nextChar();//最初の文字を読み込む
                int x = parseExpression();
                if (pos < str.length()) throw new RuntimeException("Unexpected: " + (char) ch);//文字列の最後まで読み込んだかどうか
                return x;
            }

            // 加算と減算の処理
            int parseExpression() {
                int x = parseTerm();
                for (; ; ) {//無限ループ
                    if (eat('+')) x += parseTerm(); // 加算
                    else if (eat('-')) x -= parseTerm(); // 減算
                    else return x;
                }
            }

            // 乗算の処理
            int parseTerm() {
                int x = parseFactor();//parseFactor()を呼び出す
                for (; ; ) {//無限ループ
                    if (eat('*')) x *= parseFactor(); // 乗算
                    else return x;
                }
            }

            // 数値の処理
            int parseFactor() {
                int x;
                int startPos = this.pos;//数字の開始位置
                if (eat('+')) return parseFactor(); // 単項プラスは無視する
                if (eat('-')) return -parseFactor(); // 単項マイナスは数値を反転

                if (ch >= '0' && ch <= '9') { // 数字を読む
                    while (ch >= '0' && ch <= '9') nextChar();//数字が続く限り読み込む
                    x = Integer.parseInt(str.substring(startPos, this.pos));//数字の開始位置から現在の位置までをint型に変換
                } else {
                    throw new RuntimeException("Unexpected: " + (char) ch);//数字以外が来たらエラー
                }

                return x;
            }
        }.parse();//parse()を呼び出す
    }
}
