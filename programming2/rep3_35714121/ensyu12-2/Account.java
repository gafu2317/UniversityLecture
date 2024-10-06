// 銀行口座クラス【第2版】Accountを書く
public class Account {
    private String name; // 口座名義
    private String no; // 口座番号
    private long balance; // 預金残高

    // コンストラクタ
    public Account(String n, String num, long z) {
        name = n; // 口座名義
        no = num; // 口座番号
        balance = z; // 預金残高
    }

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

    // k円預ける
    public void deposit(long k) {
        balance += k;
    }

    // k円おろす
    public void withdraw(long k) {
        balance -= k;
    }
}
