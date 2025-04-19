// AlphameticValueクラスを書く
public class AlphameticValue {
    private static int[] vals = {0,1,2,3,4,5,6,7,8,9}; // 0~9の値を格納する配列
    private char[] digits; //要素は'A'から'J'の値を取る

    public AlphameticValue(String s) {
        this.digits = s.toCharArray();
    }

    public int toInt() {
        int result = 0;
        for (char digit : digits) {
            int value = vals[digit - 'A'];
            result = result * 10 + value;
        }
        return result;
    }

}
