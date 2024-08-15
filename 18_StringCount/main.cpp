#include <iostream>
using std::cout;

extern "C" int CountChar(const char* str, const char c);

const std::string MY_STRING = "This is a test string";
const char C = 'i';

int main() {
	auto result = CountChar(MY_STRING.c_str(), C);

	cout << "Count of \'" << C << "\' in \"" << MY_STRING << "\": " << result << "\n";

	return 0;
}