// mainメソッドを含むFiboRecクラス(再帰)を書く
public class FiboRec {
  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);

    long startTime = System.currentTimeMillis();
    int resultRec = fiboRec(n);
    long endTime = System.currentTimeMillis();
    System.out.println("FiboRec(" + n + ") = " + resultRec);
    System.out.println("処理時間: " + (endTime - startTime) + "ミリ秒");
  }

  public static int fiboRec(int n) {
    if (n <= 2) {
      return 1;
    } else {
      return fiboRec(n - 1) + fiboRec(n - 2);
    }
  }
}
