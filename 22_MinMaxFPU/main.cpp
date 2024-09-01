#include <iostream>
#include <random>
#include <numeric>

using std::cout;

//extern "C" float r4_minFloat;
//extern "C" float r4_maxFloat;
extern "C" void MinMaxASM(float* data, int size, float* min, float* max);

const int SIZE = 10;

int main() {
	float* data = new float[SIZE];

	std::random_device rd;
	std::mt19937 rng(rd());

	std::uniform_int_distribution<> dist(-SIZE, SIZE);
	for (size_t i = 0; i < SIZE; ++i) {
		data[i] = static_cast<float>(dist(rng));
	}

	std::shuffle(data, data + SIZE, rng);

	float min;
	float max;
	MinMaxASM(data, SIZE, &min, &max);

	cout << "Values: ";
	for (int i = 0; i < SIZE; ++i) {
		cout << data[i] << " ";
	}
	cout << "\n";
	cout << "Min: " << min << "\n";
	cout << "Max: " << max << "\n";

	return 0;
}