#include <iostream>

// C++98互換の関数ポインタによる高階関数
typedef double (*FunctionPtr)(double);

// 関数をn回適用する高階関数
class ComposedFunction {
private:
    int n;
    FunctionPtr f;
public:
    ComposedFunction(int count, FunctionPtr func) : n(count), f(func) {}
    
    double operator()(double x) const {
        double result = x;
        for (int i = 0; i < n; i++) {
            result = f(result);
        }
        return result;
    }
};

ComposedFunction compose_n_times(int n, FunctionPtr f) {
    return ComposedFunction(n, f);
}

// テスト用関数群
double square(double x) {
    return x * x;
}

double add_one(double x) {
    return x + 1;
}

double multiply_by_two(double x) {
    return x * 2;
}

double add_half(double x) {
    return x + 0.5;
}

int main() {
    std::cout << "=== レポート8-3 高階関数テスト ===" << std::endl;
    
    // テスト1: square関数をn回適用
    std::cout << "square関数のテスト:" << std::endl;
    ComposedFunction square_twice = compose_n_times(2, square);
    std::cout << "square を2回適用 (初期値2): " << square_twice(2) << std::endl;  // 2^4 = 16
    
    ComposedFunction square_thrice = compose_n_times(3, square);
    std::cout << "square を3回適用 (初期値2): " << square_thrice(2) << std::endl;  // 2^8 = 256
    
    // テスト2: add_one関数をn回適用
    std::cout << "\nadd_one関数のテスト:" << std::endl;
    ComposedFunction add_five = compose_n_times(5, add_one);
    std::cout << "add_one を5回適用 (初期値10): " << add_five(10) << std::endl;  // 10 + 5 = 15
    
    // テスト3: multiply_by_two関数をn回適用
    std::cout << "\nmultiply_by_two関数のテスト:" << std::endl;
    ComposedFunction multiply_by_eight = compose_n_times(3, multiply_by_two);
    std::cout << "multiply_by_two を3回適用 (初期値3): " << multiply_by_eight(3) << std::endl;  // 3 * 8 = 24
    
    // テスト4: add_half関数をn回適用
    std::cout << "\nadd_half関数のテスト:" << std::endl;
    ComposedFunction add_half_four_times = compose_n_times(4, add_half);
    std::cout << "(x + 0.5) を4回適用 (初期値1.0): " << add_half_four_times(1.0) << std::endl;  // 1.0 + 2.0 = 3.0
    
    // テスト5: 0回適用（元の値がそのまま返る）
    std::cout << "\n0回適用のテスト:" << std::endl;
    ComposedFunction identity = compose_n_times(0, square);
    std::cout << "square を0回適用 (初期値5): " << identity(5) << std::endl;  // 5
    
    return 0;
}