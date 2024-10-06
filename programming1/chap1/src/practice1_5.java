import java.util.Scanner;

public class practice1_5 {
      public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    System.out.print("秒:");
    int x = stdIn.nextInt();
    int a = x / 3600;
    int b = x % 3600;
    int c = b / 60;
    int d = b % 60;
    System.out.println(x + "秒は" + a + "時間" + c + "分" + d + "秒です。");
  }
}

