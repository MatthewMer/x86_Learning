#include <iostream>
using std::cout;

#include "MmxVal.h"

extern "C" MMX::Mmx __cdecl MmxAdd(MMX::Mmx a, MMX::Mmx b, MMX::MmxAddOp op);

int main() {
	MMX::Mmx a{ .u64 = static_cast<uint64>(0x8040201008040201) };
	MMX::Mmx b{ .u64 = static_cast<uint64>(0x8040201008040201) };

	
	cout << "saturated unsigned byte SIMD addition:\n";
	cout << "a:\t" << a.ToString_u8() << "\n";
	cout << "b:\t" << b.ToString_u8() << "\n";
	cout << "a + b:\t" << MmxAdd(a, b, MMX::MmxAddOp::paddusb).ToString_u8() << "\n";

	cout << "wraparound unsigned byte SIMD addition:\n";
	cout << "a:\t" << a.ToString_u8() << "\n";
	cout << "b:\t" << b.ToString_u8() << "\n";
	cout << "a + b:\t" << MmxAdd(a, b, MMX::MmxAddOp::paddb).ToString_u8() << "\n";

	return 0;
}
