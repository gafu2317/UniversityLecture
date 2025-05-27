import org.junit.Test;
import static org.junit.Assert.*;
public class AccountTest { 
  // public static void main(String[] args){
  //   instantiate();
  // }
  @Test public void instantiate(){
    Account a= new Account("ミナト",30000);
    assertEquals("ミナト", a.getOwner());
    assertEquals(30000,a.getBalance());
  }
}

// public class AccountTest {
//   public static void main(String[] args){
//     testInstantiate();
//     testTransfer();
//   }
//   private static void testInstantiate(){
//     System.out.println("newできるかテスト");
//     Account a = new Account("ミナト",30000);
//     if(!"ミナト".equals(a.getOwner())){
//       System.out.println("失敗!");
//     }
//     if(30000 != a.getBalance() ){
//       System.out.println("失敗!");
//     }
//   }
//   private static void testTransfer(){
//     System.out.println("transferメソッドのテスト");
//     Account a = new Account("ミナト",30000);
//     Account b = new Account("佐藤",10000);
//     System.out.println("ミナトの残高:" + a.getBalance());
//     System.out.println("佐藤の残高:" + b.getBalance());
//     a.transfer(b,5000);
//     System.out.println("ミナトが佐藤に5000円送金");
//     System.out.println("ミナトの残高:" + a.getBalance());
//     System.out.println("佐藤の残高:" + b.getBalance());
//     if(25000 != a.getBalance()){
//       System.out.println("失敗!");
//     }
//     if(15000 != b.getBalance()){
//       System.out.println("失敗!");
//     }
//   }
// }