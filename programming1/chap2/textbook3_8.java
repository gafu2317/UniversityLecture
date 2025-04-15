package chap2;
import java.util.Scanner;

public class textbook3_8 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("整数値: ");
    int n = input.nextInt();
    if(n>0){ 
      if(n<60){
        System.out.println("不可");
      } else if(n<70){
        System.out.println("可");
      } else if(n<80){
        System.out.println("良");
      } else if(n<=100){
        System.out.println("優");
      } else {
        System.out.println("範囲外の値です。");
      }
    } else {
      System.out.println("正でない値が入力されました。");
    }
  }
}
