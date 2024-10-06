package chap2;
import java.util.Scanner;

public class textbook3_15 {
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
      System.out.println(max);
      System.out.println(min);
    } else if(a<b) {
      min = a;
      max = b;
      System.out.println(max);
      System.out.println(min);
    } else {
      System.out.println(a);
      System.out.println(b);
    }
  }
}
