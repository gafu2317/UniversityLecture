import java.util.Scanner;
import java.io.File;
class ScanTest{
	public static void main(String args[]){
		String fileName = args[0];
		try{
			Scanner scf = new Scanner(new File(fileName));
			while(scf.hasNextLine()){
				String s = scf.nextLine();
				//System.out.println(s);

				Scanner scs = new Scanner(s);
				scs.useDelimiter(",|:|\r\n|\n");

				if(!scs.hasNextInt()) break;

				int nodeId = scs.nextInt();
				System.out.print(nodeId + ":");

				String c = "";
				while(scs.hasNextInt()){
					int to = scs.nextInt();
					System.out.print(c + to);
					c = ",";
				}

				System.out.println();
			}
			scf.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
