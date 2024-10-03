// Triangleクラスを書く
public class Triangle {
    // フィールド
    private double a;
    private double b;
    private double c;
    
    // コンストラクタ
    //三角形を生成するコンストラクタ
    public Triangle(double a, double b, double c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }
    //aとbがl, cがmの二等辺三角形を生成するコンストラクタ
    public Triangle(double l, double m) {
        this(l, l, m);
    }
    //aとbとcがnの正三角形を生成するコンストラクタ
    public Triangle(double n) {
        this(n, n, n);
    }

    // ゲッターとセッター
    public double getA() { return a; }
    public double getB() { return b; }
    public double getC() { return c; }
    public void setA(double a) { this.a = a; }
    public void setB(double b) { this.b = b; }
    public void setC(double c) { this.c = c; }

    // メソッド
    // 二等辺三角形の判定
    public boolean isIsosceles() {
        return a == b || a == c || b == c;
    }

    // 正三角形の判定
    public boolean isEquilateral() {
        return a == b && b == c;
    }

    //三角形の合同の判定
    public boolean isCongruent(Triangle t) {
        return (a == t.getA() && b == t.getB() && c == t.getC()) || (a == t.getA() && b == t.getC() && c == t.getB()) || (a == t.getB() && b == t.getC() && c == t.getA()) || (a == t.getB() && b == t.getA() && c == t.getC()) || (a == t.getC() && b == t.getA() && c == t.getB()) || (a == t.getC() && b == t.getB() && c == t.getA());
    }
    public String toString() {
        return "a = " + a + ", b = " + b + ", c = " + c;
    }
}
