// 自動車クラス【第１版】Carを書く
public class Car {
    private String name;// 名前
    private double x;// 現在位置X
    private double y;// 現在位置Y
    private double fuel;// 残り燃料

    // コンストラクタ
    public Car(String name,double fuel) {
        this.name = name;
        this.fuel = fuel;
        x = y = 0.0;
    }

    public double getX() {return x;}
    public double getY() {return y;}
    public double getFuel() {return fuel;}
    public void setX(double x) {this.x = x;}
    public void setY(double y) {this.y = y;}
    public void setFuel(double fuel) {this.fuel = fuel;}

    //スペックを表示
    public void putSpec() {
        System.out.println("名前:" + name);
        System.out.println("燃料:" + fuel + "リットル");
    }

    // X方向にdx、Y方向にdy移動
    public boolean move(double dx, double dy) {
        double dist = Math.sqrt(dx * dx + dy * dy);

        if (dist > fuel) {
            return false;
        } else {
            fuel -= dist;
            x += dx;
            y += dy;
            return true;
        }
    }


}
