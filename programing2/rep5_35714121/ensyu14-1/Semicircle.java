// ShapeのサブクラスかつPlane2Dの実装クラスである抽象クラスSemicircleを書く
// 前回の演習問題のプログラムを利用し変更を加える
public abstract class Semicircle extends Shape implements Plane2D{

	private int radius;

	public Semicircle(int radius){ this.radius = radius;}

	public int getRadius(){ return radius;}

	public void setRadius(int radius){ this.radius = radius;}

	@Override public String toString(){
		return "Semicircle (radius: " + radius + ")";
	} 

}


