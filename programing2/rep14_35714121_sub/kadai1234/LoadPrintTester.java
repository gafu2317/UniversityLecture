// mainメソッドを含むLoadPrintTesterクラスを書く
// WUGraphクラスのloadGraphメソッドとprintGraphメソッドをテストする
// 課題1でmainメソッドを実行するクラス
// 前回作成したものと同様の検証をする

public class LoadPrintTester {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java LoadPrintTester <graph file>");
            return;
        }
        WUGraph graph = new WUGraph();
        try {
            graph.loadGraph(args[0]);
            graph.printGraph();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
