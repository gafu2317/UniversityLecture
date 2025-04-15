package chap2;
import java.util.Scanner;

public class textbook3_4 {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    System.out.print("整数A: ");
    int a = scanner.nextInt();
    System.out.print("整数B: ");
    int b = scanner.nextInt();
    if(a>b) {
      System.out.println("Aのほうが大きいです。");
    } else if(a<b) {
      System.out.println("Bのほうが大きいです。");
    } else {
      System.out.println("AとBは同じ値です。");
    }
  }
}
