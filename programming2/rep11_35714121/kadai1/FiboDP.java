// mainメソッドを含むFiboDPクラス(動的計画法)を書く
public class FiboDP {
  public static void main(String[] args) {
    int n = Integer.parseInt(args[0]);

    long startTime = System.currentTimeMillis();
    int resultDP = fiboDP(n);
    long endTime = System.currentTimeMillis();

    System.out.println("FiboDP(" + n + ") = " + resultDP);
    System.out.println("処理時間: " + (endTime - startTime) + "ミリ秒");
  }

  public static int fiboDP(int n) {
    if (n <= 2) {
      return 1;
    }
    int[] fibo = new int[n + 1];
    fibo[1] = 1;
    fibo[2] = 1;
    for (int i = 3; i <= n; i++) {
      fibo[i] = fibo[i - 1] + fibo[i - 2];
    }
    return fibo[n];
  }
}
