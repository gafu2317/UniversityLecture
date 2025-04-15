import java.util.Scanner;

public class practice1_3 {
      public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    System.out.print("三角形の底辺:");
    int a = stdIn.nextInt();
    System.out.print("三角形の高さ:");
    int b = stdIn.nextInt();
    System.out.println("三角形の面積は" + (a * b / 2) + "です。");
    System.out.println("長方形の幅:");
    int c = stdIn.nextInt();
    System.out.println("長方形の高さ:");
    int d = stdIn.nextInt();
    System.out.println("長方形の面積は" + (c * d) + "です。");
    System.out.println("台形の上底:");
    int e = stdIn.nextInt();
    System.out.println("台形の下底:");
    int f = stdIn.nextInt();
    System.out.println("台形の高さ:");
    int g = stdIn.nextInt();
    System.out.println("台形の面積は" + ((e + f) * g / 2) + "です。");
    System.out.println("円の半径:");
    int h = stdIn.nextInt();
    System.out.println("円の面積は" + (h * h * 3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067) + "です。");
  }
}
