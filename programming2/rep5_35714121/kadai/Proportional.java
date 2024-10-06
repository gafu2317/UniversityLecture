// サブクラスProportionalを書く
public class Proportional extends FunctionQI implements UpperBounded{

	public Proportional(String name){ super(name); }

	@Override public String toString(){
		return String.format("%s: f(x) = x", super.toString());
	}

	@Override public double f(double x){
		return x;
	}

	@Override public boolean inside(double x, double y){
		return x < y;
	}

}
