// mainメソッドを含むEdgeSortTesterクラスを書く
// WUGraphクラスのgetSortedEdgesメソッドをテストする
// 課題2でmainメソッドを実行するクラス
// 辺の読み込みなどは課題1のプログラムを元にしてよい
import java.io.FileNotFoundException;
import java.util.ArrayList;

public class EdgeSortTester {
  public static void main(String[] args) {
    WUGraph graph = new WUGraph();
    try {
      graph.loadGraph(args[0]);
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    }

    ArrayList<Edge> sortedEdges = graph.getSortedEdges();
    for (Edge edge : sortedEdges) {
      System.out.println(edge.getId() + "," + edge.getNode1().getId() + "," + edge.getNode2().getId() + "," + edge.getWeight());
    }
  }
}
