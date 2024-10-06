// Dayクラスを書く
public class Day {
  private int year = 1; // 年
  private int month = 1; // 月
  private int date = 1; // 日
   //--- コンストラクタ ---//
  public Day() { }  
  public Day(int year) { this.year = year; }
  public Day(int year, int month) { this(year); this.month = month; }
  public Day(int year, int month, int date) { this(year, month); this.date = date; }
  public Day(Day d) { this(d.year, d.month, d.date); }

  //--- 年・月・日を取得 ---//
  public int getYear() { return year; } // 年を取得
  public int getMonth() { return month; } // 月を取得
  public int getDate() { return date; } // 日を取得
  
  public String toString() { // 日付を文字としてを返す
    return String.format("%04d年%02d月%02d日", year, month, date);
  }
}