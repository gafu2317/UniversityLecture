
// mainメソッドを含むをRevPolishNotationCalcクラスを書く
// public class RevPolishNotationCalc {
// }
import java.util.Stack;

public class RevPolishNotationCalc {

  public double evaluate(String[] tokens) throws IllegalArgumentException {
    Stack<Double> stack = new Stack<>();

    for (String token : tokens) {
      switch (token) {
        case "+":
          if (stack.size() < 2) {
            throw new IllegalArgumentException("Invalid expression: not enough operands");
          }
          stack.push(stack.pop() + stack.pop());
          break;
        case "-":
          if (stack.size() < 2) {
            throw new IllegalArgumentException("Invalid expression: not enough operands");
          }
          stack.push(-stack.pop() + stack.pop());
          break;
        case "x":
          if (stack.size() < 2) {
            throw new IllegalArgumentException("Invalid expression: not enough operands");
          }
          stack.push(stack.pop() * stack.pop());
          break;
        case "/":
          if (stack.size() < 2) {
            throw new IllegalArgumentException("Invalid expression: not enough operands");
          }
          double divisor = stack.pop();
          if (divisor == 0) {
            throw new ArithmeticException("Division by zero");
          }
          stack.push(stack.pop() / divisor);
          break;
        default:
          try {
            stack.push(Double.parseDouble(token));
          } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid token: " + token);
          }
          break;
      }
    }

    if (stack.size() != 1) {
      throw new IllegalArgumentException("Invalid expression: too many operands");
    }

    return stack.pop();
  }

  public static void main(String[] args) {
    RevPolishNotationCalc calc = new RevPolishNotationCalc();
    try {
      double result = calc.evaluate(args);
      System.out.println("結果: " + result);
    } catch (Exception e) {
      System.out.println("Error: " + e.getMessage());
    }
  }
}
