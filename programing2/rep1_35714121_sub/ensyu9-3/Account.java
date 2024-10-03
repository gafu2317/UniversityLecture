// Accountクラスを書く
public class Account {
  private String name;// 口座名義
  private String no;// 口座番号
  private long balance;// 預金残高
  private Day openDay;// 口座開設日

  // コンストラクタ
  public Account(String n, String num, long z , Day d) {
    name = n;
    no = num;
    balance = z;
    openDay = new Day(d);
  }

  //ゲッタ
  // 口座名義を調べる
  public String getName() {
    return name;
  }
  // 口座番号を調べる
  public String getNo() {
    return no;
  }
  // 預金残高を調べる
  public long getBalance() {
    return balance;
  }
  // 口座開設日を調べる
  public Day getOpenDay() {
    return new Day(openDay);
  }

  //セッタ
  public void setName(String n) {
    name = n;
  }
  public void setNo(String n) {
    no = n;
  }
  public void setBalance(long z) {
    balance = z;
  }
  public void setOpenDay(Day d) {
    openDay = new Day(d);
  }

  // k円預ける
  public void deposit(long k) {
    balance += k;
  }
  // k円おろす
  public void withdraw(long k) {
    balance -= k;
  }
  // toString メソッド
  public String toString() {
    return "口座名義:" + name + " 口座番号:" + no + " 預金残高:" + balance + " 口座開設日:" + openDay.toString() + " です。";
  }
}