// mainメソッドを含むGraphTesterクラスを書く
// Graphクラスの機能をテストする
// 課題1でmainメソッドを実行するクラス
// 前回作成したものと同様の検証をする

import java.io.FileNotFoundException;

public class GraphTester {
  public static void main(String[] args) {
    if (args.length != 1) {
      System.out.println("Usage: java GraphTester <graph file>");
      return;
    }
    Graph graph = new Graph();
    try {
        graph.loadGraph(args[0]);
        graph.printGraph();
    } catch (FileNotFoundException e) {
        e.printStackTrace();
    }
  }
}
