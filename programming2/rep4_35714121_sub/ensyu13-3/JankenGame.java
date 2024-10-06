// mainメソッドを含むJankenGameクラスを書く
public class JankenGame {
    public static void main(String[] args) {
        int winer = 0;// 1:player1の勝ち 2:player2の勝ち
        JankenPlayer[] JankenPlayers = new JankenPlayer[2];
        JankenPlayers [0] = new HumanPlayer();
        JankenPlayers [1] = new ComputerPlayer();
        int hund1 ;
        int hund2 ;
        System.out.println("じゃんけんをします。どちらかが勝つまで続けます。");
        do {
            hund1 = JankenPlayers [0].getHund();
            hund2 = JankenPlayers [1].getHund();
            System.out.println("あなた:" + HumanPlayer.getHandName(hund1));
            System.out.println("コンピュータ:" + ComputerPlayer.getHandName(hund2));
        } while (hund1 == hund2);
        if (hund1 == 0 && hund2 == 1 || hund1 == 1 && hund2 == 2 || hund1 == 2 && hund2 == 0) {
            System.out.println("あなたの勝ち");
            winer = 1;
        } else {
            System.out.println("コンピュータの勝ち");
            winer = 2;
        }
        System.out.println("続いてあっち向いてホイをします。");
        if (winer == 1) { System.out.println("どちらに指を向けますか？0;右 1:左");};
        if (winer == 2){ System.out.println("どちらに顔を向けますか？0;右 1:左");};
        int direction1 = JankenPlayers [0].getFinger();;
        int direction2 = JankenPlayers [1].getFinger();;
        System.out.println("あなた:" + HumanPlayer.getFingerName(direction1));
        System.out.println("コンピュータ:" + ComputerPlayer.getFingerName(direction2));
        if (direction1 == direction2) {
            if (winer == 1) {
                System.out.println("あなたの勝ち");
            } else {
                System.out.println("コンピュータの勝ち");
            }
        } else
        System.out.println("引き分け");
    }
}