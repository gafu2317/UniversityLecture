// RandomTimerクラスを書く
// mainメソッドを含むQuickPressクラスを書く
import java.util.Random;
import java.util.Scanner;
public class QuickPress {
  public static void main(String[] args) {
    Scanner stdIn = new Scanner(System.in);
    RandomTimer t = new RandomTimer(10000);
    System.out.println("Enterを押すと計測開始、＊が出たらEnterを押してください。");
    stdIn.nextLine();
    t.start();
    stdIn.nextLine();
    t.stopTimer();
    try{
      t.join();
    }catch(InterruptedException e){
      e.printStackTrace();
    }
    System.out.println((t.responseTime()/1000)+"秒");
  }
}

class RandomTimer extends Thread{
  private long count;
  boolean running = true;
  RandomTimer(int maxWait){
    Random r = new Random();
    this.count = (long)(r.nextDouble() * (maxWait/10))*10;
  }
  @Override public void run() {
    while(running){
      try{
        Thread.sleep(10);
        count -= 10;
      }catch(InterruptedException e){
        e.printStackTrace();
      }
      if(count == 0){
        System.out.println("*");
      }
    }
  }
  long responseTime(){
    return -count;
  }
  void stopTimer(){
    running = false;
  }
}