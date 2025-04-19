package chap2;
import java.util.Scanner;

public class textbook3_14 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("整数A: ");
    int a = input.nextInt();
    System.out.print("整数B: ");
    int b = input.nextInt();
    int min , max;
    if(a>b) {
      min = b;
      max = a;
      System.out.println("小さいほうの値は" + min + "です。");
      System.out.println("大きいほうの値は" + max + "です。");
    } else if(a<b) {
      min = a;
      max = b;
      System.out.println("小さいほうの値は" + min + "です。");
      System.out.println("大きいほうの値は" + max + "です。");
    } else {
      System.out.println("二つの値は同じです。");
    }
  }
}
