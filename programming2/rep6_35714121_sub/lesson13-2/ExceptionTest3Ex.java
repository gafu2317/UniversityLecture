// mainメソッドを含むExceptionTest3Exクラスを書く
public class ExceptionTest3Ex {
    public static void main(String[] args) {
        int[] myarray = new int[3];
        myAssign(myarray, 1, 0);
        myAssign(myarray, 100, 0);
    }
    static void myAssign(int[] arr, int index, int value) {
        try {
            System.out.println("myAssignに来ました");
            System.out.println("代入します");
            arr[index] = value;
            System.out.println("代入しました");
            System.out.println("myAssignから帰ります");
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("代入できませんでした");
            System.out.println("例外は" + e + "です");
        }
        System.out.println("終了します");
    }
}
