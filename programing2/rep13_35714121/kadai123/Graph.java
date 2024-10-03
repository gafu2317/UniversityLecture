// Edge, Node, Graphクラスを書く
// 以下に必要な記述を追加せよ
import java.util.*;
import java.io.*;

class Edge {
  int nodeId;
  int to;
  double weight;

  Edge(int nodeId,  int to, double weight) {
    this.nodeId = nodeId;
    this.to = to;
    this.weight = weight;
  }

  int getNodeID() {
    return nodeId;
  }

  int getTo() {
    return to;
  }

  double getWeight() {
    return weight;
  }
}

class Node {
  List<Edge> edges = new ArrayList<>();

  void addEdge(Edge edge) {
    edges.add(edge);
  }

  List<Edge> getEdges() {
    return edges;
  }
}

class Graph {
  List<Node> nodes = new ArrayList<>();

  void loadGraph(String fileName) throws FileNotFoundException {
    Scanner scf = new Scanner(new File(fileName));
    while (scf.hasNextLine()) {
      String s = scf.nextLine();
      Scanner scs = new Scanner(s);
      scs.useDelimiter(",|:|@|\r\n|\n");

      if (!scs.hasNextInt())
        break;

      int nodeId = scs.nextInt();
      Node node = new Node();
      while (scs.hasNextInt()) {
        int to = scs.nextInt();
        double weight = scs.nextDouble();
        node.addEdge(new Edge(nodeId, to, weight));
      }

      nodes.add(node);
    }
    scf.close();
  }

  void printGraph() {
    for (int i = 0; i < nodes.size(); i++) {
      Node node = nodes.get(i);
      System.out.print(i + ":");
      String c = "";
      for (Edge edge : node.getEdges()) {
        System.out.print(c + edge.getTo() + "@" + edge.getWeight());
        c = ",";
      }
      System.out.println();
    }
  }
}