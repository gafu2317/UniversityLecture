package chap2;
import java.util.Scanner;

public class textbook3_1 {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    System.out.print("整数値: ");
    int n = scanner.nextInt();
    if (n > 0) {
      System.out.println("その絶対値は" + n + "です。");
    } else if (n < 0) {
      System.out.println("その絶対値は" + -n + "です。");
    } else {
      System.out.println("その絶対値は" + 0 + "です。");
    }
  }
}
