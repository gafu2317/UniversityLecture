// Solverクラスを書く

public class Solver {
  int capacity, answer;
  int[] weight, value;

  // コンストラクタ
  public Solver(int n, int[] weight, int[] value, int capacity) { 
    this.capacity = capacity;
    this.weight = weight;
    this.value = value;
  }
  public int solve(){ 
    int n = weight.length;
    int[][] dp = new int[n+1][capacity+1];
    for (int i = 0; i < n; i++) {
      for (int w = 0; w <= capacity; w++) {
        if (w - weight[i] >= 0) {
          dp[i+1][w] = Math.max(dp[i][w], dp[i][w - weight[i]] + value[i]);
        } else {
          dp[i+1][w] = dp[i][w];
        }
      }
    }
    return dp[n][capacity];
  }

}

