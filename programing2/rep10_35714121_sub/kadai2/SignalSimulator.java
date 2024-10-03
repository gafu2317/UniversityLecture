import java.util.LinkedList;
import java.util.Queue;
// Carクラスを書く
class Car {
  private int arrivalTime;

  public Car(int arrivalTime) {
    this.arrivalTime = arrivalTime;
  }

  public int getArrivalTime() {
    return arrivalTime;
  }
}
// mainメソッドを含むをSignalSimulatorクラスを書く

public class SignalSimulator {
  private int sigFreq;
  private int carFreq;
  private int steps;

  public SignalSimulator(int sigFreq, int carFreq, int steps) {
    this.sigFreq = sigFreq;
    this.carFreq = carFreq;
    this.steps = steps;
  }

  public void runSimulation() {
    Queue<Car> queue = new LinkedList<>();
    int currentTime = 0;
    int carsPassed = 0;
    int totalWaitTime = 0;

    for (int i = 0; i < steps; i++) {
      // 車の出現
      if (i % carFreq == 0) {
        queue.add(new Car(i));
      }

      // 信号の処理
      if ((i / sigFreq) % 2 == 0) { // 青信号
        if (!queue.isEmpty()) {
          Car car = queue.poll();
          carsPassed++;
          totalWaitTime += (i - car.getArrivalTime());
        }
      }

      currentTime++;
    }

    double averageWaitTime = (carsPassed == 0) ? 0 : (double) totalWaitTime / carsPassed;

    System.out.println("通過台数: " + carsPassed);
    System.out.println("平均待ち時間: " + averageWaitTime);
  }

  public static void main(String[] args) {
    if (args.length != 2) {
      System.out.println("使い方: java SignalSimulator <sigFreq> <carFreq>");
      return;
    }

    int sigFreq = Integer.parseInt(args[0]);
    int carFreq = Integer.parseInt(args[1]);
    int steps = 10000;

    SignalSimulator simulator = new SignalSimulator(sigFreq, carFreq, steps);
    simulator.runSimulation();
  }
}
