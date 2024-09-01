#include <iostream>
#include <random>
#include <functional>

using std::cout;
using std::random_device;
using std::mt19937;
using std::uniform_int_distribution;

struct Coords {
	float x;
	float y;

	friend std::ostream& operator<<(std::ostream& os, Coords const& obj) {
		os << obj.x << "/" << obj.y;
		return os;
	}
};

struct CoordContainer : public std::vector<Coords> {
	explicit CoordContainer(size_t size) {
		resize(size);
		
		auto _size = static_cast<int>(size);
		for (int i = 0; i < _size; ++i) {
			operator[](i) = { static_cast<float>(i * 2 % _size), static_cast<float>(i * 2 - _size) };
		}
		random_device rd;
		mt19937 rng(rd());
		uniform_int_distribution<> dist(0, static_cast<int>(size) - 1);
		for (size_t i = 0; i < size; ++i) {
			std::swap(this->operator[](i * 2 % size), this->operator[](dist(rng)));
		}
	}

	void CalcAndPrint(char const* name, std::function<void(Coords*, int, Coords*)> fn) {
		auto result = std::vector<Coords>(size());
		fn(data(), static_cast<int>(size()), result.data());

		cout << name << ":\n";
		for (size_t i = 0; i < size(); ++i) {
			cout << "\t" << this->operator[](i) << " -> " << result[i] << "\n";
		}
	}
};

extern "C" void __cdecl RectToPolarASM(Coords* data, int size, Coords*);

int main() {
	CoordContainer data(10);

	data.CalcAndPrint("polar", RectToPolarASM);

	return 0;
}