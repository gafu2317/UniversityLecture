// Edge, (Node,) WUGraphクラスを書く
import java.util.*;
import java.io.*;

class Node {//頂点
  int id;

  Node(int id) {
    this.id = id;
  }

  public int getId() {
    return id;
  }
}

class Edge implements Comparable<Edge> {//辺
  int id;
  Node node1;
  Node node2;
  int weight;

  @Override
  public int compareTo(Edge e) {
    return Integer.compare(this.weight, e.weight);
  }

  Edge(int id, Node node1, Node node2, int weight) {
    this.id = id;
    this.node1 = node1;
    this.node2 = node2;
    this.weight = weight;
  }

  public int getId() {
    return id;
  }

  public Node getNode1() {
    return node1;
  }

  public Node getNode2() {
    return node2;
  }

  public int getWeight() {
    return weight;
  }
}

public class WUGraph {
  List<Node> nodes = new ArrayList<>();
  List<Edge> edges = new ArrayList<>();

  void loadGraph(String filename) throws FileNotFoundException {
    File file = new File(filename);
    Scanner scanner = new Scanner(file);

    String[] graphData = scanner.nextLine().split(",");//ノード数と辺数の読み込み
    int nodeCount = Integer.parseInt(graphData[1]);
    int edgeCount = Integer.parseInt(graphData[1]);

    for (int i = 0; i < nodeCount; i++) {
      nodes.add(new Node(i));
    }

    for (int i = 0; i < edgeCount; i++) {//辺の読み込み
      String[] edgeData = scanner.next().split(":");
      int edgeId = Integer.parseInt(edgeData[0]);
      String[] nodeData = edgeData[1].split(",");
      int nodeId1 = Integer.parseInt(nodeData[0]);
      int nodeId2 = Integer.parseInt(nodeData[1]);
      int weight = Integer.parseInt(nodeData[2]);
      edges.add(new Edge(edgeId, nodes.get(nodeId1), nodes.get(nodeId2), weight));
    }

    scanner.close();
  }

  void printGraph() {//グラフの情報を表示
    for (Edge edge : edges) {
      System.out.println(edge.id + ":" + edge.node1.id + "," + edge.node2.id + "," + edge.weight);
    }
  }

  ArrayList<Edge> getSortedEdges() {//辺を重みの昇順にソート
    ArrayList<Edge> sortedEdges = new ArrayList<>(edges);
    Collections.sort(sortedEdges);
    return sortedEdges;
  }

  public void addEdge(Edge edge) {
    edges.add(edge);
  }

  public WUGraph getMST() {
    WUGraph mst = new WUGraph();
    List<Edge> sortedEdges = getSortedEdges();
    UnionFind uf = new UnionFind(nodes.size());

    for (Edge edge : sortedEdges) {
      int node1 = edge.getNode1().getId();
      int node2 = edge.getNode2().getId();
      if (uf.unite(node1, node2)) {
        mst.addEdge(edge);
      }
    }

    return mst;
  }

  public int getTotalWeight() {
    int totalWeight = 0;
    for (Edge edge : edges) {
      totalWeight += edge.getWeight();
    }
    return totalWeight;
  }

}
