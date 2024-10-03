// RangeAddクラスを書く
public class RangeAdd {
    public static int add ( int a , int b ) {
        if ( a < 0) {
            throw new NotNaturalNumber(a);
        } else if ( b < 0) {
            throw new NotNaturalNumber(b);
        }
        int high = a > b ? a : b;
        int low = a < b ? a : b;
        int sum = low;
        for (int i = low; i < high; i++ ) {
            sum += i+1;
        }
        return sum;
    }
}
