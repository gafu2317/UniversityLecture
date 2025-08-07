#include <iostream>
#include <string>

class Comparable {
public:
    virtual bool isLessThan(Comparable* other) = 0;
    virtual void print() = 0;
    virtual ~Comparable() {}
};

class Double : public Comparable {
private:
    double value;

public:
    Double(double v) : value(v) {}
    
    bool isLessThan(Comparable* other) override {
        Double* d = dynamic_cast<Double*>(other);
        if (d) return value < d->value;
        return false;
    }
    
    void print() override {
        std::cout << value;
    }
};

class Char : public Comparable {
private:
    char value;

public:
    Char(char c) : value(c) {}
    
    bool isLessThan(Comparable* other) override {
        Char* c = dynamic_cast<Char*>(other);
        if (c) return value < c->value;
        return false;
    }
    
    void print() override {
        std::cout << value;
    }
};

class Person : public Comparable {
private:
    std::string name;
    int age;

public:
    Person(const std::string& n, int a) : name(n), age(a) {}
    
    bool isLessThan(Comparable* other) override {
        Person* p = dynamic_cast<Person*>(other);
        if (p) return age < p->age;
        return false;
    }
    
    void print() override {
        std::cout << name << " (" << age << "歳)";
    }
};

template<typename T>
void find_min(T* array[], int size) {
    if (size <= 0) return;
    
    T* min = array[0];
    for (int i = 1; i < size; i++) {
        if (array[i]->isLessThan(min)) {
            min = array[i];
        }
    }
    
    std::cout << "最小値: ";
    min->print();
    std::cout << std::endl;
}

int main() {
    std::cout << "=== Double クラスのテスト ===" << std::endl;
    Double d1(3.5), d2(1.2), d3(5.8), d4(2.1);
    Double* doubles[] = {&d1, &d2, &d3, &d4};
    find_min(doubles, 4);
    
    std::cout << "\n=== Char クラスのテスト ===" << std::endl;
    Char c1('z'), c2('a'), c3('m'), c4('b');
    Char* chars[] = {&c1, &c2, &c3, &c4};
    find_min(chars, 4);
    
    std::cout << "\n=== Person クラスのテスト ===" << std::endl;
    Person p1("田中", 25), p2("佐藤", 18), p3("鈴木", 30), p4("高橋", 22);
    Person* persons[] = {&p1, &p2, &p3, &p4};
    find_min(persons, 4);
    
    return 0;
}