// PQDijkstraクラスを書く
// プライオリティキューを用いるダイクストラ法により最短経路を生成する
// 以下に必要な記述を追加せよ

// クラス宣言を変更しDijkstraクラスのサブクラスとする

import java.util.Arrays;
import java.util.PriorityQueue;
import java.util.*;

public class PQDijkstra extends Dijkstra {
    // doDijkstra メソッドをオーバライドする
    @Override
    int[] doDijkstra(int start) {
        int n = nodes.size();
        double[] dist = new double[n];
        int[] parent = new int[n];
        Arrays.fill(dist, INF);
        Arrays.fill(parent, -1);
        dist[start] = 0;

        PriorityQueue<Integer> pq = new PriorityQueue<>(Comparator.comparingDouble(node -> dist[node]));
        pq.add(start);

        while (!pq.isEmpty()) {
            int u = pq.poll();

            for (Edge edge : nodes.get(u).getEdges()) {
                int v = edge.getTo();
                double weight = edge.getWeight();

                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    parent[v] = u;
                    pq.add(v);
                }
            }
        }

        return parent;
    }
}
