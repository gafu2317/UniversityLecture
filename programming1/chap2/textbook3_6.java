package chap2;
import java.util.Scanner;

public class textbook3_6 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("整数値: ");
    int n = input.nextInt();
    if(n>0){
      if(n%10==0){
        System.out.println("その値は10の倍数です。");
      } else {
        System.out.println("その値は10の倍数ではありません。");
      }
    } else {
      System.out.println("正でない値が入力されました。");
    }
  }
}
