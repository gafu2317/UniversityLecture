// 抽象クラスFunctionQIを書く
public abstract class FunctionQI{

	protected String name;
	protected FunctionQI(String name){ this.name = name; }
	@Override public String toString(){ return name; }
	public abstract double f(double x);

}
