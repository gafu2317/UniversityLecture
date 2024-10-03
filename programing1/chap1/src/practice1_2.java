import java.util.Scanner;

public class practice1_2 {
      public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    System.out.print("xの値:");
    int x = stdIn.nextInt();
    System.out.print("yの値:");
    int y = stdIn.nextInt();
    System.out.println("足し算の結果" + (x + y) + "です。");
    System.out.println("引き算の結果" + (x - y) + "です。");
    System.out.println("掛け算の結果" + (x * y) + "です。");
    System.out.println("割り算の結果" + (x / y) + "です。");
  }
}
