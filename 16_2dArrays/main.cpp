#include <iostream>
#include <random>
using std::cout;
using std::endl;

int CalcArrayCubeCPP(const int* x, int* y, int nrows, int ncols);
extern "C" int CalcArrayCubeASM(const int* x, int* y, int nrows, int ncols);

template <int TROWS, int TCOLS>
class Array2D {
public:
	Array2D() {
		srand(42);
		for (int i = 0; i < TROWS; ++i) {
			for (int j = 0; j < TCOLS; ++j) {
				x[i][j] = rand() % 10;
				y[i][j] = 0;
			}
		}
	}

	typedef int(__cdecl* calcFn)(const int*, int*, int, int);
	void CalcAndPrint(const char* name, calcFn fnPtr) {
		int sum = fnPtr(static_cast<int const*>(&x[0][0]), &y[0][0], TROWS, TCOLS);

		cout << name << ":\n";
		cout << "input:\n";
		for (int i = 0; i < TROWS; ++i) {
			for (int j = 0; j < TCOLS; ++j) {
				cout << "\t" << x[i][j];
			}
			cout << "\n";
		}
		cout << "cubes:\n";
		for (int i = 0; i < TROWS; ++i) {
			for (int j = 0; j < TCOLS; ++j) {
				cout << "\t" << y[i][j];
			}
			cout << "\n";
		}
		cout << "\tSum: " << sum << "\n";
	}

private:
	int x[TROWS][TCOLS];
	int y[TROWS][TCOLS];
};

const int NROWS = 5;
const int NCOLS = 10;

int main() {
	Array2D<NROWS, NCOLS> arr2d;
	arr2d.CalcAndPrint("CPP", &CalcArrayCubeCPP);
	cout << "\n";
	arr2d.CalcAndPrint("ASM", &CalcArrayCubeASM);

	return 0;
}

int CalcArrayCubeCPP(const int* x, int* y, int nrows, int mcols) {
	int sum = 0;
	for (int i = 0; i < nrows; ++i) {
		for (int j = 0; j < mcols; ++j) {
			int k = i * mcols + j;
			y[k] = x[k] * x[k] * x[k];
			sum += y[k];
		}
	}
	return sum;
}