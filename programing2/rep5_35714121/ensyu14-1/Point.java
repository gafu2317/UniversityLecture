// サブクラスPointを書く
public class Point extends Shape{
    public Point(){
    }
    @Override public String toString(){
        return "Point";
    }
    @Override public void draw(){
        System.out.println("+");
    }
}
