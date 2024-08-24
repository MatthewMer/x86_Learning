#include <iostream>

#include <array>
#include <functional>
#include <random>

using std::cout;

extern "C" bool CalcMeanStdevASM(double const* src, int const count, double* mean, double* stdev);
bool CalcMeanStdevCPP(double const* src, int const count, double* mean, double* stdev);

template<typename T, size_t N>
class Array {
public:
	using function_mean_stdev = std::function<bool(T const*, int const, T*, T*)>;

	Array();
	void CalcAndPrint(char const* name, function_mean_stdev fn);

private:
	std::array<T, N> data{};
	T mean = .0f;
	T stdev = .0f;
};

int main() {
	Array<double, 20> arr{};
	arr.CalcAndPrint("ASM", CalcMeanStdevASM);
	arr.CalcAndPrint("CPP", CalcMeanStdevCPP);
}

bool CalcMeanStdevCPP(double const* src, int const count, double* mean, double* stdev) {
	if (count <= 1) {
		return false;
	}

	double sum = .0f;
	for (int i = 0; i < count; ++i) {
		sum += src[i];
	}
	*mean = sum / count;

	sum = .0f;
	for (int i = 0; i < count; ++i) {
		double tmp = src[i] - *mean;
		sum += pow(tmp, 2);
	}
	*stdev = sqrt(sum / (count - 1));
	return true;
}

template<typename T, size_t N>
Array<T, N>::Array() {
	std::random_device rd;
	std::mt19937 rng(rd());
	std::uniform_int_distribution<std::mt19937::result_type> dist(0, 100);

	for (auto& n : this->data) {
		n = static_cast<T>(dist(rng));
	}
}

template<typename T, size_t N>
void Array<T, N>::CalcAndPrint(char const* name, function_mean_stdev fn) {
	cout << name << ":\n";

	if (fn(this->data.data(), static_cast<int>(this->data.size()), &mean, &stdev)) {
		cout << "\tmean: " << this->mean << "\n";
		cout << "\tstdev: " << this->stdev << "\n";
	}
	else {
		cout << "\tERROR\n";
	}
}