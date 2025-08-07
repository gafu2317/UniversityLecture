#include <iostream>
#include <string>

class Student {
private:
    std::string name;
    std::string studentNumber;

public:
    void setName(const std::string& n) {
        name = n;
    }
    
    void setStudentNumber(const std::string& num) {
        studentNumber = num;
    }
    
    void show() {
        std::cout << "名前: " << name << std::endl;
        std::cout << "学籍番号: " << studentNumber << std::endl;
    }
};

int main() {
    Student student;
    
    student.setName("福富隆大");
    student.setStudentNumber("35714121");
    
    student.show();
    
    return 0;
}