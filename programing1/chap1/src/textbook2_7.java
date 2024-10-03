import java .util.Random;

public class textbook2_7 {
  public static void main(String[] args) {
    Random rand = new Random();
    int x = rand.nextInt(9) + 1;
    System.out.println("一桁の正の整数値:" + x);
    int y = rand.nextInt(9) - 9;
    System.out.println("一桁の負の整数値:" + y);
    int z = rand.nextInt(90) + 10;
    System.out.println("二桁の正の整数値:" + z);
  }
}