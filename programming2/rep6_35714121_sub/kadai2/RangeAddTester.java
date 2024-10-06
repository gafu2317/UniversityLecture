// mainメソッドを含むRangeAddTesterクラスを書く
import java.util.Scanner;
public class RangeAddTester {
    public static void main(String[] args) {
        Scanner stdIn = new Scanner(System.in);
        System.out.println("a: "); int a = stdIn.nextInt();
        System.out.println("b: "); int b = stdIn.nextInt();
        try {
            System.out.println("結果は" + RangeAdd.add(a, b) + "です");
        } catch (NotNaturalNumber e) {
            System.out.println("エラーです" + e.getMessage());
        }
    }
}
