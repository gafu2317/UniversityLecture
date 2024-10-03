package chap7;
import java.util.Scanner;

public class challenge {

  public static void main(String[] args) {
      // ここでnの値を指定します。
      Scanner stdIn = new Scanner(System.in);
      System.out.print("円盤の枚数：");
      int n = stdIn.nextInt();
      String[] A = new String[n+1];//Aの棒にある円盤の状態
      String[] B = new String[n+1];//Bの棒にある円盤の状態
      String[] C = new String[n+1];//Cの棒にある円盤の状態
      for (int i = 0; i < n; i++) {//棒にある円盤の状態を初期化
          A[i] = (i+1) + "";
          B[i] = " ";
          C[i] = " ";
      }
      A[n]="A";//一番下は棒の名前を入れる
      B[n]="B";
      C[n]="C";
      for (int i = 0; i < n+1; i++) {//円盤の状態を表示
        draw(i, A, B, C);
      }
      System.out.println("-----");//区切り線
      hanoi(n, n, A, B, C, A, B, C);
      stdIn.close();
  }
  // n枚の円盤をfromからtoへ、workを介して移動させるメソッド
  public static void hanoi(int N, int n, String[] from, String[] to, String[] work, String[] From, String[] To, String[] Work) {
      if (n > 0) {
          // 最上段のn-1枚を、作業棒workを介してtoからworkへ移動させる
          hanoi(N, n - 1, from, work, to, From, To ,Work);
          // 最下段の大きな円盤をfromからtoへ直接移動させる
          move(N, n, from, to ,work, From, To ,Work);
          
          // work棒にあるn-1枚の円盤を、作業棒fromを介してtoへ移動させる
          hanoi(N, n - 1, work, to, from, From, To ,Work);
      }
  }

  // 円盤nをfromの棒からtoの棒へ移動するメソッド
  private static void move(int N,int n, String[] from, String[] to, String[] work, String[] From, String[] To, String[] Work) {
    for (int i = 0; i < N+1; i++) {
      if(from[i].equals(n+"")){//円盤がある場所を探す
        from[i]=" ";//空白に置き換え
        break;
      }
    }
    for (int i = 0; i < N+1; i++) {
      if(!(to[i].equals(" "))){//一番上の円盤を探す
        to[i-1]=n+"";//そのうえに円盤を置く
        break;
      }
    }
    for (int i = 0; i < N+1; i++) {//円盤の状態を表示
      draw(i, From, To ,Work);
    }
      System.out.println("-----");
  }
  
  // 円盤の状態を表示するメソッド
  private static void draw(int n, String[] from, String[] to, String[] work) {
      System.out.println(from[n]+" "+to[n]+" "+work[n]);
  }
}


