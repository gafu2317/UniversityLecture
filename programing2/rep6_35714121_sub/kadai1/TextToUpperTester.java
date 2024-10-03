// mainメソッドを含むTextToUpperTesterクラスを書く(指示通り直す)
import java.io.*;

public class TextToUpperTester {
    public static void main(String[] args) {
        try {
            TextToUpper.readAndConvert("foobar.txt");
        } catch (FileNotFoundException e) {
            System.out.println("ファイルが見つかりません");
            System.out.println(e);
        }
    }
}
