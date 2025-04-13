// 連番クラスIdを書く
//識別番号クラス(その１)
public class ExId {
    public static int counter = 0; // 何番までの識別番号を与えたか
    private static int n = 1;//識別番号をいくつずつ増やすか
    private int id; // 識別番号

    //--- コンストラクタ ---//
    public ExId() {
        counter += n;
        id = counter;
    }

    //--- 識別番号を取得 ---//
    public int getId() {
        return id;
    }

    //--- 最後に与えた識別番号を取得 ---//
    public static int getMaxId() {
        return counter;
    }

    //--- ゲッタ ---//
    public static int getN() {
        return n;
    }
    //--- セッタ ---//
    public static void setN(int n) {
        ExId.n = n;
    }
}