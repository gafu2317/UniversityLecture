// mainメソッドを含むM161InvertStringクラスを書く
// 文字列を読み込み，その文字列を逆順に表示するプログラムを作れ
public class M161InvertString {
    public static void main(String[] args) {
        System.out.print("逆順を表示");
        System.out.println(args.length);
        for (int i = args[0].length() - 1; i >= 0; i--) {
            System.out.print(args[0].charAt(i));
        }
        System.out.println();
    }
}