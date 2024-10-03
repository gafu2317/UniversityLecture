// mainメソッドを含むUnionFindTesterクラスを書く
// UnionFindTesterクラスのfindメソッドとuniteメソッドをテストする
// 課題3でmainメソッドを実行するクラス

public class UnionFindTester {
  public static void main(String[] args) {
    UnionFind uf = new UnionFind(5);

    System.out.println("初期状態:");
    for (int i = 0; i < 5; i++) {
      System.out.println("find(" + i + ") = " + uf.find(i));
    }

    System.out.println("\nUnite 0 and 1:");
    uf.unite(0, 1);
    for (int i = 0; i < 5; i++) {
      System.out.println("find(" + i + ") = " + uf.find(i));
    }

    System.out.println("\nUnite 2 and 3:");
    uf.unite(2, 3);
    for (int i = 0; i < 5; i++) {
      System.out.println("find(" + i + ") = " + uf.find(i));
    }

    System.out.println("\nUnite 3 and 4:");
    uf.unite(3, 4);
    for (int i = 0; i < 5; i++) {
      System.out.println("find(" + i + ") = " + uf.find(i));
    }

    System.out.println("\nUnite 0 and 4:");
    uf.unite(0, 4);
    for (int i = 0; i < 5; i++) {
      System.out.println("find(" + i + ") = " + uf.find(i));
    }
  }
}
