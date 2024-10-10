import java.util.Random;

public class textbook2_9 {
    public static void main(String[] args) {
    Random rand = new Random();
    double x = rand.nextDouble();
    System.out.println("0.0以上1.0未満の実数値:" + x);
    double y = rand.nextDouble() * 10.0;
    System.out.println("0.0以上10.0未満の実数値:" + y);
    double z = rand.nextDouble() * 2.0 - 1.0;
    System.out.println("-1.0以上1.0未満の実数値:" + z);
  }
}
