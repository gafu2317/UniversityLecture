import java.util.Scanner;

public class textbook2_5 {
    public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    System.out.print("xの値:");
    int x = stdIn.nextInt();
    System.out.print("yの値:");
    int y = stdIn.nextInt();
    System.out.println("合計は" + (x + y) + "です。");
    System.out.println("平均は" + (x + y) / 2 + "です。");
  }
}
