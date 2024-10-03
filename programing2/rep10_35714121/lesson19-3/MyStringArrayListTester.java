// List 19-16に従って問題19-3のプログラムを書く

// MyStringArrayListクラスを書く
class MyStringArrayList{
    private static final int INITIAL_CAPACITY = 4;
    private String[] ar;
    private int sz;

    public MyStringArrayList(){
        ar = new String[INITIAL_CAPACITY];
        sz = 0;
    }

    public void add(String s){
        if (sz == ar.length){
            String[] newAr = new String[ar.length * 2];
            for (int i = 0; i < ar.length; i++){
                newAr[i] = ar[i];
            }
            ar = newAr;
        }
        ar[sz] = s;
        sz++;
    }

    public String get(int n){
        if (n < 0 || n >= sz){
            throw new IndexOutOfBoundsException();
        }
        return ar[n];
    }

    public int size(){
        return sz;
    }
}

// mainメソッドを含むMyStringArrayListTesterクラスを書く
// MyStringArrayListの機能を確認する
public class MyStringArrayListTester{
    public static void main(String[] args){
        MyStringArrayList list = new MyStringArrayList();
        list.add("Alice");
        list.add("Bob");
        list.add("Chris");
        list.add("Diana");
        list.add("Bob");//他の名前と同じように大文字から始める

        System.out.println("list.get(2)");
        System.out.println(list.get(2));

        System.out.println("list.size()");
        System.out.println(list.size());

        System.out.println("デフォルトの順番");
        for (int i = 0; i < list.size(); i++){
            System.out.println(list.get(i));
        }

        MyStringArrayList listRev = new MyStringArrayList();
        for (int i = list.size() - 1; i >= 0; i--){
            listRev.add(list.get(i));
        }

        System.out.println("逆順");

        for (int i = 0; i < listRev.size(); i++){
            System.out.println(listRev.get(i));
        }
    }
}

