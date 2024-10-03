// 【演習問題2で追加】Shapeのサブクラスかつ抽象クラスSemicircleを書く

public abstract class Semicircle extends Shape{

	private int radius;

	public Semicircle(int radius){ this.radius = radius;}

	public int getRadius(){ return radius;}

	public void setRadius(int radius){ this.radius = radius;}

	@Override public String toString(){
		return "Semicircle (radius: " + radius + ")";
	} 

}

