// Edge, Node, Graphクラスを書く
// 以下に必要な記述を追加せよ
import java.util.*;
import java.io.*;

class Edge{
    private int to;
    Edge(int to){this.to = to;}
    int To(){return to;}
}

class Node{
    int id;
    ArrayList<Edge> list;

    Node(String line) {
        list = new ArrayList<Edge>();
        String[] sp1 = line.split(":");
        id = Integer.parseInt(sp1[0]);
        String[] sp2 = sp1[1].split(",");
        for (String s : sp2) {
            list.add(new Edge(Integer.parseInt(s)));
        }
    
    }

    void addToList(int nid) {
        list.add(new Edge(nid));
    }
    ArrayList<Edge> getList(){
	return list;
    }
    // その他必要なものがあれば適当に作成
}

public class Graph{
    // 頂点のリスト
    // 配列であれば
    int num;
    Node [] nodes;
    
    // 可変長リストであれば
    //ArrayList<Node> nodes;
    
    public void printGraph() {
        for (Node node : nodes) {
            System.out.print(node.id + ":");
            ArrayList<Edge> edges = node.getList();
            for (int i = 0; i < edges.size(); i++) {
                System.out.print(edges.get(i).To());
                if (i < edges.size() - 1) {
                    System.out.print(",");
                }
            }
            System.out.println();
        }
    }

    public void loadGraph(String filename) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(filename));
        String line;
        ArrayList<Node> nodeList = new ArrayList<>();
        while ((line = br.readLine()) != null) {
            nodeList.add(new Node(line));
        }
        br.close();
        nodes = nodeList.toArray(new Node[0]);
        num = nodes.length;
    }

    public List<Integer> getNeighbors(int nodeId) {
        ArrayList<Edge> edges = nodes[nodeId].getList();
        List<Integer> neighbors = new ArrayList<>();
        for (Edge edge : edges) {
            neighbors.add(edge.To());
        }
        return neighbors;
    }
    
    Graph(String filename) {
        try {
            loadGraph(filename);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

