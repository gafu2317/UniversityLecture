# ソフトウェア工学 レポート課題15

<div style="text-align: right;">
2025年7月17日授業分  <br>
学籍番号：35714121  <br>
名前：福富隆大  <br>
<br>
</div>

## コードフォーマットと可読性の改善

### 修正前

```java
import java.util.*;
public class calc{
private int x,y;
public calc(int a,int b){x=a;y=b;}
public int add(){return x+y;}
public int sub(){return x-y;}
public void prnt(){System.out.println("x="+x+",y="+y);}
public static void main(String[]args){
calc c=new calc(10,5);
System.out.println("Sum: "+c.add());
System.out.println("Diff: "+c.sub());
c.prnt();
List<Integer>nums=Arrays.asList(1,2,3,4,5);
for(int n:nums){
if(n%2==0)System.out.print(n+" ");
}
}
}
```

### 修正後

```java
import java.util.*;

public class Calculator {
    private int firstNumber;
    private int secondNumber;
    
    public Calculator(int firstNumber, int secondNumber) {
        this.firstNumber = firstNumber;
        this.secondNumber = secondNumber;
    }
    
    public int add() {
        return firstNumber + secondNumber;
    }
    
    public int subtract() {
        return firstNumber - secondNumber;
    }
    
    public void printNumbers() {
        System.out.println("firstNumber=" + firstNumber + ", secondNumber=" + secondNumber);
    }
    
    public static void main(String[] args) {
        Calculator calculator = new Calculator(10, 5);
        
        System.out.println("Sum: " + calculator.add());
        System.out.println("Difference: " + calculator.subtract());
        calculator.printNumbers();
        
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
        System.out.print("Even numbers: ");
        for (int number : numbers) {
            if (number % 2 == 0) {
                System.out.print(number + " ");
            }
        }
        System.out.println();
    }
}
```
