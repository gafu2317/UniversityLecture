// SemicircleのサブクラスRightSemicircleを書く
// 前回の演習問題のプログラムを利用し変更を加える
public class RightSemicircle extends Semicircle{

	public RightSemicircle(int radius){ super(radius); }

	@Override public String toString(){
		return "RightSemicircle (radius: " + getRadius() + ")";
	}

	@Override public void draw() {
		int r = getRadius();
		for(int y = -r; y < r ; y++){
			for(int x = 0; x < r ; x++){
				System.out.print(x * x + y * y <= r * r ? "*" : ' ');
				// System.out.print(??? <= r * r ? "**" : "  ");
			}
			System.out.println();
		}
	}

  @Override public int getArea(){
    return (int)(Math.PI * getRadius() * getRadius() / 2);
  }

}