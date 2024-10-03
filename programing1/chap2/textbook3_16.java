package chap2;
import java.util.Scanner;

public class textbook3_16 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("整数A: ");
    int a = input.nextInt();
    System.out.print("整数B: ");
    int b = input.nextInt();
    System.out.print("整数C: ");
    int c = input.nextInt();
    if(a<=b && a<=c){
      if(b<=c){
        System.out.println(a);
        System.out.println(b);
        System.out.println(c);
      } else {
        System.out.println(a);
        System.out.println(c);
        System.out.println(b);
      }
    } else if(b<=a && b<=c){
      if(a<=c){
        System.out.println(b);
        System.out.println(a);
        System.out.println(c);
      } else {
        System.out.println(b);
        System.out.println(c);
        System.out.println(a);
      }
    } else {
      if(a<=b){
        System.out.println(c);
        System.out.println(a);
        System.out.println(b);
      } else {
        System.out.println(c);
        System.out.println(b);
        System.out.println(a);
      } 
    } 
  }
}
