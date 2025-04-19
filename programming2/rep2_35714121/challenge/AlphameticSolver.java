// mainメソッドを含むAlphameticValueTesterクラスを書く
public class AlphameticSolver {
    public static void main(String[] args) {
        // インスタンスの生成(AB+CD=CEとなるように調整)
        AlphameticValue a = new AlphameticValue("BC");//12
        AlphameticValue b = new AlphameticValue("DE");//34
        AlphameticValue c = new AlphameticValue("EG");//46
        System.out.println("aはBCです。");
        System.out.println("bはDEです。");
        System.out.println("cはEGです。");
        System.out.println("アルファベットのAからJまでの値を順に0から9までの値に対応させます。");
        System.out.println("a+b=cとなるはずなので計算してみます");
        System.out.println("a+b=" + (a.toInt() + b.toInt()) + "です。");
        System.out.println("c=" + c.toInt() + "です。");

    }
}
