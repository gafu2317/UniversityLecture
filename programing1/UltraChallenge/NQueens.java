package UltraChallenge;

public class NQueens {
    final int N = 8;
    int board[][] = new int[N][N];

    // チェス盤の初期化
    void initializeBoard() {
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                board[i][j] = 0;
    }

    // クィーンが置けるか判定するメソッド
    boolean isSafe(int row, int col) {
        int i, j;

        // 左の行をチェック
        for (i = 0; i < col; i++)
            if (board[row][i] == 1)
                return false;

        // 左上から下への対角線をチェック
        for (i = row, j = col; i >= 0 && j >= 0; i--, j--)
            if (board[i][j] == 1)
                return false;

        // 左下から上への対角線をチェック
        for (i = row, j = col; j >= 0 && i < N; i++, j--)
            if (board[i][j] == 1)
                return false;

        return true;
    }

    // バックトラッキングを使用してNクィーン問題を解く
    boolean solveNQUtil(int col) {
        // 全クィーンが置かれたらtrueを返す
        if (col >= N)
            return true;

        // この列の各行に1つずつクィーンを置いてみる
        for (int i = 0; i < N; i++) {
            if (isSafe(i, col)) {
                // クィーンを置く
                board[i][col] = 1;

                // 次の列に進む
                if (solveNQUtil(col + 1) == true)
                    return true;

                // クィーンを取り除き、バックトラックする
                board[i][col] = 0;
            }
        }

        // クィーンを置くことができる場所がなければfalseを返す
        return false;
    }

    // 問題を解くためのメソッド
    boolean solveNQ() {
        initializeBoard();

        if (solveNQUtil(0) == false) {
            System.out.print("解が存在しません");
            return false;
        }

 // 解が見つかったら、盤面を出力する
        printSolution();
        return true;
    }

    // 結果を出力するメソッド
    void printSolution() {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++)
                System.out.print(" " + board[i][j]+ " ");
            System.out.println();
        }
    }

    // メインメソッド
    public static void main(String args[]) {
        NQueens Queen = new NQueens();
        Queen.solveNQ();
    }
}

