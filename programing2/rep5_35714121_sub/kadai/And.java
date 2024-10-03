// 実装クラスAndを書く
public class And implements UpperBounded{

	UpperBounded f0, f1;

	public And(UpperBounded f0, UpperBounded f1){ this.f0 = f0; this.f1 = f1; }

	@Override public String toString(){
		return String.format("And(%s, %s)", f0, f1);
	}

	@Override public boolean inside(double x, double y){
		return f0.inside(x, y) && f1.inside(x, y);
	}

}

