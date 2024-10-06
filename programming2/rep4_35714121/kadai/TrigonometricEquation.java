// サブクラスTrigonometricEquationを書く
public class TrigonometricEquation extends Equation{
  private double a;

  public TrigonometricEquation(String name, double a) {
    super(name);
    this.a = a;
  }

  public String print() {
    return "sin(x) + " + a + " = 0";
  }

  public String solve() {
    return Math.asin(-a) + "";
  }
}