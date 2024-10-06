// 【演習問題2で追加】SemicircleのサブクラスUpperSemicircleを書く
public class UpperSemicircle extends Semicircle{
		public UpperSemicircle(int radius){
				super(radius);
		}
		@Override public String toString(){
				return "UpperSemicircle (radius: " + getRadius() + ")";
		}
		public void draw() {
				int r = getRadius();
				for(int y = -r; y <= 0; y++){
						for(int x = -r; x <= r; x++){
								System.out.print(x * x + y * y <= r * r ? "*" : ' ');
								// System.out.print(x * x + y * y <= r * r ? "**" : "  ");
						}
						System.out.println();
				}
		}

}
