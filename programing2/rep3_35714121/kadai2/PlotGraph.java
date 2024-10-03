// PlotGraphクラスを書く

public class PlotGraph{

	public static final int X_MIN = 0;
	public static final int X_MAX = 40;

	public static final int Y_MAX = 10;
	public static final int Y_MIN = - Y_MAX;

	private static char buffer[][] = new char[Y_MAX - Y_MIN + 1][X_MAX - X_MIN + 1]; // y座標順

	public static void clear(){
		for(char[] b : buffer)
			for(int i = 0;i < b.length; i++) b[i] = ' ';
	}

	public static void print(){
		for(char[] b : buffer)
			System.out.println(new String(b));
	}

	private char symbol;	

	public PlotGraph(char symbol){ this.symbol = symbol; }

	public int getY(int x){ return 0; }

	public void plot(){
		for(int x = X_MIN; x <= X_MAX; x++){
			int y = - getY(x);//ここでマイナスにしているので配列に入れる時に調整する
			if(Y_MIN <= y && y <= Y_MAX){
				buffer[y - Y_MIN][x - X_MIN] = symbol; // y座標順(yにはマイナスがかけられているので、bufferにれる時にY_MINを引く)
			}
		}
	}

}
