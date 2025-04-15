package chap8;

public class challenge {

    final int N = 8;
    int[][] board = new int[N][N];
    int countSolutions = 0;

    void initializeBoard() {//チェス盤の初期化
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                board[i][j] = 0;
    }

    boolean isSafe(int row, int col) {
        int i, j;

        // 左の列をチェック
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

    void solveNQUtil(int col) {
        if (col >= N) {
            countSolutions++;
            System.out.println("Solution " + countSolutions);//回答の番号を表示
            printSolution();//回答を表示
            return;
        }

        for (int i = 0; i < N; i++) {
            if (isSafe(i, col)) {
                board[i][col] = 1;
                solveNQUtil(col + 1);
                board[i][col] = 0;
            }
        }
    }

    boolean solveNQ() {
        initializeBoard();

        solveNQUtil(0);

        if (countSolutions == 0) {
            System.out.println("解が存在しません");
            return false;
        }

        return true;
    }

    void printSolution() {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++)
                System.out.print(board[i][j] + " ");
            System.out.println();
        }

        System.out.println();
    }

    public static void main(String args[]) {
        challenge Queen = new challenge();
        Queen.solveNQ();
    }
}
