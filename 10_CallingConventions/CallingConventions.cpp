// CallingConventions.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

using std::cout;


extern "C" void CalculateSum(int a, int b, int c, int* s);

int main() {
    int a = 1, b = 2, c = 3;
    int* res = new int[3];
    
    cout << "a=" << a << "; b=" << b << "; c=" << c << "\n";

    CalculateSum(a, b, c, res);

    cout << "a + b + c = " << *res << "\n";
    cout << "pow(a,2) + pow(b,2) + pow(c,2) = " << *(res + 1) << "\n";
    cout << "pow(a,3) + pow(b,3) + pow(c,3) = " << *(res + 2) << "\n";

    delete[] res;
}