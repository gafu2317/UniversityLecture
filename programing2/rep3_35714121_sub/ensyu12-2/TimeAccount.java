// 定期預金付き銀行口座クラス【第1版】TimeAccountを書く
public class TimeAccount extends Account{
    private long timeBalance; // 定期預金残高

    // コンストラクタ
    public TimeAccount(String n, String num, long z, long timeBalance) {
        super(n, num, z);
        this.timeBalance = timeBalance;
    }

    // 定期預金残高を調べる
    public long getTimeBalance() {
        return timeBalance;
    }

    // 定期預金を解約して全額を普通預金に移す
    public void cancel() {
        deposit(timeBalance);
        timeBalance = 0;
    }

    //普通預金と定期預金残高の合計を比較する
    public static int compBalance(Account a, Account b) {
        long totalA = a.getBalance();
        long totalB = b.getBalance();
        if (a instanceof TimeAccount) {
            totalA += ((TimeAccount) a).getTimeBalance();
        }
        if (b instanceof TimeAccount) {
            totalB += ((TimeAccount) b).getTimeBalance();
        }

        if (totalA > totalB) {
            return 1;
        } else if (totalA == totalB) {
            return 0;
        } else {
            return -1;
        }
    }
}
