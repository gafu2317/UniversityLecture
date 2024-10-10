package chap2;
import java.util.Scanner;

public class textbook3_12 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("整数A: ");
    int a = input.nextInt();
    System.out.print("整数B: ");
    int b = input.nextInt();
    System.out.print("整数C: ");
    int c = input.nextInt();
    int d = a<=b ? a : b;
    int e = d<=c ? d : c;
    System.out.println("最小値は" + e + "です。");
  }
}
