// DFSTreeクラスを書く
// 深さ優先探索木を生成する
// 指定された始点と終点の間の経路を生成する
// 以下に必要な記述を追加せよ

// クラス宣言を変更しGraphクラスのサブクラスとする
import java.io.IOException;
import java.util.*;

public class DFSTree extends Graph {
    private boolean[] visited;
    private int[] parent;

    public DFSTree(String filename) throws IOException {
        super(filename);
        visited = new boolean[num];
        parent = new int[num];
    }

    public int[] getDFSTree(int root) {
        Arrays.fill(visited, false);
        Arrays.fill(parent, -1);
        DFS(root);
        return parent;
    }

    private void DFS(int node) {
        visited[node] = true;
        List<Integer> neighbors = getNeighbors(node);
        for (int adjacentNode : neighbors) {
            if (!visited[adjacentNode]) {
                parent[adjacentNode] = node;
                DFS(adjacentNode);
            }
        }
    }

    public List<Integer> getPath(int start, int end) {
        getDFSTree(start);
        List<Integer> path = new ArrayList<>();
        for (int node = end; node != -1; node = parent[node]) {
            path.add(node);
        }
        Collections.reverse(path);
        return path;
    }
}