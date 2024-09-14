#include <array>
#include <string>
#include <iostream>
using std::cout;

extern "C" double FtoC(double degreeF);
extern "C" double CtoF(double degreeC);

template <std::size_t N>
void printData(std::string const& name, std::array<double, N> const& data);

int main() {
	std::array<double, 5> temps = {
		-28.9, -17.8, 0.0, 32.2, -73.3
	};

	for (auto& n : temps) {
		n = CtoF(n);
	}
	printData("F", temps);

	for (auto& n : temps) {
		n = FtoC(n);
	}
	printData("C", temps);

	return 0;
}

template <std::size_t N>
void printData(std::string const& name, std::array<double, N> const& data) {
	cout << name << ":\n";
	for (auto const& n : data) {
		cout << "\t" << n;
	}
	cout << "\n";
}