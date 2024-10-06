// 【演習問題2で追加】SemicircleのサブクラスRightSemicircleを書く
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

}
