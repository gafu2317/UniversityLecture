import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        ArrayList<String> dataText = new ArrayList<String>();// データのファイルの名前を格納
        ArrayList<String> dataPath = new ArrayList<String>();// データのファイルのパスを格納
        String dirname = args[0];
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("result.txt", true))) {
            writer.write(dirname + "\n");
        } catch (IOException e) {
            e.printStackTrace();
        }
        inputdata(dirname, dataText, dataPath);// ディレクトリの中にあるデータのファイルをdataTextに格納
        for (int index = 0; index < 3; index++) {// 0:バブルソート、1:マージソート、2:基数ソート
            try (BufferedWriter writer = new BufferedWriter(new FileWriter("result.txt", true))) {
                switch (index) {
                    case 0:
                        writer.write("バブルソート");
                        break;
                    case 1:
                        writer.write("マージソート");
                        break;
                    case 2:
                        writer.write("基数ソート");
                        break;
                    default:
                        break;
                }
                writer.write("\n");
            } catch (IOException e) {
                e.printStackTrace();
            }
            String[] results = new String[dataPath.size()];
            int[] resultsdata = new int[dataPath.size()];
            for (int i = 0; i < dataPath.size(); i++) {// データのファイル数だけ繰り返す
                String singleDataPath = dataPath.get(i);
                String singleDataText = dataText.get(i);
                List<Integer> numbers = new ArrayList<>();
                try (BufferedReader br = new BufferedReader(new FileReader(singleDataPath))) {// ファイルを読み込む
                    String line;
                    while ((line = br.readLine()) != null) {
                        numbers.add(Integer.parseInt(line));// データのリストを作る
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
                // レポート用の出力
                switch (index) {
                    case 0:
                        long start = System.currentTimeMillis();
                        bubbleSort(numbers);
                        long end = System.currentTimeMillis();
                        results[i] = (singleDataText + "  " + (end - start) + "ms");
                        resultsdata[i] = (int) (end - start);
                        break;
                    case 1:
                        start = System.currentTimeMillis();
                        mergeSort(numbers);
                        end = System.currentTimeMillis();
                        results[i] = (singleDataText + "  " + (end - start) + "ms");
                        resultsdata[i] = (int) (end - start);
                        break;
                    case 2:
                        // 桁数をそろえたり、最大値を求めたりする部分は実行時間時間に含めない
                        List<Integer> formattedNumbers = new ArrayList<>();// 桁数を揃えた数字を格納
                        for (int num : numbers) {
                            formattedNumbers.add(Integer.parseInt(String.format("%08d", num)));
                        }
                        start = System.currentTimeMillis();
                        for (int digit = 1; digit <= 8; digit ++) {// exp:桁数
                            radixSort(formattedNumbers, digit);
                        }
                        end = System.currentTimeMillis();
                        results[i] = (singleDataText + "  " + (end - start) + "ms");
                        resultsdata[i] = (int) (end - start);
                        break;

                    default:
                        break;
                }
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter("result.txt", true))) {
                Arrays.sort(results, Comparator.comparingInt(String::length));
                for (String str : results) {
                    writer.write(str + "\n");
                }
                // 分散を求める
                double sum = 0;
                for (int num : resultsdata) {
                    sum += num;
                }
                double mean = sum / resultsdata.length;// 平均
                double squaredDifferenceSum = 0;
                for (int num : resultsdata) {
                    squaredDifferenceSum += Math.pow(num - mean, 2);
                }
                double variance = squaredDifferenceSum / resultsdata.length;
                writer.write("分散:" + variance + "\n");// 分散
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void inputdata(String dirname, ArrayList<String> dataText, ArrayList<String> dataPath) {// ディレクトリの中にあるデータをdataTextに格納
        File dir = new File(dirname);
        File[] files = dir.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isFile()) {
                    if (!isSortedFile(file)) {// ソートされたファイル以外を格納
                        dataText.add(file.getName());
                        dataPath.add(file.getAbsolutePath());
                    }
                } else if (file.isDirectory()) {
                    // 再帰的にサブディレクトリを処理する
                    inputdata(file.getAbsolutePath(), dataText, dataPath);
                }
            }
        }
    }

    public static boolean isSortedFile(File file) {
        if (file == null || file.getName() == null) {
            return false;
        }
        return file.getName().contains("sorted");
    }

    public static void bubbleSort(List<Integer> arr) {// バブルソート
        int n = arr.size();
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr.get(j) > arr.get(j + 1)) {
                    int temp = arr.get(j);
                    arr.set(j, arr.get(j + 1));
                    arr.set(j + 1, temp);
                }
            }
        }
    }

    public static void mergeSort(List<Integer> arr) {// マージソート
        if (arr.size() > 1) {
            int mid = arr.size() / 2;

            ArrayList<Integer> left = new ArrayList<>(arr.subList(0, mid));
            ArrayList<Integer> right = new ArrayList<>(arr.subList(mid, arr.size()));

            mergeSort(left);
            mergeSort(right);

            int i = 0, j = 0, k = 0;// i:左の配列のインデックス、j:右の配列のインデックス、k:元の配列のインデックス
            while (i < left.size() && j < right.size()) {// 二つの配列を小さいものから順にマージ
                if (left.get(i) < right.get(j)) {
                    arr.set(k, left.get(i));
                    i++;
                } else {
                    arr.set(k, right.get(j));
                    j++;
                }
                k++;
            }

            while (i < left.size()) {// 一つの配列しか残っていない場合
                arr.set(k, left.get(i));
                i++;
                k++;
            }

            while (j < right.size()) {// 一つの配列しか残っていない場合
                arr.set(k, right.get(j));
                j++;
                k++;
            }
        }
    }

    public static void radixSort(List<Integer> arr, int digit) {// 基数ソート

        int N = arr.size();
        int[][] buf = new int[10][N];
        int[] ctr = new int[10];// それぞれの列にいくつ入っているか 例：ctr[0]=3なら0列に3つのデータが入っている

        for (int i = 0; i <= 9; i++) {
            ctr[i] = 0;
        }

        for (int i = 0; i < N; i++) {
            int k = val(arr.get(i), digit);
            buf[k][ctr[k]++] = arr.get(i);
        }

        int t = 0;
        for (int i = 0; i <= 9; i++) {
            for (int j = 0; j <= ctr[i] - 1; j++) {
                arr.set(t++, buf[i][j]);
            }
        }
    }

    private static int val(int num, int digit) {
        return (int) (num / Math.pow(10, digit - 1)) % 10;
    }

}