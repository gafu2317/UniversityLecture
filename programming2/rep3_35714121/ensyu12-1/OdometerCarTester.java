// mainメソッドを含むOdometerCarTesterクラスを書く
class OdometerCarTester {
    public static void main(String[] args) {
      System.out.println("リッター1キロのcar1という車に100Lの燃料を入れる");
      OdometerCar myCar = new OdometerCar("car1", 100.0);
      System.out.println("スペックを表示");
      myCar.putSpec();
      System.out.println("x方向に10, y方向に10移動");
      myCar.move(10.0, 10.0);
      System.out.println("燃料残量：" + myCar.getFuel() + "リットル");
      System.out.println("走行距離：" + OdometerCar.getTotalMileage() + "km");
    }
}
