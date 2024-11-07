
public class Main {
  public static void main(String[] args) {
    Counter counter = new Counter(10);
    new Thread(new IncRunnable(counter)).start();
    new Thread(new DecRunnable(counter)).start();
    for(int i=0;i<10000;i++)
      System.out.println(counter.get());}
}

class Counter {
  private int count;
  private int N;
  public Counter(int max){
    count = 0;
    N = max;
  }

  public int get(){
    return count;
  }

  synchronized void inc() throws InterruptedException{
    while(count==N) wait();
    count++;
    notifyAll();
  }

  synchronized void dec() throws InterruptedException{
    while(count==0)wait();
    count--;
    notifyAll();
  }
}

class IncRunnable implements Runnable{
  private Counter counter;
  public IncRunnable(Counter c){counter = c;}
    @Override
    public void run() {
    while(true){
      try {
        counter.inc();
      } catch (InterruptedException e){
      }
    }
  }
}

class DecRunnable implements Runnable{
  private Counter counter;
  public DecRunnable(Counter c){counter = c;}
    @Override
    public void run() {
    while(true){
      try {
        counter.dec();
      } catch (InterruptedException e){
      }
    }
  }
}