#include <iostream>

class IntArray {
protected:
    int size;
    int* array;

public:
    IntArray(int _size) {
        size = _size;
        array = new int[size];
        for (int i = 0; i < size; i++) array[i] = 0;
    }
    
    ~IntArray() {
        delete[] array;
        std::cout << "destructor called" << std::endl;
    }
    
    void print_array() {
        for (int i = 0; i < size; i++) 
            std::cout << i << ": " << array[i] << std::endl;
    }
};

class ExtendedIntArray : public IntArray {
public:
    ExtendedIntArray(int _size) : IntArray(_size) {}
    
    void set(int index, int value) {
        if (index >= 0 && index < size) {
            array[index] = value;
        } else {
            std::cout << "Index out of bounds!" << std::endl;
        }
    }
    
    int sum() {
        int total = 0;
        for (int i = 0; i < size; i++) {
            total += array[i];
        }
        return total;
    }
};

int main() {
    ExtendedIntArray a(5);
    
    std::cout << "初期状態:" << std::endl;
    a.print_array();
    std::cout << "合計: " << a.sum() << std::endl << std::endl;
    
    a.set(0, 10);
    a.set(1, 20);
    a.set(2, 30);
    a.set(3, 40);
    a.set(4, 50);
    
    std::cout << "値設定後:" << std::endl;
    a.print_array();
    std::cout << "合計: " << a.sum() << std::endl;
    
    return 0;
}