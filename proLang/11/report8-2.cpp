#include <iostream>
#include <vector>
#include <algorithm>

void print_double(int x) {
    std::cout << x * 2 << " ";
}

bool is_even(int x) {
    return x % 2 == 0;
}

// C++98互換の関数オブジェクト
struct TripleFunction {
    void operator()(int x) const {
        std::cout << x * 3 << " ";
    }
};

struct GreaterThanSeven {
    bool operator()(int x) const {
        return x > 7;
    }
};

int main() {
    // C++98互換の初期化
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    std::vector<int> numbers(arr, arr + 10);
    
    std::cout << "=== レポート8-2 std::for_each ===" << std::endl;
    
    // 通常の関数を使った場合
    std::cout << "通常の関数を使った場合（各要素を2倍して表示）: ";
    std::for_each(numbers.begin(), numbers.end(), print_double);
    std::cout << std::endl;
    
    // 関数オブジェクトを使った場合（ラムダ式の代替）
    std::cout << "関数オブジェクトを使った場合（各要素を3倍して表示）: ";
    std::for_each(numbers.begin(), numbers.end(), TripleFunction());
    std::cout << std::endl;
    
    std::cout << "\n=== レポート8-2 std::find_if ===" << std::endl;
    
    // 通常の関数を使った場合
    std::vector<int>::iterator it1 = std::find_if(numbers.begin(), numbers.end(), is_even);
    if (it1 != numbers.end()) {
        std::cout << "通常の関数を使った場合（最初の偶数）: " << *it1 << std::endl;
    }
    
    // 関数オブジェクトを使った場合（ラムダ式の代替）
    std::vector<int>::iterator it2 = std::find_if(numbers.begin(), numbers.end(), GreaterThanSeven());
    if (it2 != numbers.end()) {
        std::cout << "関数オブジェクトを使った場合（7より大きい最初の数）: " << *it2 << std::endl;
    }
    
    return 0;
}