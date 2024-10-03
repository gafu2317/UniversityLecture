// mainメソッドを含むTriangleTesterクラスを書く
public class TriangleTester {
    public static void main(String[] args) {
        // 要素数3のTriangleの配列trianglesを生成する
        Triangle[] triangles = new Triangle[3];

        // 3辺の長さが異なる三角形を生成してtrianglesに格納する
        triangles[0] = new Triangle(3, 4, 5);

        // 二等辺三角形を生成してtrianglesに格納する
        triangles[1] = new Triangle(4, 3);

        // 正三角形を生成してtrianglesに格納する
        triangles[2] = new Triangle(4);

        // Triangleクラスの機能を確認する処理
        for (int i = 0; i < triangles.length; i++) {
            System.out.println((i + 1) + "つ目の三角形は" + triangles[i].toString());
            System.out.println("二等辺三角形かどうか " + triangles[i].isIsosceles());
            System.out.println("正三角形かどうか " + triangles[i].isEquilateral());
            if (i > 0) {
                System.out.println((i) + "つ目の三角形と" +(i + 1) + "つ目の三角形が合同かどうか " +triangles[i-1].equals(triangles[i]));
            }
            System.out.println();
        }
    }
}
