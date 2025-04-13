package chap4;
import java.util.Scanner;
//ニュートン方によってf(x)=ax^2+bx+c=0の解を求める
public class challenge {
    public static void main(String[] args) {
        System.out.println("f(x)=ax^2+bx+c=0の解を求めます");
        Scanner stdIn = new Scanner(System.in);
        System.out.print("aの値:");
        double a = stdIn.nextDouble();
        System.out.print("bの値:");
        double b = stdIn.nextDouble();
        System.out.print("cの値:");
        double c = stdIn.nextDouble();
        if(b*b-4*a*c<0) {
            System.out.println("実数解はありません");
            System.exit(0);
        } else 
        System.out.print("初期値x0の値:");
        double x0 = stdIn.nextDouble();
        double e = Math.exp(1);//許容誤差
        double x1 = x0 - (a*x0*x0+b*x0+c)/(2*a*x0+b);
        while(Math.abs(x1-x0)>e) {
            x0 = x1;
            x1 = x0 - (a*x0*x0+b*x0+c)/(2*a*x0+b);
        }
        System.out.println("解は"+x1);
    }
}
