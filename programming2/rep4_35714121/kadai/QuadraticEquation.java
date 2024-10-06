// サブクラスQuadraticEquationを書く
public class QuadraticEquation extends Equation {
    private double a;
    private double b;
    private double c;

    public QuadraticEquation( String name, double a, double b, double c) {
        super(name);
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public String print() {
        return a + "x^2 + " + b + "x + " + c + " = 0";
    }

    public String solve() {
        double d = b * b - 4 * a * c;
        if (d < 0) {
            return (-b) / (2 * a) + " ±  " + Math.sqrt(-d) / (2 * a)+ "i";
        } else if (d == 0) {
            return -b / (2 * a) + "";
        } else {
            return (-b + Math.sqrt(d)) / (2 * a) + "";
        }
    }
}
