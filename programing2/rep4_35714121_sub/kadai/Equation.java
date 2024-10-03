// 抽象クラスEquationを書く
public abstract class Equation {
  protected String name = "";
  
  public Equation(String name) {
    this.name = name;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }

  public abstract String print();

  public abstract String solve();
}