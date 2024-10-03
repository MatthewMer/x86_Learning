#include <iostream>

#include "SseVal.h"

using std::cout;

constexpr float FLOAT_VAL = 2.71828182846f;
constexpr double DOUBLE_VAL = 3.14159265359f;

int main() {
	SseVal a{ .d64 = {FLOAT_VAL, DOUBLE_VAL} };
	SseVal b{ .d64 = {DOUBLE_VAL, FLOAT_VAL} };

	cout << "a:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	cout << "b:\t" << b.d64[1] << "\t" << b.d64[0] << "\n";
	a.SseAdd(b, SseVal::addpd);
	cout << "addpd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	a.SseAdd(b, SseVal::addsd);
	cout << "addsd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";

	return 0;
}