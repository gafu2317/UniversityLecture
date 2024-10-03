// 抽象クラスJankenPlayerを書く
public abstract class JankenPlayer {

  public abstract int getHund();

  public static String getHandName(int hand) {
    switch (hand) {
      case 0:
        return "グー";
      case 1:
        return "チョキ";
      case 2:
        return "パー";
      default:
        return "不正な値";
    }
  }
  public abstract int getFinger();

  public static String getFingerName(int direction) {
    switch (direction) {
      case 0:
        return "右";
      case 1:
        return "左";
      default:
        return "不正な値";
    }
  }
  
}