import java.util.Scanner;

public class textbook2_6 {
      public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    System.out.print("三角形の面積を求めます。");
    System.out.print("底辺:");
    int x = stdIn.nextInt();
    System.out.print("高さ:");
    int y = stdIn.nextInt();
    System.out.println("面積は" + (x * y) / 2 + "です。");
  }
}