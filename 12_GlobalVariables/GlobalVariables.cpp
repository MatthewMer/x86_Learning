// GlobalVariables.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <format>
#include <iostream>

using std::cout;
using std::format;

extern "C" char GlChar = 10;
extern "C" short GlShort = 20;
extern "C" int GlInt = 30;
extern "C" long long GlLong = 0x00000000FFFFFFFF;

extern "C" void IntegerAddition(char a, short b, int c, long long d);

int main()
{
    IntegerAddition(3, 5, -37, 11);

    printf("char: %d\n", GlChar);
    printf("short: %d\n", GlShort);
    printf("int: %d\n", GlInt);
    printf("long long: %s\n", std::format("{:016x}", GlLong).c_str());
}