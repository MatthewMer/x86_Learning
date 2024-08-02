// SignedDivMul.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <string>

extern "C" int IntegerMulDiv(int a, int b, int* prod, int* quo, int* rem);

void check(int a, int b, int* prod, int* quo, int* rem);

int main()
{
    int* prod = new int;
    int* quo = new int;
    int* rem = new int;

    int a = 6;
    int b = 0;
    check(a, b, prod, quo, rem);

    b = 5;
    check(a, b, prod, quo, rem);
}

void check(int a, int b, int* prod, int* quo, int* rem) {
    bool not_zero = IntegerMulDiv(a, b, prod, quo, rem);

    std::string result = "Division by 0 detected ? " + (not_zero ? std::string("no") : std::string("yes")) + "\n";
    result += "a=" + std::to_string(a) + "; " + "b=" + std::to_string(b) + "\n";
    switch (not_zero) {
    case true:
        result += "a * b = " + std::to_string(*prod) + "\n";
        result += "a / b = " + std::to_string(*quo) + "\n";
        result += "a % b = " + std::to_string(*rem) + "\n";
        break;
    }

    std::cout << result;
}