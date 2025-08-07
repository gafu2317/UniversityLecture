#include <iostream>

class Kyoshitsu {
private:
    int zaseki;
    int tsukue;
    int projector;
    int kokuban;

public:
    Kyoshitsu() {
        zaseki = 0;
        tsukue = 0;
        projector = 0;
        kokuban = 0;
        std::cout << "デフォルトコンストラクタが呼ばれました" << std::endl;
    }
    
    Kyoshitsu(int _zaseki, int _tsukue, int _projector, int _kokuban) {
        zaseki = _zaseki;
        tsukue = _tsukue;
        projector = _projector;
        kokuban = _kokuban;
        std::cout << "パラメータ付きコンストラクタが呼ばれました" << std::endl;
    }
    
    ~Kyoshitsu() {
        std::cout << "デストラクタが呼ばれました" << std::endl;
    }
    
    void display() {
        std::cout << "席の数: " << zaseki << std::endl;
        std::cout << "机の数: " << tsukue << std::endl;
        std::cout << "プロジェクタの数: " << projector << std::endl;
        std::cout << "黒板の数: " << kokuban << std::endl;
        std::cout << std::endl;
    }
};

int main() {
    std::cout << "=== デフォルトコンストラクタのテスト ===" << std::endl;
    Kyoshitsu room1;
    room1.display();
    
    std::cout << "=== パラメータ付きコンストラクタのテスト ===" << std::endl;
    Kyoshitsu room2(50, 25, 1, 2);
    room2.display();
    
    return 0;
}