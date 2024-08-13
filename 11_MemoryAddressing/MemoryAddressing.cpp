// MemoryAddressing.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
using std::cout;

extern "C" int AddressingDemo(int i, int* v);
extern "C" int NumFibVals;

using std::cout;

int main()
{
	int* v = new int[4];

	for (int i = -1; i < 17; i++) {
		switch (AddressingDemo(i, v)) {
		case true:
			cout << "Value at index " << i << ":\n";
			cout << "Base register: " << v[0] << "\n";
			cout << "Base register + displacement: " << v[1] << "\n";
			cout << "Base register + index register: " << v[2] << "\n";
			cout << "Base register + index register * scale factor: " << v[3] << "\n";
			break;
		case false:
			cout << "Invalid index: " << i << "\n";
			break;
		}
	}
}
