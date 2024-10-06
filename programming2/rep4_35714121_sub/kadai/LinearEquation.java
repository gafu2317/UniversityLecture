// サブクラスLinearEquationを書く
public class LinearEquation extends Equation {
    private double a;
    private double b;
    public LinearEquation( String name, double a, double b) {
        super(name);
        this.a = a;
        this.b = b;
    }

    public String print() {
        return  a + "x + " + b + " = 0";
    }

    public String solve() {
      return -b/a + "";
    }
}
