// mainメソッドを含むBinHexVarBaseValTesterクラスを書く
public class BinHexVarBaseValTester {
    public static void main(String[] args) {
        BinHexVarBaseValue[] varBaseVals = new BinHexVarBaseValue[4];//今回テストする4つの変数
        varBaseVals[0] = new BinHexVarBaseValue(2);
        varBaseVals[1] = new BinHexVarBaseValue(8);
        varBaseVals[2] = new BinHexVarBaseValue(10);
        varBaseVals[3] = new BinHexVarBaseValue(16);

        int base [] = {2, 8, 10, 16};//今回テストする基数の配列

        // baseの値を変更して、各要素を表示
        for(int j=0; j<base.length; j++) {
            BinHexVarBaseValue.setBase(base[j]);
            System.out.println("基数を" + base[j] + "に変更しました");
            for(int i=0; i<varBaseVals.length; i++) {
                System.out.println(varBaseVals[i].getValue() + "を" + base[j] + "進法で表示すると" + varBaseVals[i].toString() + "です");
            }
        }
    }
}