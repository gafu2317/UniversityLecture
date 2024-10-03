// mainメソッドを含むMSTTesterクラスを書く
// WUGraphクラスのgetMSTメソッドをテストする
// 課題4でmainメソッドを実行するクラス
// 結果を指定された形式で標準出力(printlnなど)に出力する 

import java.io.FileNotFoundException;

public class MSTTester {
  public static void main(String[] args) {
    WUGraph graph = new WUGraph();
    try {
      graph.loadGraph(args[0]);
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    }

    WUGraph mst = graph.getMST();

    System.out.println("Total weight: " + mst.getTotalWeight());
    int node =graph.nodes.size();
    int edge = mst.edges.size();
    System.out.println(node + "," + edge);
    mst.printGraph();
  }
}