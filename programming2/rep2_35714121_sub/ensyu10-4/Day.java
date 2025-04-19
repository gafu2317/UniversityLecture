// Dayクラスを書く
import java.util.GregorianCalendar;
public class Day {
    private int year;
    private int month;
    private int date;//教科書の通りに書いたが、dateは日付という意味なので、dayに変更した方がいいかもしれない
    private static int[][] daysInMonth = {
        {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}, // 平年
        {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}  // 閏年
    };
    public Day() {
        GregorianCalendar today = new GregorianCalendar();
        this.year = today.get(GregorianCalendar.YEAR);
        this.month = today.get(GregorianCalendar.MONTH) + 1;
        this.date = today.get(GregorianCalendar.DATE);
    }
    //yearは１以上、monthは１～１２、dateは１～その月の日数（これ以外はその日の日付が入る）
    public Day(int year, int month, int date) {
        GregorianCalendar today = new GregorianCalendar();
        if (year < 1) {
            year = today.get(GregorianCalendar.YEAR);
        }
        if (month < 1) {
            month = today.get(GregorianCalendar.MONTH) + 1;
        } else if (month > 12) {
            month = today.get(GregorianCalendar.MONTH) + 1;
        }
        if (date < 1) {
            date = today.get(GregorianCalendar.DATE);
        } else if (date > daysInMonth[isLeap(year) ? 1 : 0][month - 1]) {
            date = today.get(GregorianCalendar.DATE);
        }
        this.year = year;
        this.month = month;
        this.date = date;
    }

    //getter
    public int getYear() {
        return year;
    }
    public int getMonth() {
        return month;
    }
    public int getDate() {
        return date;
    }

    //setter
    public void setYear(int year) {
        this.year = year;
    }
    public void setMonth(int month) {
        this.month = month;
    }
    public void setDate(int date) {
        this.date = date;
    }

    //yearは閏年か
    public boolean isLeap(int year) {
        return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
    }

    //閏年か
    public boolean isLeap() {
        return isLeap(year);
    }
    
    //年始からの経過日数
    public int dayOfYear() {
        int days = date;
        for (int i = 0; i < month - 1; i++) {
            days += daysInMonth[isLeap() ? 1 : 0][i];
        }
        return days;
    }

    //年末までの残り日数
    public int leftDayOfYear() {
        return isLeap() ? 366 - dayOfYear() : 365 - dayOfYear();
    }
}
