// mainメソッドを含むFileCopyクラスを書く
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileCopy {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("使用法: java FileCopy srcfile dstfile");
            return;
        }

        String srcFilePath = args[0];
        String dstFilePath = args[1];

        File srcFile = new File(srcFilePath);
        File dstFile = new File(dstFilePath);

        if (!srcFile.exists()) {
            System.out.println("コピー元ファイルが存在しません: " + srcFilePath);
            return;
        }

        if (dstFile.exists()) {
            System.out.println("コピー先ファイルが既に存在します: " + dstFilePath);
            return;
        }

        try (FileInputStream fis = new FileInputStream(srcFile);
            FileOutputStream fos = new FileOutputStream(dstFile)) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }

            System.out.println("ファイルコピーが完了しました: " + srcFilePath + " -> " + dstFilePath);
        } catch (IOException e) {
            System.out.println("ファイルコピー中にエラーが発生しました: " + e.getMessage());
        }
    }
}

