#include <iostream>

extern "C" int AdderASM(int a, int b, int c);
int AdderCPP(int a, int b, int c);

int main() {
    int a = 2, b = 4, c = -2;

    int sum = AdderCPP(a, b, c);
    int sum2 = AdderASM(a, b, c);

    std::cout << sum << " == " << sum2 << " ?" << (sum == sum2 ? " " : " not ") << "equal\n";
}

int AdderCPP(int a, int b, int c) {
    return a + b + c;
}