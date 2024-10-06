// クラスWearableRobotを書く．

public class WearableRobot implements ColoredWearable {
    private int color;

    public WearableRobot(int color) {
        changeColor(color);
    }
    @Override public void changeColor (int color) {
        this.color = color;
    }

    @Override public String toString(){
      switch(color){
        case RED:
          return "赤ロボット";
        case GREEN:
          return "緑ロボット";
        case BLUE:
          return "青ロボット";
        case YELLOW:
          return "黄ロボット";
      }
      return "ロボット";
    }

    @Override public void putOn() {
        System.out.println(toString() + "装着!!");
    }
    
    @Override public void putOff() {
        System.out.println(toString() + "解除!!");
    }

}