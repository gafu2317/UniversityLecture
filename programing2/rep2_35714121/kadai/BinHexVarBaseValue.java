// BinHexVarBaseValueクラスを書く
public class BinHexVarBaseValue {
    private static int base = 10; // 基数(N進法のN)を表す
    private int value; // 整数値を表す
    // コンストラクタ
    public BinHexVarBaseValue(int v) {
        this.value = v;
    }

    //getter
    public static int getBase() {
        return base;
    }
    public int getValue() {
        return this.value;
    }

    //setter
    public static void setBase(int b) {
        if (b < 2) {
            base = 2;
        } else if (b > 16) {
            base = 16;
        } else {
            base = b;
        }
    }
    public void setValue(int v) {
        this.value = v;
    }

    // valueの値の文字列を返すメソッド
    public String toString() {
        int v = this.value;
        String s = "";
        do {
            int r = v % base;
            s = r >= 10 ? (char)('A' + r - 10) + s : r + s;
            v /= base;
        } while (v > 0);
        return s;
    }
}