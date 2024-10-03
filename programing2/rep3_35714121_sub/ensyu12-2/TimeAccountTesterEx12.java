// mainメソッドを含むTimeAccountTesterEx12クラスを書く
class TimeAccountTesterEx12 {
    public static void main(String[] args) {
        System.out.println("田太郎、鈴木次郎、田中花子、佐藤和夫の銀行口座クラスと定期預金付き銀行口座クラスのインスタンスを生成します。");
        System.out.println("");
        Account yamada = new Account("山田太郎", "111111", 1000);
        Account suzuki = new Account("鈴木次郎", "222222", 200);
        TimeAccount tanaka = new TimeAccount("田中花子", "333333", 300, 400);
        TimeAccount sato = new TimeAccount("佐藤和夫", "444444", 500, 600);
        System.out.println("山田と鈴木の預金残高を比較します。");
        switch(TimeAccount.compBalance(yamada, suzuki)){
          case 1: System.out.println("山田の方が預金残高が多いです。"); break;
          case 0: System.out.println("山田と鈴木の預金残高は同じです。"); break;
          case -1: System.out.println("鈴木の方が預金残高が多いです。"); break;
        }
        System.out.println("");
        System.out.println("山田と田中の預金残高を比較します。");
        switch(TimeAccount.compBalance(yamada, tanaka)){
          case 1: System.out.println("山田の方が預金残高が多いです。"); break;
          case 0: System.out.println("山田と田中の預金残高は同じです。"); break;
          case -1: System.out.println("田中の方が預金残高が多いです。"); break;
        }
        System.out.println("");
        System.out.println("田中と佐藤の預金残高を比較します。");
        switch(TimeAccount.compBalance(tanaka, sato)){
          case 1: System.out.println("田中の方が預金残高が多いです。"); break;
          case 0: System.out.println("田中と佐藤の預金残高は同じです。"); break;
          case -1: System.out.println("佐藤の方が預金残高が多いです。"); break;
        }
    }
}