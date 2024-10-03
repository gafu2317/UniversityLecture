// mainメソッドを含むPeriodTesterクラスを書く
public class PeriodTester {
    public static void main(String[] args) {
        Period period = new Period(new Day(2024, 4, 1), new Day(2024, 4, 30));
        System.out.println("今年も4月は " + period.start() + "から" + period.end() + "までです。");
    }
}
