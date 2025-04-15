// 連番クラスExIdを書く
// mainメソッドを含むExIdTesterクラスを書く
public class ExIdTester {
    public static void main(String[] args) {
        System.out.println("aを生成します");
        ExId a = new ExId(); // 識別番号1番
        System.out.println("aの識別番号：" + a.getId());

        System.out.println();

        System.out.println("nを３に設定します");
        ExId.setN(3); // nを3に設定
        System.out.println("bを生成します");
        ExId b = new ExId(); // 識別番号2番
        System.out.println("bの識別番号：" + b.getId());

        System.out.println("最後に与えた識別番号：" + ExId.getMaxId());
    }
}