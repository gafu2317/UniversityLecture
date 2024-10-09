package chap5;
//五桁かける五桁の積で十桁になるものを求める（ただし左辺と右辺は０～９を一回ずつ使う）
public class challenge {
  public static void main(String[] args) {
    int count = 0;
    for (long i = 9876543210L; i > 1023456789L && count<10; i--) {
      if (hasUniqueDigits(i)) {//十桁の数字がすべて固有のとき
        if ((i/10000)%10!=0) {// 五桁目が0でないとき
          int a = (int) (i / 100000);//前五桁（十桁を二分割している）
          int b = (int) (i % 100000);//後ろ五桁
          long c = a * b;
          if (c > 1000000000) {//積が十桁になるかどうか
            if (hasUniqueDigits(c)) {//積が固有の数字かどうか
              System.out.println(a + "×" + b + "=" + c);
              count++;
            }
          }
        } 
      }
    }
  }
    public static boolean hasUniqueDigits(long num) {//十桁の数字がすべて固有かどうかを判定する
        boolean[] digits = new boolean[10]; // 0~9の配列
        while (num > 0) {
            int digit = (int) (num % 10); // 一番下の桁を取り出す
            if (digits[digit]) { // 既に使用されているか
                return false; // 使用されていたらfalse
            }
            digits[digit] = true; // 使用されていなかったらtrueにする
            num /= 10;
        }
        return true; // 全ての桁が固有だったらtrue
    }
  }
