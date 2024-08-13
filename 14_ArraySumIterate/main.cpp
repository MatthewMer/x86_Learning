#include <iostream>
#include <random>
using std::cout;

typedef int(__cdecl* sumFn)(int*, int);

extern "C" int CalcArraySumASM(int* x, int n);
int CalcArraySumCPP(int* x, int n);

void GenerateArray(int** x, int n);
void CalcAndPrint(sumFn fnPtr, int* x, int n);

const int ARR_SIZE = 10;

int main() {
	int* arr;
	GenerateArray(&arr, ARR_SIZE);

	cout << "CPP: ";
	CalcAndPrint(&CalcArraySumCPP, arr, ARR_SIZE);
	cout << "ASM: ";
	CalcAndPrint(&CalcArraySumASM, arr, ARR_SIZE);

	delete[] arr;
}

void GenerateArray(int** x, int n) {
	*x = new int[ARR_SIZE];
	srand(42);

	for (int i = 0; i < ARR_SIZE; ++i) {
		(*x)[i] = rand() % 10;
	}
}

void CalcAndPrint(sumFn fnPtr, int* x, int n) {
	int res = (*fnPtr)(x, n);

	for (int i = 0; i < n; ++i) {
		cout << x[i];
		if (i != n - 1) {
			cout << " + ";
		}
	}
	cout << " = " << res << "\n";
}

int CalcArraySumCPP(int* x, int n) {
	int sum = 0;
	for (int i = 0; i < n; ++i) {
		sum += x[i];
	}
	return sum;
}