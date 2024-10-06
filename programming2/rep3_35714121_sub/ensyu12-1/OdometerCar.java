// 派生クラスOdometerCarを書く
public class OdometerCar extends Car{
    private static double totalMileage = 0.0;// 総走行距離
    // コンストラクタ
    public OdometerCar(String name, double fuel) {
        super(name, fuel);
    }
    // 総走行距離を取得
    public static double getTotalMileage() {
        return totalMileage;
    }
    @Override
    public boolean move(double dx, double dy) {
      if (super.move(dx, dy)) {
          totalMileage += Math.sqrt(dx * dx + dy * dy);
          return true;
      }
      return false;
    }
}
