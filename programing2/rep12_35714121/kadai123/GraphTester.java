// mainメソッドを含むGraphTesterクラスを書く
// Graphクラスの機能をテストする
// 課題1でmainメソッドを実行するクラス

public class GraphTester {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java GraphTester <graph file>");
            return;
        }
        Graph graph = new Graph(args[0]);
        graph.printGraph();
    }
}