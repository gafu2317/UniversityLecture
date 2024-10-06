// mainメソッドを含むM164CmdArgCircleクラスを書く
class M164CmdArgCircle {
    public static void main(String[] args) {
        double r = Double.parseDouble(args[0]);
        System.out.println("円周の長さ: " + 2 * Math.PI * r);
        System.out.println("面積: " + Math.PI * r * r);
    }
}