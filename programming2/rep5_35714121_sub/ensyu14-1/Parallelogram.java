// サブクラス/実装クラスParallelogramを書く
//parallelogramとは平行四辺形のことである！．
public class Parallelogram extends Shape implements Plane2D{
    private int width;
    private int height;

    public Parallelogram(int width, int height){
        this.width = width;//底辺の幅
        this.height = height;//高さ
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
        return "Parallelogram(width:" + width + ", height:" + height + ")";
    }

    @Override public void draw(){
        for(int i = 0; i < height; i++){
            for(int j = 0; j < i; j++){
                System.out.print(" ");
            }
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