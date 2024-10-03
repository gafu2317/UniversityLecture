public class DayTester {
    public static void main(String[] args) {
      System.out.println("Dayクラスのテストを開始します");

      System.out.println("引数なしのコンストラクタを呼び出します");
      Day day1 = new Day();
      System.out.println("year = " + day1.getYear()); 
      System.out.println("month = " + day1.getMonth());
      System.out.println("date = " + day1.getDate());
      System.out.println("閏年か = " + day1.isLeap());
      System.out.println("年始からの経過日数 = " + day1.dayOfYear());
      System.out.println("年始からの残り日数 = " + day1.leftDayOfYear());

      System.out.println("引数ありのコンストラクタを呼び出します");
      System.out.println("入れる値は2024, 4, 20です");
      Day day2 = new Day(2024, 4, 20);
      System.out.println("year = " + day2.getYear());
      System.out.println("month = " + day2.getMonth());
      System.out.println("date = " + day2.getDate());
      System.out.println("閏年か = " + day2.isLeap());
      System.out.println("年始からの経過日数 = " + day2.dayOfYear());
      System.out.println("年始からの残り日数 = " + day2.leftDayOfYear());

      System.out.println("引数ありのコンストラクタに不正な値を入力して呼び出します");
      System.out.println("代わりに現在の日付が入るはずです");
      System.out.println("入れる値は-2024, 13, 32です");
      Day day3 = new Day(-2024, 13, 32);
      System.out.println("year = " + day3.getYear());
      System.out.println("month = " + day3.getMonth());
      System.out.println("date = " + day3.getDate());
      System.out.println("閏年か = " + day3.isLeap());
      System.out.println("年始からの経過日数 = " + day3.dayOfYear());
      System.out.println("年始からの残り日数 = " + day3.leftDayOfYear());
      System.out.println("setterを使って値を変更します");
      System.out.println("year = 2024, month = 4, date = 20に変更します");
      day3.setYear(2024);
      day3.setMonth(4);
      day3.setDate(20);
      System.out.println("year = " + day3.getYear());
      System.out.println("month = " + day3.getMonth());
      System.out.println("date = " + day3.getDate());
      System.out.println("閏年か = " + day3.isLeap());
      System.out.println("年始からの経過日数 = " + day3.dayOfYear());
      System.out.println("年始からの残り日数 = " + day3.leftDayOfYear());
      
    }
}