// 08_Conditionals.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

extern "C" int SignedMinA(int a, int b, int c);
extern "C" int SignedMaxA(int a, int b, int c);
extern "C" int SignedMinB(int a, int b, int c);
extern "C" int SignedMaxB(int a, int b, int c);

using std::cout;

int main()
{
    int a = 3, b = 5, c = -1;

    cout << "Min A : " << SignedMinA(a, b, c) << "\n";
    cout << "Max A : " << SignedMaxA(a, b, c) << "\n";
    cout << "Min B : " << SignedMinB(a, b, c) << "\n";
    cout << "Max B : " << SignedMaxB(a, b, c) << "\n";

    return 0;
}