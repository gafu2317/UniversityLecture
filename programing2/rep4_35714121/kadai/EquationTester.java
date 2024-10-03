// mainメソッドを含むEquationTesterクラスを書く
public class EquationTester {
  public static void main(String[] args) {
    Equation[] equations = new Equation[3];
    equations[0] = new LinearEquation("一次方程式", 1, 2);
    equations[1] = new QuadraticEquation("二次方程式", 1, 2, 3);
    equations[2] = new TrigonometricEquation("三角方程式", 1);
    for (Equation equation : equations) {
      System.out.println(equation.getName());
      System.out.println(equation.print());
      System.out.println("解：" + equation.solve());
    }
  }
}
