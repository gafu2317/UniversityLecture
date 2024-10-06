import java.io.File;

public class DirectoryLister {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("使用方法: java DirectoryLister <directory>");
            return;
        }
        String dirname = args[0];
        printList(dirname, "");
    }
    
    public static void printList(String dirname, String indent) {
        File dir = new File(dirname);
        if (!dir.exists()) {
            System.out.println("ディレクトリが存在しません: " + dirname);
            return;
        }
        if (!dir.isDirectory()) {
            System.out.println("ディレクトリではありません: " + dirname);
            return;
        }
        
        File[] files = dir.listFiles();
        if (files != null) {
            for (File file : files) {
                System.out.println(indent + "- " + file.getName());
                if (file.isDirectory()) {
                    // 再帰的にサブディレクトリを処理する
                    printList(file.getAbsolutePath(), indent + "  ");
                }
            }
        }
    }
}