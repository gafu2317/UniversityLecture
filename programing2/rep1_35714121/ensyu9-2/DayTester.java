// mainメソッドを含むDayTesterクラスを書く
class DayTester {
    public static void main(String[] args) {
        // デフォルトコンストラクタ
        Day defaultDay = new Day();
        System.out.println("デフォルト: " + defaultDay.getYear() + "/" + defaultDay.getMonth() + "/" + defaultDay.getDate());

        System.out.println("指定する年月日は2024年4月12日です。");

        // 年を指定するコンストラクタ
        Day yearOnlyDay = new Day(2024);
        System.out.println("年だけを指定: " + yearOnlyDay.getYear() + "/" + yearOnlyDay.getMonth() + "/" + yearOnlyDay.getDate());

        // 年と月を指定するコンストラクタ
        Day yearAndMonthDay = new Day(2024, 4);
        System.out.println("年と月だけを指定: " + yearAndMonthDay.getYear() + "/" + yearAndMonthDay.getMonth() + "/" + yearAndMonthDay.getDate());

        // 年、月、日を指定するコンストラクタ
        Day fullDateDay = new Day(2024, 4, 12);
        System.out.println("年、月、日全てを指定: " + fullDateDay.getYear() + "/" + fullDateDay.getMonth() + "/" + fullDateDay.getDate());

        // Dayオブジェクトをコピーするコンストラクタ
        Day copiedDay = new Day(fullDateDay);
        System.out.println("Dayオブジェクトをコピー: " + copiedDay.getYear() + "/" + copiedDay.getMonth() + "/" + copiedDay.getDate());
    }
}
