// (問題16-6のクラスをRunnableインタフェースを実装して作る)
// runメソッドを含むRunnableの実装クラスを書く
// mainメソッドを含むThreadTest2クラスを書く
// (両者を同一のクラスとしても良い)
public class ThreadTest2 {
    public static void main(String[] args) {
      new Thread (new ThreadAsterisk2()).start();
      new Thread (new ThreadEqual2()).start();
    }
}
class ThreadAsterisk2 implements Runnable {
  @Override public void run() {
    for (int i = 0; i < 100; i++) {
      try {
        Thread.sleep(3000);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
      System.out.println("***");
    }
  }
}
class ThreadEqual2 implements Runnable {
  @Override public void run() {
    for (int i = 0; i < 100; i++) {
      try {
        Thread.sleep(5000);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
      System.out.println("=====");
    }
  }
}
