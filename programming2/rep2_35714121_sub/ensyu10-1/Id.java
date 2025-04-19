// 連番クラスIdを書く
//識別番号クラス(その１)
public class Id {
    public static int counter = 0; // 何番までの識別番号を与えたか
    private int id; // 識別番号

    //--- コンストラクタ ---//
    public Id() {
        id = ++counter; // 識別番号
    }

    //--- 識別番号を取得 ---//
    public int getId() {
        return id;
    }

    //--- 最後に与えた識別番号を取得 ---//
    public static int getMaxId() {
        return counter;
    }
}