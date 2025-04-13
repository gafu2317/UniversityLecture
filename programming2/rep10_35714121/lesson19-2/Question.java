// List 19-5に従ってQuestion.javaのプログラムを書く
import java.lang.reflect.Array;
import java.util.*;

public class Question {
    public static void main(String[] args) {
        ArrayList<String> list = new ArrayList<String>();
        list.add("Alice");
        list.add("Bob");
        list.add("Chris");
        list.add("Diana");//他の名前と同じように大文字から始める
        list.add("Bob");//他の名前と同じように大文字から始める

        // System.out.println(list.get(2));

        // System.out.println(list.size());
        System.out.println("デフォルトの順番");
        for (String name : list) {
            System.out.println(name);
        }

        ArrayList<String> listRev = new ArrayList<String>();
        for (int i = list.size() - 1; i >= 0; i--) {
            listRev.add(list.get(i));
        }

        System.out.println("逆順");

        for (String name : listRev) {
            System.out.println(name);
        }
    }
}