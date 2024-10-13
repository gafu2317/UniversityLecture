// mainメソッドを含むBFSTesterクラスを書く
// BFSTreeをテストする
// 課題2でmainメソッドを実行するクラス

import java.io.IOException;
import java.util.Arrays;

public class BFSTester {
    public static void main(String[] args) {
        if (args.length < 3) {
            System.out.println("Usage: java BFSTester <graph file> <start node> <end node>");
            return;
        }
        try {
            String filename = args[0];
            int start = Integer.parseInt(args[1]);
            int end = Integer.parseInt(args[2]);

            BFSTree bfsTree = new BFSTree(filename);

            int[] path = bfsTree.getShortestPath(start, end);
            System.out.println("Path from " + start + " to " + end + ": " + Arrays.toString(path));
            System.out.println("Path length: " + (path.length - 1));

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
