// mainメソッドを含むMonteCarloTesterクラスを書く
import java.util.SplittableRandom;

public class MonteCarloTester {
		
	private static int ITERATION = 10000;
	private static long SEED = 0;

	private static SplittableRandom random = new SplittableRandom(SEED);

	public static double area(UpperBounded u){

		int count=0;

		for(int i = 0;i < ITERATION;i++){
			double x = random.nextDouble(1.);		
			double y = random.nextDouble(1.);
	
			if(u.inside(x, y)) count++;	
		}

		return (double)count / ITERATION;
	}

	public static void main(String args[]){

		UpperBounded funcs[] = {
			new Proportional("Proportional"),
			new Quadrant("Quadrant"),
			new And(new Proportional("Proportional"), new Quadrant("Quadrant")),
		};

		for(UpperBounded f : funcs){
			System.out.println(f);
			if(f instanceof FunctionQI){
				FunctionQI q = (FunctionQI)f;
				for(double x = 0.; x <= 1.; x += .25){
					System.out.println(String.format(" f(%f) = %f", x, q.f(x)));
				}

			}
			System.out.println(String.format("Area=" + area(f)));
		}

	}
}
