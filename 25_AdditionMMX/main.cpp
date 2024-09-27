#include <iostream>
using std::cout;

#include "MmxVal.h"

uint64 constexpr MMX_VALUE = static_cast<uint64>(0x8040201008040201);

int main() {
	MMX::Mmx a{ .u64 = MMX_VALUE };
	MMX::Mmx b{ .u64 = MMX_VALUE };

	
	cout << "saturated unsigned byte SIMD addition:\n";
	cout << "a:\t" << a.ToString_u8() << "\n";
	cout << "b:\t" << b.ToString_u8() << "\n";
	cout << "a + b:\t" << a.MmxAdd(b, MMX::paddusb).ToString_u8() << "\n";

	a = MMX::Mmx{ .u64 = MMX_VALUE };
	cout << "wraparound unsigned byte SIMD addition:\n";
	cout << "a:\t" << a.ToString_u8() << "\n";
	cout << "b:\t" << b.ToString_u8() << "\n";
	cout << "a + b:\t" << a.MmxAdd(b, MMX::paddb).ToString_u8() << "\n";

	a = MMX::Mmx{ .u64 = MMX_VALUE << 1 };
	cout << "saturated unsigned byte SIMD subtraction:\n";
	cout << "a:\t" << a.ToString_u8() << "\n";
	cout << "b:\t" << b.ToString_u8() << "\n";
	cout << "a - b:\t" << a.MmxSub(b, MMX::psubusb).ToString_u8() << "\n";

	a = MMX::Mmx{ .u64 = MMX_VALUE << 1 };
	cout << "wraparound unsigned byte SIMD subtraction:\n";
	cout << "a:\t" << a.ToString_u8() << "\n";
	cout << "b:\t" << b.ToString_u8() << "\n";
	cout << "a - b:\t" << a.MmxSub(b, MMX::psubb).ToString_u8() << "\n";

	return 0;
}
