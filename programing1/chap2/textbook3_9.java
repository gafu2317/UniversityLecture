package chap2;
import java.util.Scanner;

public class textbook3_9 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("実数A: ");
    double a = input.nextDouble(); 
    System.out.print("実数B: ");
    double b = input.nextDouble(); 
    if (a > b) {
      System.out.println("Aのほうが大きいです。");
    } else if (a < b) {
      System.out.println("Bのほうが大きいです。");
    } else {
      System.out.println("AとBは同じ値です。");
    }
  }
}

