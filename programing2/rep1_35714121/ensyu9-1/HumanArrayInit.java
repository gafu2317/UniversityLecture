// mainメソッドを含むHumanArrayInitクラスを書く
public class HumanArrayInit {
    public static void main(String[] args) {
        // 生成方法の例1: 初期化しながら配列を生成
        Human[] humans1 = {
            new Human("太郎", 170, 65),
            new Human("花子", 160, 55),
        };

        // 生成方法の例2: 初期化後に要素に値を代入
        Human[] humans2 = new Human[2];
        humans2[0] = new Human("山田", 160, 60);
        humans2[1] = new Human("鈴木", 155, 50);

        System.out.println("humans1:" + humans1[0].getName() + ", " + humans1[1].getName());
    }

    
}