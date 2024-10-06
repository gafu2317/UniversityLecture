// mainメソッドを含むIdTesterクラスを書く
public class IdTester {
    public static void main(String[] args) {
        Id a = new Id(); // 識別番号1番
        Id b = new Id(); // 識別番号2番

        System.out.println("aの識別番号：" + a.getId());
        System.out.println("bの識別番号：" + b.getId());

        System.out.println("Id.counter = " + Id.counter);
        
        System.out.println("最後に与えた識別番号：" + Id.getMaxId());
    }
}
