// Dictionaryクラスを書く
// mainメソッドを含むDictionaryTesterクラスを書く

// 以下に必要な記述を追加せよ
// 以下の記述は例であるため，変更してもよい

import java.util.Scanner;
import java.io.File;

class Dictionary{
	private int wordNum = 46725;
	private String[] englishWords = new String[wordNum];
	private String[] japaneseTranslations = new String[wordNum];
	// 辞書に含まれる行数
	// 他に課題で必要なフィールドを追加すること
	public Dictionary(String filename){
		// 講義資料に記載されているものと同じである．
		// 適宜記述を追加すること
    try{
			Scanner scan = new Scanner(new File(filename));
      for (int i=0;i<wordNum;i++){
				if (!scan.hasNextLine()){
					// 次の行が読み込めない場合の処理
					// 辞書ファイルが想定よりも短い場合に実行
					// 通常は実行されない
					System.out.println("辞書ファイルが想定より短すぎます");
					break;
				}
				String line = scan.nextLine();
				// line には1行全ての文字が含まれるため
				// 英単語と和訳に適切に分割して格納すること
				// 以下に記述を追加
				String[] words = line.split("\t");
				englishWords[i] = words[0];
				japaneseTranslations[i] = words[1];
      }
		}catch(java.io.FileNotFoundException e){
			System.out.println(e);
      System.exit(0);
		}
	}
	// 以下に Dictionary クラスで指定されたメソッドを追加すること
	public String searchEWord(String word) {
    for (int i = 0; i < wordNum; i++) {
        if (englishWords[i].equals(word)) {
            return englishWords[i] + ": " + japaneseTranslations[i];
        }
    }
    return null;
  }
	public String searchFEWord(String word) {
    for (int i = 0; i < wordNum; i++) {
        if (englishWords[i].startsWith(word)) {
            int dashIndex = word.length();
            String remainingPart = englishWords[i].substring(word.length());
            return englishWords[i].substring(0, dashIndex) + "-" + remainingPart + ": " + japaneseTranslations[i];
        }
    }
    return null;
  }
	public String searchJWord(String word) {
    StringBuilder result = new StringBuilder();
    for (int i = 0; i < wordNum; i++) {
        if (japaneseTranslations[i].contains(word)) {
            if (result.length() > 0) {
                result.append(System.lineSeparator());
            }
            result.append(englishWords[i]).append(": ").append(japaneseTranslations[i]);
        }
    }
    return result.length() > 0 ? result.toString() : null;
  }

}
	
	
	public class DictionaryTester{
    public static void main(String[] args){
				Dictionary dict = new Dictionary("ejdic-hand.txt");
				System.out.println("serchEWordをテストします。入力はcatです。");
				System.out.println(dict.searchEWord(args[0]));
				System.out.println("");
				System.out.println("serchFEWordをテストします。入力はtranslatです。");
				System.out.println(dict.searchFEWord(args[1]));	
				System.out.println("");
				System.out.println("serchJWordをテストします。入力は猫です。");
				System.out.println(dict.searchJWord(args[2]));
    }
}
