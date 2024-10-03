// コンピュータプレーヤを表すサブクラスComputerPlayerを書く
public class ComputerPlayer extends JankenPlayer{
    public int getHund(){
      int hund  = (int)(Math.random()*3);
      return hund;
    }
    public int getFinger(){
      int direction = (int)(Math.random()*2);
      return direction;
    }
}