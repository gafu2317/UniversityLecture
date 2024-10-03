// UnionFindクラスを書く
public class UnionFind {
  private int[] parent;
  private int[] rank;

  public UnionFind(int n) {
    parent = new int[n];
    rank = new int[n];
    for (int i = 0; i < n; i++) {//初期化
      parent[i] = i;
      rank[i] = 0;
    }
  }

  public int find(int x) {
    if (parent[x] == x) {
      return x;
    } else {
      return parent[x] = find(parent[x]);
    }
  }

  public boolean unite(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX == rootY) {
      return false;
    }

    if (rank[rootX] < rank[rootY]) {
      parent[rootX] = rootY;
    } else {
      parent[rootY] = rootX;
      if (rank[rootX] == rank[rootY]) {
        rank[rootX]++;
      }
    }
    return true;
  }

  
}