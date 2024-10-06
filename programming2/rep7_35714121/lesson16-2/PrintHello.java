// (List16-12のPrintHello.javaを修正する)
// rumメソッドを含むLabelPrinterクラスを書く
// mainメソッドを含むPrintHelloクラスを書く
public class PrintHello {
    public static void main(String[] args) {
        LabelPrinter th = new LabelPrinter("こんにちは");
        th.start();
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

