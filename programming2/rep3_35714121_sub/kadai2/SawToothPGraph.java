// SinPGraphのサブクラスのSawToothPGraphクラスを書く

public class SawToothPGraph extends SinPGraph{

	public SawToothPGraph(char symbol, double amplitude, double period){
		super(symbol, amplitude, period);
	}

	@Override
	public int getY(int x){
		return (int) (x*amplitude*(Y_MAX)/(period*(X_MAX-X_MIN)) - amplitude*(Y_MAX)*Math.floor(x/(2*period*(X_MAX-X_MIN)) + 0.5));
	}

}
