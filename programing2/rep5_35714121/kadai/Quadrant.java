// サブクラスQuadrantを書く
public class Quadrant extends FunctionQI implements UpperBounded{

	public Quadrant(String name){ super(name); }

	@Override public String toString(){
		return String.format("%s: f(x) = √1-x^2", super.toString());
	}

	@Override public double f(double x){
		return Math.sqrt(1. - x * x);
	}

	@Override public boolean inside(double x, double y){
		return x*x + y*y <= 1.;
	}

}

// ??? ??? Quadrant ??? FunctionQI ??? UpperBounded{

// 	public Quadrant(String name){ ???(name); }

// 	@??? ??? ??? toString(){
// 		return String.format("%s: f(x) = ???", ???.???());
// 	}

// 	@??? public double f(double x){
// 		return ???;
// 	}

// 	@??? public boolean ???(double x, double y){
// 		return ???;
// 	}

// }

