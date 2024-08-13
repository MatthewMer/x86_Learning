#include <iostream>

extern "C" void reverser(int* src, int* dest, int n);

int main()
{
    const int n = 10;

    int arr1[n], arr2[n];
    for (int i = 0; i < n; ++i) {
        arr1[i] = i;
        arr2[i] = 0;
    }

    reverser(arr1, arr2, n);

    bool b = true;
    for (int i = 0; i < n; ++i) {
        std::cout << arr2[i];
        if (i != n - 1) {
            std::cout << ", ";
        }

        if (arr1[i] != arr2[n - 1 - i]) {
            b = false;
        }
    }
    std::cout << "\n";

    std::string result = "";
    switch (b) {
    case true:
        result = "reversed";
        break;
    case false:
        result = "error";
        break;
    }

    std::cout << result << "\n";
}
