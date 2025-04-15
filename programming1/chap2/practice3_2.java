package chap2;
import java.util.Scanner;

public class practice3_2 {
  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    System.out.print("年: ");
    int n = scanner.nextInt();
    if(n%4==0){
      if(n%100==0){
        if(n%400==0){
          System.out.println("閏年です。");
        } else {
          System.out.println("閏年ではありません。");
        }
      } else {
        System.out.println("閏年です。");
      }
    } else {
      System.out.println("閏年ではありません。");
    }
  }
}
