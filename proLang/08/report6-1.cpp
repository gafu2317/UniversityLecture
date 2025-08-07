#include <iostream>
#include <cmath>

class Object {
public:
    virtual double area() = 0;
    virtual ~Object() {}
};

class Rectangle : public Object {
private:
    double x1, y1, x2, y2;

public:
    Rectangle(double _x1, double _y1, double _x2, double _y2) 
        : x1(_x1), y1(_y1), x2(_x2), y2(_y2) {}
    
    double area() override {
        return std::abs((x2 - x1) * (y2 - y1));
    }
};

class Circle : public Object {
private:
    double radius;

public:
    Circle(double _radius) : radius(_radius) {}
    
    double area() override {
        return M_PI * radius * radius;
    }
};

int main() {
    Rectangle rect(0, 0, 5, 4);
    Circle circle(3);
    
    std::cout << "Rectangle area: " << rect.area() << std::endl;
    std::cout << "Circle area: " << circle.area() << std::endl;
    
    Object* objects[] = {&rect, &circle};
    
    std::cout << "\nUsing polymorphism:" << std::endl;
    for (int i = 0; i < 2; i++) {
        std::cout << "Object " << i << " area: " << objects[i]->area() << std::endl;
    }
    
    return 0;
}