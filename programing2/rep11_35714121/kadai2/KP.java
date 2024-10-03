// mainメソッドを含むKPクラスを書く
import java.util.Scanner;

public class KP {
  public static void main(String[] args) {
	int num, capacity, answer; // 品物の数n，ナップサックの容量(重量の上限)W，答え
	int[] weight, value; // 各品物の重量と価値

	// ファイルの読み込みa
	Scanner scanner = new Scanner(System.in);
	num = scanner.nextInt();//はじめの値
	capacity = scanner.nextInt();//次の値

	weight = new int[num];//配列の初期化
	value = new int[num];//配列の初期化

	for (int i = 0; i < num; i++) {
    weight[i] = scanner.nextInt();//numの数だけ代入をループ
    value[i] = scanner.nextInt();
	}

	Solver s = new Solver(num, weight, value, capacity);
	answer = s.solve();
	System.out.println(answer);
  }
}

