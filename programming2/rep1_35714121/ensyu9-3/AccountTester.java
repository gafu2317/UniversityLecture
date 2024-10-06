// mainメソッドを含むAccountTesterクラスを書く
public class AccountTester {
    public static void main(String[] args) {
        //足立君の口座
        Account adachi = new Account("足立幸一", "123456", 1000, new Day(2024, 4, 12));
        //仲田君の口座
        Account nakata = new Account("仲田真二", "654321", 200, new Day(2024, 4, 12));

        adachi.withdraw(200); //足立君が200円おろす
        nakata.deposit(100); //仲田君が100円預ける

        System.out.println("足立君の口座情報 "+ adachi.toString());
        
        System.out.println("仲田君の口座情報 "+ nakata.toString());

    }
}