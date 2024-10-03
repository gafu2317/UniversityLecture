// mainメソッドを含むM166Calendarクラスを書く

// 以下に必要な記述を追加せよ
// カレンダーの表示形式には様々なものが考えられるが
// 代表的なものは以下のものであろう

//       2018 5
// Su Mo Tu We Th Fr Sa
//        1  2  3  4  5
//  6  7  8  9 10 11 12
// 13 14 15 16 17 18 19
// 20 21 22 23 24 25 26
// 27 28 29 30

import java.time.LocalDate;

public class M166Calendar{
	public static int dayOfWeek(int y, int m, int d){
		// 必要であれば曜日を求めるこのメソッドを使用しても良い
		// ツェラーの公式による曜日の計算
		// [明解 Java,  p.264 より]
		if (m == 1 || m == 2){
			y--;
      m += 12;
		}
		return (y + y / 4 - y / 100 + y / 400 + (13 * m + 8 ) / 5 + d) % 7;
	}
	
	public static void printCalendarMonth(int year, int month){
		int[] daysInMonth = {31,28,31,30,31,30,31,31,30,31,30,31};
		int days = daysInMonth[month - 1];

		if (month == 2 && isLeapYear(year)){
			days = 29;
		}

		int firstDayOfWeek = dayOfWeek(year, month, 1);

		System.out.printf("%4d %2d\n", year, month);
		System.out.println(" Su Mo Tu We Th Fr Sa");

		for (int i = 0; i < firstDayOfWeek; i++){
			System.out.print("   ");
		}

		for (int i = 1; i <= days; i++){
			System.out.printf("%3d", i);
			if ((i + firstDayOfWeek) % 7 == 0){
				System.out.println();
			}
		}
		System.out.println();
	}

	public static boolean isLeapYear(int year){
		return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
	}
	
	// この他にも必要なメソッドがあれば追加すること
	
	public static void main(String[] args){
		if (args.length == 2) {
			int year = Integer.parseInt(args[0]);
			int month = Integer.parseInt(args[1]);
			printCalendarMonth(year, month);
		} else if (args.length == 1) {
			int year = Integer.parseInt(args[0]);
			for (int month = 1; month <= 12; month++) {
				printCalendarMonth(year, month);
				System.out.println();
			}
		} else {
			int year = LocalDate.now().getYear();
			int month = LocalDate.now().getMonthValue();
			printCalendarMonth(year, month);
		}
	}
}
