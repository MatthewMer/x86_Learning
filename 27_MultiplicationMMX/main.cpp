#include <iostream>

#include "MmxVal.h"

using std::cout;

uint64 constexpr MMX_VALUE = static_cast<uint64>(0x1000010000100001);

int main() {
	MMX::Mmx a{ .u64 = MMX_VALUE };
	MMX::Mmx b{ .u64 = MMX_VALUE };

	cout << "a:\t" << a.ToString_i16() << "\n";
	cout << "b:\t" << b.ToString_i16() << "\n";
	auto* res = a.MmxMultiply(b);
	cout << "a * b:\t" << res[1].ToString_i32() << res[0].ToString_i32() << "\n";
	delete[] res;

	return 0;
}