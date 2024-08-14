#include <iostream>
using std::cout;

#include <random>

extern "C" int CalcSquaresASM(int* x, int* y, int n);
int CalcSquaresCPP(int* x, int* y, int n);

class Arrays {
public:
	Arrays() = delete;
	Arrays(int n) : size(n), src(new int[n]), dest(new int[n]) {
		srand(42);
		for (int i = 0; i < size; ++i) {
			src[i] = rand() % 10;
		}
	}
	~Arrays() {
		delete[] src;
		delete[] dest;
	}

	typedef int(__cdecl* calcFn)(int*, int*, int);
	void Calc(const char* name, calcFn fnPtr) {
		int sum = fnPtr(src, dest, size);

		cout << name << ":\n\t";
		for (int i = 0; i < size; ++i) {
			cout << src[i];
			if (i != size - 1) {
				cout << ",\t";
			}
		}
		cout << "\n\t";
		for (int i = 0; i < size; ++i) {
			cout << dest[i];
			if (i != size - 1) {
				cout << ",\t";
			}
		}
		cout << "\n\tSum: " << sum << "\n";
	}

private:
	int* src;
	int* dest;
	int size;
};

const int ARR_SIZE = 10;

int main() {
	Arrays arr(ARR_SIZE);
	arr.Calc("CPP", &CalcSquaresCPP);
	arr.Calc("ASM", &CalcSquaresASM);
}

int CalcSquaresCPP(int* x, int* y, int n) {
	int sum = 0;
	for (int i = 0; i < n; ++i) {
		y[i] = x[i] * x[i];
		sum += y[i];
	}

	return sum;
}