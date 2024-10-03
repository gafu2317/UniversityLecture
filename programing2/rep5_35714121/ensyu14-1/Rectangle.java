// サブクラス/実装クラスRectangleを書く
public class Rectangle extends Shape implements Plane2D{
    private int width;
    private int height;
    public Rectangle(int width, int height){
        this.width = width;
        this.height = height;
    }
    public int getWidth(){
        return width;
    }
    public void setWidth(int width){
        this.width = width;
    }
    public int getHeight(){
        return height;
    }
    public void setHeight(int height){
        this.height = height;
    }
    @Override public String toString(){
        return "Rectangle(width:" + width + ", height:" + height + ")";
    }
    @Override public void draw(){
        for(int i = 0; i < height; i++){
            for(int j = 0; j < width; j++){
                System.out.print("*");
            }
            System.out.println();
        }
    }
    @Override public int getArea(){
        return width * height;
    }
}
