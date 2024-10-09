import java.util.Scanner;

public class textbook2_4 {
  
  public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    System.out.print("整数値:");
    int x = stdIn.nextInt();
    System.out.print("10を加えた値は" + (x + 10) + "です。");
    System.out.print("10を減じた値は" + (x - 10) + "です。");
  }
}
