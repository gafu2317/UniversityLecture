// mainメソッドを含むShapeTesterEx1312クラスを書く
// 【演習問題2では追加した図形もテストできるようにここに処理を加えること】
import java.util.Scanner;
class ShapeTesterEx1312 {
    public static void main(String[] args) {
        java.util.Scanner stdIn = new Scanner(System.in);
        System.out.print("図形は何個：");
        int n = stdIn.nextInt();
        Shape[] p = new Shape[n];
        for (int i = 0; i < n; i++) {
            System.out.print((i + 1) + "番の図形の種類を数値で入力してください（1…点 / 2…水平直線 / 3…垂直直線 / 4…長方形 / 5…右半円 / 6…上半円）：");
            int type = stdIn.nextInt();
            switch (type) {
                case 1:
                    p[i] = new Point();
                    break;
                case 2:
                    System.out.print("水平直線の長さ：");
                    p[i] = new HorzLine(stdIn.nextInt());
                    break;
                case 3:
                    System.out.print("垂直直線の長さ：");
                    p[i] = new VertLine(stdIn.nextInt());
                    break;
                case 4:
                    System.out.print("長方形の幅：");
                    int width = stdIn.nextInt();
                    System.out.print("長方形の高さ：");
                    p[i] = new Rectangle(width, stdIn.nextInt());
                    break;
                case 5:
                    System.out.print("右半円の半径：");
                    p[i] = new RightSemicircle(stdIn.nextInt());
                    break;
                case 6:
                    System.out.print("上半円の半径：");
                    p[i] = new UpperSemicircle(stdIn.nextInt());
                    break;
            }
        }
        for (Shape s : p) {
            s.print();
            System.out.println();
        }
    }
}
