// Periodクラスを書く
public class Period {
    private final Day from;// 開始日
    private final Day to;// 終了日
  
    // コンストラクタ
    public Period(Day from, Day to) {
        this.from = new Day(from);
        this.to = new Day(to);
    }
  
    // 開始日と終了日を取得
    public Day start() {
        return from;
    }

    public Day end() {
        return to;
    }
}

