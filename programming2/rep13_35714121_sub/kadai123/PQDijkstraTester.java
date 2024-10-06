// mainメソッドを含むPQDijkstraTesterクラスを書く
// PQDijkstraをテストする
// 課題3でmainメソッドを実行するクラス

import java.io.FileNotFoundException;

public class PQDijkstraTester{
    public static void main(String[] args){
        PQDijkstra PQdijkstra = new PQDijkstra();
        try{
            PQdijkstra.loadGraph("sample.txt");
        }catch(FileNotFoundException e){
            e.printStackTrace();
        }
        for(int i = 0; i < PQdijkstra.nodes.size(); i++){
            int[] path = PQdijkstra.getShortestPath(0, i);
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
