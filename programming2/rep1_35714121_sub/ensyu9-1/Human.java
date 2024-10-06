// Humanクラスを書く
public class Human {
    private String name;
    private int height;
    private int weight;

    // コンストラクタ
    public Human(String name, int height, int weight) {
        this.name = name;
        this.height = height;
        this.weight = weight;
    }

    // ゲッターメソッド
    public String getName() {
        return name;
    }

    public int getHeight() {
        return height;
    }

    public int getWeight() {
        return weight;
    }
}



