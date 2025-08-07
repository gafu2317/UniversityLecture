#include <iostream>

// (1) 2つの整数を引数として取り、その和を返す関数
int add_function(int a, int b) {
    return a + b;
}

// (2) "A"をn回表示するクラス
class PrintA {
    int count;
public:
    PrintA(int n) : count(n) {}
    void operator()() const {
        for (int i = 0; i < count; i++) {
            std::cout << "A";
        }
    }
};

// ラムダ式を返す関数の代替
PrintA create_print_a(int n) {
    return PrintA(n);
}

int main() {
    // (1) 2つの整数の和を返す関数（ラムダ式の代替）
    int (*add)(int, int) = add_function;
    
    // テストコード
    std::cout << "=== レポート8-1 (1) ラムダ式テスト ===" << std::endl;
    std::cout << "add(3, 5) = " << add(3, 5) << std::endl;
    std::cout << "add(10, 20) = " << add(10, 20) << std::endl;
    std::cout << "add(-5, 8) = " << add(-5, 8) << std::endl;
    
    // (2) ラムダ式を返す関数の代替
    PrintA (*f)(int) = create_print_a;
    
    // テストコード
    std::cout << "\n=== レポート8-1 (2) ラムダ式を返す関数テスト ===" << std::endl;
    std::cout << "f(3)(): ";
    f(3)();
    std::cout << std::endl;
    
    std::cout << "f(5)(): ";
    f(5)();
    std::cout << std::endl;
    
    std::cout << "f(0)(): ";
    f(0)();
    std::cout << std::endl;
    
    return 0;
}