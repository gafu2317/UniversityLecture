// PlotGraphのサブクラスのSinPGraphクラスを書く

public class SinPGraph extends PlotGraph{

	double amplitude;//振幅
	double period;//周期

	public SinPGraph(char symbol, double amplitude, double period){
		super(symbol);
		this.amplitude = amplitude;
		this.period = period;
	}

	double getAmplitude(){ return amplitude; }
	double getPeriod(){ return period; }

	void setAmplitude(double amplitude){ this.amplitude = amplitude; }
	void setPeriod(double period){ this.period = period; }

	@Override
	public int getY(int x){
		return (int)(Y_MAX * amplitude * Math.sin(x / period * 2 * Math.PI / (X_MAX - X_MIN)));//正規化のために(Y_MAX)をかけて(X_MAX - X_MIN)で割るという処理をしている
	}

}
