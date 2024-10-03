// mainメソッドを含むPrime1クラスを書く
import java.io.*;

public class Prime1 {
  static final int MAX = 1000;
    public static void main(String[] args) {
      if (args.length != 1) {
        System.out.println("使用法：java Prime1 作成ファイル");
        System.out.println("例：java Prime1 prime.txt");
        System.exit(0);
      }
      String filename = args[0];
      try {
        PrintWriter writer = new PrintWriter(new BufferedWriter(new FileWriter(filename)));
        writePrime(writer);
        writer.close();
      } catch (IOException e) {
        System.out.println(e);
      }
    }
  public static void writePrime(PrintWriter writer) {
    boolean[] data = new boolean[MAX];
    for (int n = 0; n < MAX; n++) {
      data[n] = true;
    }
    data[0] = false;
    data[1] = false;
    for (int n = 0; n < MAX; n++) {
      if (data[n]) {
        writer.println(n);
        for (int i = 2; i * n < MAX; i ++) {
          data[i * n] = false;
        }
      }
    }
  }
}
