#include <iostream>
using std::cout;

#include "MmxVal.h"

uint64 constexpr MMX_VALUE = static_cast<uint64>(0x0080004000200010);

int main() {
	MMX::Mmx a{ .u64 = MMX_VALUE };
	uint32 s = 8;

	cout << "word SIMD shift left logical:\n";
	cout << "a:\t" << a.ToString_u16() << "\n";
	cout << "a << " << s << ":\t" << a.MmxShift(s, MMX::psllw).ToString_u16() << "\n";

	cout << "word SIMD shift right arithmetic:\n";
	cout << "a:\t" << a.ToString_u16() << "\n";
	cout << "a >> " << s << ":\t" << a.MmxShift(s, MMX::psraw).ToString_u16() << "\n";

	cout << "word SIMD shift right logical:\n";
	cout << "a:\t" << a.ToString_u16() << "\n";
	cout << "a >> " << s << ":\t" << a.MmxShift(s, MMX::psrlw).ToString_u16() << "\n";

	return 0;
}