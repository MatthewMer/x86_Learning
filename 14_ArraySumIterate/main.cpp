#include <iostream>
#include <random>
using std::cout;

extern "C" int CalcArraySumASM(int* x, int n);
int CalcArraySumCPP(int* x, int n);

const int ARR_SIZE = 10;

class Array {
public:
	Array() = delete;
	Array(int n) {
		size = n;
		arr = new int[size];

		srand(42);
		for (int i = 0; i < size; ++i) {
			arr[i] = rand() % 10;
		}
	}
	~Array() {
		delete[] arr;
	}

	typedef int(__cdecl* sumFn)(int*, int);
	void CalcAndPrint(const char* name, sumFn fnPtr) {
		int res = (*fnPtr)(arr, size);

		cout << name << ": ";
		for (int i = 0; i < size; ++i) {
			cout << arr[i];
			if (i != size - 1) {
				cout << " + ";
			}
		}
		cout << " = " << res << "\n";
	}

private:
	int* arr;
	int size;
};

int main() {
	Array arr(ARR_SIZE);

	arr.CalcAndPrint("CPP", &CalcArraySumCPP);
	arr.CalcAndPrint("ASM", &CalcArraySumASM);

	return 0;
}

int CalcArraySumCPP(int* x, int n) {
	int sum = 0;
	for (int i = 0; i < n; ++i) {
		sum += x[i];
	}
	return sum;
}