// インタフェースColoredWearableを書く．
public interface ColoredWearable extends Wearable, Color {
    int YELLOW = 4;
    void putOn();
    void putOff();
    void changeColor(int color);
}
