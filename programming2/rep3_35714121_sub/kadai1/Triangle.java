// Triangleクラスを書く(???を適切に直す)
public class Triangle{

  private double a, b, c; // 3辺の長さ

  public Triangle(double a, double b, double c){
      this.a = a;
      this.b = b;
      this.c = c;
  }

  public String toString() {
      return "三角形 a=" + a + " b=" + b + " c=" + c;
  }

  public boolean set(double a, double b, double c){
    if(isTriangle(a, b, c)){
      this.a = a;
      this.b = b;
      this.c = c;
      return true;
    }
    return false;
  }

  public boolean isTriangle(double a, double b, double c){//三角形が成立するか判定するメソッド ???を適切に直すだけではTriangleクラスでは，2辺の長さの合計が他の1辺の長さより大きいか確認という部分をうまく実装できなかったため，このメソッドを追加しました．
    if(a + b > c && b + c > a && c + a > b){
      return true;
    }
    return false;
  }



} 

