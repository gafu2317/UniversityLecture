// mainメソッドを含むM162CharCodesクラスを書く
//文字列を読み込み，その文字列に含まれる，全ての文字の文字コードを順に表示するプログラムを作れ．
class M162CharCodes {
    public static void main(String[] args){
        for (int i = 0; i < args[0].length(); i++) {
            System.out.println(args[0].codePointAt(i));
        }
    }
}