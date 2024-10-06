// Shapeのサブクラスかつ抽象クラスAbstLineを書く
public abstract class AbstLine extends Shape{
    private int length;
    public AbstLine(int length){
        this.length = length;
    }
    public int getLength(){
        return length;
    }
    public void setLength(int length){
        this.length = length;
    }
    @Override public String toString(){
        return "AbstLine(length:" + length + ")";
    }
}
