// クラスWearableComputerを書く．
public class WearableComputer implements Wearable {
    private String name;
    public WearableComputer(String name) {
        this.name = name;
    }
    @Override public void putOn() {
        System.out.println(name + " ON!!");
    }
    @Override public void putOff() {
        System.out.println(name + " OFF!!");
    }
}
