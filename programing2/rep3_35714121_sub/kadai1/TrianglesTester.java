// mainメソッドを含むTrianglesTesterクラスを書く

public class TrianglesTester{

  public static void main(String args[]){
    Triangle[] triangles = {
      new Triangle(3, 4, 5),
      new IsoscelesTriangle(2,1),
      new EquilateralTriangle(3)
    };

    for(int i = 0;i < triangles.length; i++){
      System.out.println(triangles[i].toString());
    } 

    System.out.println("4, 5, 6");
    for(int i = 0;i < triangles.length; i++){
      triangles[i].set(4, 5, 6);
      System.out.println(triangles[i].toString());
    } 
    System.out.println("3, 3, 1");
    for(int i = 0;i < triangles.length; i++){
      triangles[i].set(3, 3, 1);
      System.out.println(triangles[i].toString());
    }
    System.out.println("4, 4, 4");
    for(int i = 0;i < triangles.length; i++){
      triangles[i].set(4, 4 ,4);
      System.out.println(triangles[i].toString());
    }
  }

}
