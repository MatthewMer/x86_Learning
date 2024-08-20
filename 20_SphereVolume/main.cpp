#define _USE_MATH_DEFINES
#include <cmath>

#include <iostream>
using std::cout;

extern "C" float SphereVolumeASM(float radius);
float SphereVolumeCPP(float radius);

typedef float (__cdecl* fn)(float);
void CalcAndPrint(const char* name, fn fnPtr, float radius);

int main() {
	float radius = 2.f;

	CalcAndPrint("CPP", &SphereVolumeCPP, radius);
	CalcAndPrint("ASM", &SphereVolumeASM, radius);

	return 0;
}

void CalcAndPrint(const char* name, fn fnPtr, float radius) {
	cout << name << ": " << fnPtr(radius) << "\n";
}

float SphereVolumeCPP(float radius) {
	return (4.f / 3.f) * (float)M_PI * powf(radius, 3);
}