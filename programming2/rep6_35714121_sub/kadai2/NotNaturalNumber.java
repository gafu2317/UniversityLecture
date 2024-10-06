// 例外クラスNotNaturalNumberを書く
public class NotNaturalNumber extends RuntimeException {
    public NotNaturalNumber(int n) {
        super("自然数ではない:" + n);
    }
}
