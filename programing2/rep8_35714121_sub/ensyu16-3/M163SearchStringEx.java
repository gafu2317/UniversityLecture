// mainメソッドを含むM163SearchStringExクラスを書く
//文字列探索
import java.util.Scanner;
class M163SearchStringEx {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("文字列s1:"); String s1 = sc.next();
        System.out.println("文字列s2:"); String s2 = sc.next();
        int idx = s1.indexOf(s2);
        if (idx == -1) {
            System.out.println("s1中にs2は含まれません。");
        } else {
            System.out.println(s1);
            for (int i = 0; i < idx; i++) {
                System.out.print(" ");
            }
            System.out.println(s2);
        }
    }
}