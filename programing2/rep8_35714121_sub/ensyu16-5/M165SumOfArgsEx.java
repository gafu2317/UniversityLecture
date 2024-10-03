// mainメソッドを含むM165SumOfArgsExクラスを書く
class M165SumOfArgsEx {
    public static void main(String[] args) {
        double sum = 0.0;
        for (String arg : args) {
            sum += Double.parseDouble(arg);
        }
        System.out.println("合計: " + sum);
    }
}