// Dijkstraクラスを書く
// ダイクストラ法により最短経路を生成する
// 以下に必要な記述を追加せよ

// クラス宣言を変更しGraphクラスのサブクラスとする
import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

class Dijkstra extends Graph {
    public static final double INF = Double.MAX_VALUE;// 無限大

    int[] doDijkstra(int start) {
        double[] dist = new double[nodes.size()];// 開始ノードからの距離(重み)
        int[] prev = new int[nodes.size()];// 最短経路の前のノード
        Queue<Integer> queue = new LinkedList<>();// 最短系路を求める順番に使う
        Arrays.fill(dist, INF);// 配列の全要素をINFで初期化
        Arrays.fill(prev, -1);

        dist[start] = 0;// 開始ノードの距離を0に設定
        prev[start] = start;// 開始ノードの親は自分自身
        queue.add(start);// 開始ノードを追加

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (Edge edge : nodes.get(current).getEdges()) {
                if (edge.getWeight()+dist[edge.getNodeID()] < dist[edge.getTo()]) {// すでにある距離より小さい場合は更新
                    dist[edge.getTo()] = edge.getWeight()+dist[edge.getNodeID()];
                    prev[edge.getTo()] = current;// 親を更新
                    queue.add(edge.getTo());// キューにノードを追加
                }
            }
        }

        return prev;
    }

    int[] getShortestPath(int start, int end) {
        int[] prev = doDijkstra(start);
        int[] path = new int[nodes.size()];
        int index = 0;

        for (int v = end; v != start; v = prev[v]) {
            path[index++] = v;
        }
        path[index++] = start;

        int[] shortestPath = new int[index];// 逆順にする
        for (int i = 0; i < index; i++) {
            shortestPath[i] = path[index - i - 1];
        }

        return shortestPath;
    }
}
