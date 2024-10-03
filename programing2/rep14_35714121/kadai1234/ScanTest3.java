import java.util.Scanner;
import java.io.File;
class ScanTest3{
	public static void main(String args[]){
		String fileName = args[0];
		try{
			Scanner scf = new Scanner(new File(fileName));

			scf.useDelimiter(",|:|\r\n|\n");

			int numOfNodes = scf.nextInt();
			int numOfEdges = scf.nextInt();
			System.out.println(numOfNodes + "," + numOfEdges);

			for(int i = 0;i < numOfEdges;i++){
				int edgeId = scf.nextInt();
				int edgeNodeU = scf.nextInt();
				int edgeNodeV = scf.nextInt();
				int edgeCost = scf.nextInt();
				System.out.println(
					edgeId + ":" +
					edgeNodeU + "," + edgeNodeV + "," +
					edgeCost);
			}

			scf.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
