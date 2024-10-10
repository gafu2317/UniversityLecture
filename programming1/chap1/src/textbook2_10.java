import java.util.Scanner;

public class textbook2_10 {
  public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    System.out.print("姓:");
    String x = stdIn.next();
    System.out.print("名:");
    String y = stdIn.next();
    System.out.println("こんにちは" + x + y + "さん。");
  }
}
//自分の実行環境(ノートパソコン)では日本語で入力するとエンターを押すときに空白行が挿入されるので、エラーが出る。