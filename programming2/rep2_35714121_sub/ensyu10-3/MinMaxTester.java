// mainメソッドを含むMinMaxTesterクラスを書
public class MinMaxTester {
    public static void main(String[] args) {
        int a = 1;
        int b = 2;
        int c = 3;
        int[] d = {4, 5, 6};
        System.out.println("a = " + a + ", b = " + b + ", c = " + c + ", d = {" + d[0] + ", " + d[1] + ", " + d[2] + "}");
        System.out.println("aとbの最小値は" + MinMax.min(a, b));
        System.out.println("aとbとcの最小値は" + MinMax.min(a, b, c));
        System.out.println("配列dの最小値は" + MinMax.min(d));
        System.out.println("aとbの最大値は" + MinMax.max(a, b));
        System.out.println("aとbとcの最大値は" + MinMax.max(a, b, c));
        System.out.println("配列dの最大値は" + MinMax.max(d));
    }
}
