// mainメソッドを含むDFSTesterクラスを書く
// DFSTreeをテストする
// 課題3でmainメソッドを実行するクラス

import java.io.IOException;
import java.util.List;

public class DFSTester {
    public static void main(String[] args) {
        if (args.length < 3) {
            System.out.println("Usage: java DFSTester <graph file> <start node> <end node>");
            return;
        }
        try {
            String filename = args[0];
            int startNode = Integer.parseInt(args[1]);
            int endNode = Integer.parseInt(args[2]);
    
            DFSTree dfsTree = new DFSTree(filename);
    
            List<Integer> path = dfsTree.getPath(startNode, endNode);
            System.out.println("Path from " + startNode + " to " + endNode + ":");
            for (int node : path) {
                System.out.print(node + " ");
            }
            System.out.println();
    
            System.out.println("Path length: " + (path.size() - 1));

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}