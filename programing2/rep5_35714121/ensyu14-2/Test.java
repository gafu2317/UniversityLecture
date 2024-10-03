// mainメソッドを含むクラスTestを書く．
public class Test {
    public static void main(String[] args) {
      Wearable[] w = {
        new WearableComputer("HAL"),
        new WearableRobot(Color.RED),
        new WearableRobot(Color.GREEN),
        new WearableRobot(Color.BLUE),
        new WearableRobot(ColoredWearable.YELLOW)
      };
      for(Wearable k : w){
        k.putOn();
        k.putOff();
        System.out.println();
      }
    }
}
