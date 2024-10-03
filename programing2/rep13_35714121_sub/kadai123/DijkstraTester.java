// mainメソッドを含むDijkstraTesterクラスを書く
// Dijkstraをテストする
// 課題2でmainメソッドを実行するクラス
import java.io.FileNotFoundException;   
public class DijkstraTester{
    public static void main(String[] args){
        Dijkstra dijkstra = new Dijkstra();
        try{
            dijkstra.loadGraph("sample.txt");
        }catch(FileNotFoundException e){
            e.printStackTrace();
        }
        for(int i = 0; i < dijkstra.nodes.size(); i++){
            int[] path = dijkstra.getShortestPath(0, i);
            System.out.print("end=" + i + " path= ");
            for(int j = 0; j < path.length; j++){
                if (j != 0) {
                    System.out.print(",");
                }
                System.out.print(path[j]);
            }
            System.out.println();
        }
    }
}
