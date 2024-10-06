// IsoscelesTriangleクラスのサブクラスEquilateralTriangleクラスを書く(???を適切に直す)

public class EquilateralTriangle extends IsoscelesTriangle{

  private double all;

  public EquilateralTriangle(double a){
    super(a, a);
    all = a;
  }  

  public String toString(){
    return super.toString() + " 正三角形: 全ての辺=" + all;
  }

  @Override
  public boolean set(double a, double b , double c){
    if(a == b && b == c && super.set(a, b, c)){
      all = a; return true;
    }
    return false ;
  }

}
