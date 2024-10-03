// BFSTreeクラスを書く
// 幅優先探索木を生成する
// 最短経路を生成する
// 以下に必要な記述を追加せよ

// クラス宣言を変更しGraphクラスのサブクラスとする
import java.io.IOException;
import java.util.*;

public class BFSTree extends Graph {
    public BFSTree(String filename) throws IOException {
        super(filename);
    }

    public int[] getBFSTree(int root) {
        int[] parents = new int[num];
        Arrays.fill(parents, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.add(root);
        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int neighbor : getNeighbors(node)) {
                if (parents[neighbor] == -1) {
                    parents[neighbor] = node;
                    queue.add(neighbor);
                }
            }
        }
        return parents;
    }

    public int[] getShortestPath(int start, int end) {
        int[] tree = getBFSTree(start);
        List<Integer> path = new ArrayList<>();
        for (int node = end; node != start; node = tree[node]) {
            path.add(node);
        }
        path.add(start);
        Collections.reverse(path);
        return path.stream().mapToInt(i -> i).toArray();
    }
}
