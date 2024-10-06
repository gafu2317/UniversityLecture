// TriangleクラスのサブクラスIsoscelesTriangleクラスを書く(???を適切に直す)

public class IsoscelesTriangle extends Triangle{

  private double side, bottom; // 斜辺(等しい長さの2辺), 底辺(残りの辺) 

  public IsoscelesTriangle(double s, double b){
    super(s, s, b);
    side = s;
    bottom = b;
  }  

  public String toString(){
    return super.toString() + " 二等辺三角形: 斜辺=" + side + " 底辺=" + bottom;
  }

  @Override
  public boolean set(double a, double b , double c){
    if(a == b && super.set(a, b, c)){
        side = a; bottom = c; return true;
    }else if(b == c && super.isTriangle(a, b, c)){
        side = b; bottom = a; return true;
    }else if(c == a && super.isTriangle(a, b, c)){
        side = c; bottom = b; return true;
    }
    return false;
  }

}
