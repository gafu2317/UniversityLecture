import java.util.concurrent.Semaphore;

class ThreadExecutor {
    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            RunnableTest r = new RunnableTest();
            Thread[] threads = new Thread[10];

            for (int j = 0; j < threads.length; j++) {
                threads[j] = new Thread(r);
            }

            for (int j = 0; j < threads.length; j++) {
                threads[j].start();
            }

            for (int j = 0; j < threads.length; j++) {
                try {
                    threads[j].join();
                } catch (InterruptedException e) {
                }
            }

            System.out.println((i + 1) + "回目:加算結果は" + r.getCount());
        }
    }
}

class RunnableTest implements Runnable {
    private int count;
    private Semaphore semaphore = new Semaphore(1); // セマフォの初期値を1に設定

    public void run() {
        for (int i = 0; i < 1000; i++) {
            try {
                semaphore.acquire(); // セマフォを取得
                count++;
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt(); // 割込みが発生した場合はスレッドを中断する
            } finally {
                semaphore.release(); // セマフォを解放
            }
        }
    }

    int getCount() {
        return count;
    }
}

