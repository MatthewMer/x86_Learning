#include <iostream>
#include <vector>
#include <random>
#include <string>
#include <functional>

using std::cout;
using std::random_device;
using std::mt19937;
using std::uniform_int_distribution;
using std::to_string;
using std::string;

// using linear regression: y = m * x + t
//							m = sum((x - x_avg) * (y - y_avg)) / sum((x - x_avg)**2)
//							t = y_avg - m * x_avg

struct datapair_t {
	int x;
	float y;
};

using container_t = std::vector<datapair_t>;
using iterator_t = container_t::iterator;
using function_t = std::function<bool(datapair_t*, int, float*, float*)>;

struct Data : private container_t {
public:
	Data(size_t const& size, float const& scatter, size_t const& start) : m_size(static_cast<int>(size)), m_scatter(scatter), m_start(static_cast<int>(start)){
		m_max_deviation = deviation(m_size);
	}

	void generate() {
		random_device rd;
		mt19937 rng(rd());
		uniform_int_distribution<int> dist(-m_size, m_size);

		resize(m_size);
		int i = m_start;
		std::transform(begin(), end(), begin(), [&](datapair_t const& n) -> datapair_t { return { i, (i++) + deviation(dist(rng)) }; });
	}

	void calcAndPrint(function_t const& fn) {
		if (fn(data(), m_size, &m, &t)) {
			printData();
			plotData();
			printLinearRegression();
		}
		else {
			cout << "ERROR\n";
		}
	}

	void printData() const {
		for (auto it = begin(); it != end(); ++it) {
			cout << "x = " << it->x << "; y = " << it->y << "\n";
		}
	}

	void plotData() const {
		int min = static_cast<int>((m_start - m_max_deviation) + .5f);
		int max = static_cast<int>((m_start + m_size + m_max_deviation) + .5f);

		bool** dots = new bool*[max - min + 1];
		for (int i = 0; i < max - min + 1; ++i) {
			dots[i] = new bool[m_size];
			std::fill(dots[i], dots[i] + m_size, false);
		}

		for (int i = 0; i < m_size; ++i) {
			auto const& val = operator[](i);
			dots[static_cast<int>(val.y + .5f) - min][val.x - m_start] = true;
		}

		string start_s = to_string(m_start);
		int start_len = start_s.length();

		int space = 2;

		for (int row = max; row >= min; --row) {
			for (int col = 0; col < m_size; ++col) {
				char c = ' ';
				if (dots[row - min][col]) {
					c = '*';
				}
				else if (row == 0 && col == 0) {
					c = '+';
				}
				else if(row == 0) {
					c = '-';
				}
				else if (col == 0) {
					c = '|';
				}
				cout << c;
				cout << std::string(space, row == 0 ? '-' : ' ');
			}
			cout << "\n";
			delete[] dots[row - min];
		}
		delete[] dots;
	}

	void printLinearRegression() {
		cout << "f(x) = " << m << " * x + " << t << "\n";
	}

private:
	float m_max_deviation;
	int m_size;
	float m_scatter;
	int m_start;

	float m;
	float t;

	template<typename T>
	constexpr float deviation(T const& val) const {
		return static_cast<float>(val) / m_size * m_scatter;
	}
};

extern "C" bool __cdecl leastSquares(datapair_t* data, int size, float* m, float* t);

int main() {
	Data data(30, 5.f, 0);
	data.generate();
	data.calcAndPrint(leastSquares);
}