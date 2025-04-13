package chap2;
import java.util.Random;

public class textbook3_17 {
  public static void main(String[] args) {
    Random rand = new Random();
    int n = rand.nextInt(3);
    switch (n) {
      case 0:
        System.out.println("グー");
        break; 
      case 1:
        System.out.println("チョキ");
        break;
      case 2:
        System.out.println("パー");
        break;
    }
  }
}
