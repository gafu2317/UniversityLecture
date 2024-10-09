package chap2;
import java.util.Scanner;

public class textbook3_10 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("整数A: ");
    int a = input.nextInt();
    System.out.print("整数B: ");
    int b = input.nextInt();
    int c = a - b;
      if(c>=0){
        System.out.println("それらの差は" + c + "です。");
      } else {
        System.out.println("それらの差は" + -c + "です。");
      }
  }
}
