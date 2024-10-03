// mainメソッドを含むExceptionTest5Exクラスを書く
public class ExceptionTest5Ex {
    public static void main(String[] args) {
      try {
        method1();
      } catch (Exception e) {
        System.out.println("method1での例外:" + e);
        e.printStackTrace();
      }
      try {
        method2();
      } catch (Exception e) {
        System.out.println("method2での例外:" + e);
        e.printStackTrace();
      }
      try {
        method3();
      } catch (Exception e) {
        System.out.println("method3での例外:" + e);
        e.printStackTrace();
      }
    }
    static void method1() {
      int[] myarray = new int[3];
      myAssign(myarray, 100, 0);
    }
    static void method2() {
      int[] myarray = new int[3];
      myAssign(myarray, 0, 0);
    }
    static void method3() {
      int[] myarray = new int[3];
      myAssign(myarray, 1, 0);
    }
    static void myAssign(int[] arr, int index, int value) {
        System.out.println("myAssignに来ました");
        arr[index] = value;
        System.out.println("myAssignから帰ります");
    }
}
