package chap2;
import java.util.Scanner;

public class textbook3_18 {
  public static void main(String[] args) {
    Scanner input = new Scanner(System.in);
    System.out.print("月: ");
    int n = input.nextInt();
    switch (n) {
      case 1: System.out.println("冬"); break;
      case 2: System.out.println("冬"); break;
      case 3: System.out.println("春"); break;
      case 4: System.out.println("春"); break;
      case 5: System.out.println("春"); break;
      case 6: System.out.println("夏"); break;
      case 7: System.out.println("夏"); break;
      case 8: System.out.println("夏"); break;
      case 9: System.out.println("秋"); break;
      case 10: System.out.println("秋"); break;
      case 11: System.out.println("秋"); break;
      case 12: System.out.println("冬"); break;
    }
  }
}
