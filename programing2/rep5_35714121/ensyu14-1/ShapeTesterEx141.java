// mainメソッドを含むShapeTesterEx141クラスを書く
public class ShapeTesterEx141 {
    public static void main(String[] args){
        Shape p[] = { new Point(), new Rectangle(3,2), new Parallelogram(4,3), new RightSemicircle(5), new UpperSemicircle(7) };
        for(Shape s : p){
            s.print();
            if(s instanceof Plane2D){
                System.out.println("Area="+((Plane2D)s).getArea());
            }
            System.out.println();
        }
        Plane2D q[] = { new Rectangle(3,2), new Parallelogram(4,3), new RightSemicircle(5), new UpperSemicircle(7) };
        for(Plane2D i : q){
            System.out.println("Area="+i.getArea());
        }
    }
}

