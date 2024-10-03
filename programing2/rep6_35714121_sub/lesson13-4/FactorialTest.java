// mainメソッドを含むFactorialTestクラスを書く
public class FactorialTest {
    public static void main(String[] args) {
      System.out.println(factorial(10));
    }
    static int factorial(int n) {
        if (n < 0) {
            throw new IllegalArgumentException("負の値は引数にできません");
        }
        if (n == 0) {
            return 1;
        }
        return n * factorial(n - 1);
    }
}