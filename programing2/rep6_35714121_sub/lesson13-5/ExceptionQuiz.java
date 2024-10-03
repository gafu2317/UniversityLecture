// mainメソッドを含むExceptionQuizクラスを書く
public class ExceptionQuiz {
    public static void main(String[] args) {
      System.out.println("START");
      try {
        int[] a = new int[3];
        System.out.println("代入します。");
        a[3] = 123;
        System.out.println("代入しました。");
      } catch (RuntimeException e) {
        System.out.println("catch(1)");
      } catch (Exception e) {
        System.out.println("catch(2)");
      } finally {
        System.out.println("finally");
      }
      System.out.println("END");
    }
}