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
	cout << "addsd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n\n";

	a = { .d64 = {FLOAT_VAL, DOUBLE_VAL} };
	b = { .d64 = {DOUBLE_VAL, FLOAT_VAL} };

	cout << "a:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	cout << "b:\t" << b.d64[1] << "\t" << b.d64[0] << "\n";
	a.SseSub(b, SseVal::subpd);
	cout << "subpd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	a.SseSub(b, SseVal::subsd);
	cout << "subsd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n\n";

	a = { .d64 = {FLOAT_VAL, DOUBLE_VAL} };
	b = { .d64 = {DOUBLE_VAL, FLOAT_VAL} };

	cout << "a:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	cout << "b:\t" << b.d64[1] << "\t" << b.d64[0] << "\n";
	a.SseMul(b, SseVal::mulpd);
	cout << "mulpd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	a.SseMul(b, SseVal::mulsd);
	cout << "mulsd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n\n";

	a = { .d64 = {FLOAT_VAL, DOUBLE_VAL} };
	b = { .d64 = {DOUBLE_VAL, FLOAT_VAL} };

	cout << "a:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	cout << "b:\t" << b.d64[1] << "\t" << b.d64[0] << "\n";
	a.SseDiv(b, SseVal::divpd);
	cout << "divpd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	a.SseDiv(b, SseVal::divsd);
	cout << "divsd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n\n";

	a = { .d64 = {FLOAT_VAL, DOUBLE_VAL} };
	b = { .d64 = {DOUBLE_VAL, FLOAT_VAL} };

	cout << "a:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	cout << "b:\t" << b.d64[1] << "\t" << b.d64[0] << "\n";
	a.SseMin(b, SseVal::minsd);
	cout << "minsd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	a.SseMin(b, SseVal::minpd);
	cout << "minpd [a],[b]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n\n";

	double tmp = FLOAT_VAL * DOUBLE_VAL;
	a = { .d64 = {tmp, tmp} };

	cout << "a:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	a.SseSqrt(SseVal::sqrtsd);
	cout << "sqrtsd [a]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n";
	a.SseSqrt(SseVal::sqrtpd);
	cout << "sqrtpd [a]:\t" << a.d64[1] << "\t" << a.d64[0] << "\n\n";

	return 0;
}