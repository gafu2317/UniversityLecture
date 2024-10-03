// 人間プレーヤを表すサブクラスHumanPlayerを書く
import java.util.Scanner;
public class HumanPlayer extends JankenPlayer{
    public int getHund(){
      System.out.println("じゃんけんの手を入力してください。0:グー 1:チョキ 2:パー");
      java.util.Scanner stdIn = new Scanner(System.in);
      int hund = stdIn.nextInt();
      return hund;
    }
    public int getFinger(){
      java.util.Scanner stdIn = new Scanner(System.in);
      int direction = stdIn.nextInt();
      return direction;
    }
}
