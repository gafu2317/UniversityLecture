// (16-2のプログラムを元にPrintHello3クラスのプログラムを書く)
// rumメソッドを含むLabelPrinterクラスを書く
// mainメソッドを含むPrintHello3クラスを書く

public class PrintHello3 {
    public static void main(String[] args) {
        LabelPrinter th1 = new LabelPrinter("おはよう！");
        th1.start();
        LabelPrinter th2 = new LabelPrinter("こんにちは！");
        th2.start();
        LabelPrinter th3 = new LabelPrinter("こんばんは！");
        th3.start();
    }
}
class LabelPrinter extends Thread{
    String label = "no label";
    LabelPrinter(String label) {
        this.label = label;
    }
    @Override public void run() {
        while (true) {
            System.out.println(label);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}