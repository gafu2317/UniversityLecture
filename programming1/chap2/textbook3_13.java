package chap2;
import java.util.Scanner;

public class textbook3_13 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("整数A: ");
    int a = input.nextInt();
    System.out.print("整数B: ");
    int b = input.nextInt();
    System.out.print("整数C: ");
    int c = input.nextInt();
    if(b<=a && a<=c || c<=a && a<=b) {
      System.out.println("中央値は" + a + "です。");
    } else if(a<=b && b<=c || c<=b && b<=a) {
      System.out.println("中央値は" + b + "です。");
    } else {
      System.out.println("中央値は" + c + "です。");
    }
  }
}
