#include <stdio.h>
#include <assert.h>
#include "math_functions.h"

int test_count = 0;
int test_passed = 0;

void run_test(const char* test_name, int condition) {
    test_count++;
    if (condition) {
        printf("✓ %s\n", test_name);
        test_passed++;
    } else {
        printf("✗ %s\n", test_name);
    }
}

void test_add() {
    run_test("add(2, 3) == 5", add(2, 3) == 5);
    run_test("add(-1, 1) == 0", add(-1, 1) == 0);
    run_test("add(0, 0) == 0", add(0, 0) == 0);
}

void test_subtract() {
    run_test("subtract(5, 3) == 2", subtract(5, 3) == 2);
    run_test("subtract(1, 1) == 0", subtract(1, 1) == 0);
    run_test("subtract(0, 5) == -5", subtract(0, 5) == -5);
}

void test_multiply() {
    run_test("multiply(3, 4) == 12", multiply(3, 4) == 12);
    run_test("multiply(0, 5) == 0", multiply(0, 5) == 0);
    run_test("multiply(-2, 3) == -6", multiply(-2, 3) == -6);
}

void test_divide() {
    run_test("divide(10, 2) == 5", divide(10, 2) == 5);
    run_test("divide(7, 3) == 2", divide(7, 3) == 2);
    run_test("divide(5, 0) == -1", divide(5, 0) == -1);
    run_test("divide(0, 5) == 0", divide(0, 5) == 0);
}

void test_factorial() {
    run_test("factorial(0) == 1", factorial(0) == 1);
    run_test("factorial(1) == 1", factorial(1) == 1);
    run_test("factorial(5) == 120", factorial(5) == 120);
    run_test("factorial(-1) == -1", factorial(-1) == -1);
}

void test_is_prime() {
    run_test("is_prime(2) == 1", is_prime(2) == 1);
    run_test("is_prime(3) == 1", is_prime(3) == 1);
    run_test("is_prime(4) == 0", is_prime(4) == 0);
    run_test("is_prime(17) == 1", is_prime(17) == 1);
    run_test("is_prime(1) == 0", is_prime(1) == 0);
    run_test("is_prime(0) == 0", is_prime(0) == 0);
}

void test_fibonacci() {
    run_test("fibonacci(0) == 0", fibonacci(0) == 0);
    run_test("fibonacci(1) == 1", fibonacci(1) == 1);
    run_test("fibonacci(5) == 5", fibonacci(5) == 5);
    run_test("fibonacci(7) == 13", fibonacci(7) == 13);
    run_test("fibonacci(-1) == -1", fibonacci(-1) == -1);
}

int main() {
    printf("Running unit tests...\n\n");
    
    test_add();
    test_subtract();
    test_multiply();
    test_divide();
    test_factorial();
    test_is_prime();
    test_fibonacci();
    
    printf("\n=== Test Results ===\n");
    printf("Tests run: %d\n", test_count);
    printf("Tests passed: %d\n", test_passed);
    printf("Tests failed: %d\n", test_count - test_passed);
    printf("Success rate: %.2f%%\n", (float)test_passed / test_count * 100);
    
    return (test_passed == test_count) ? 0 : 1;
}