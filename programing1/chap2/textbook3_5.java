package chap2;
import java.util.Scanner;

public class textbook3_5 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("正の整数: ");
    int n = input.nextInt();
    if(n>0){
      if(n%5==0){
        System.out.println("その値は5で割り切れます。");
      } else {
        System.out.println("その値は5で割り切れません。");
      }
    } else {
      System.out.println("正でない値が入力されました。");
    }
  }
}
