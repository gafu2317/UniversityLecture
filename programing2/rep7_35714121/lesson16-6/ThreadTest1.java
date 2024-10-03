// (問題16-6のクラスをThreadクラスの拡張クラスとして作る)
// runメソッドを含むThreadの拡張クラスを書く
// mainメソッドを含むThreadTest1クラスを書く
// (両者を同一のクラスとしても良い)
public class ThreadTest1 extends Thread {
  public static void main(String[] args) {
    new ThreadAsterisk1().start();
    new ThreadEqual1().start();
  }
}
class ThreadAsterisk1 extends Thread {
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
class ThreadEqual1 extends Thread {
  @Override public void run() {
    for (int i = 0; i < 10; i++) {
      try {
        Thread.sleep(5000);
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
      System.out.println("=====");
    }
  }
}
