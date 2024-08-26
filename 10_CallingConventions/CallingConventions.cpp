// CallingConventions.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <functional>
#include <iostream>
#include <cassert>
#include <random>

// comment ASM_CALL define to run the highlevel calls -> compiler will generate basically the same functionality
#define ASM_CALL

using std::cout;

typedef void(__cdecl* callee_cdecl)(int const, int const, int const, int*);
typedef void(__stdcall* callee_stdcall)(int const, int const, int const, int*);
typedef void(__fastcall* callee_fastcall)(int const, int const, int const, int*);

extern "C" void __cdecl Caller_cdecl(callee_cdecl callee, int const a, int const b, int const c, int* s);
extern "C" void __cdecl Caller_stdcall(callee_stdcall callee, int const a, int const b, int const c, int* s);
extern "C" void __cdecl Caller_fastcall(callee_fastcall callee, int const a, int const b, int const c, int* s);

extern "C" void __cdecl CalculateSum_cdecl(int const a, int const b, int const c, int* s);
extern "C" void __stdcall CalculateSum_stdcall(int const a, int const b, int const c, int* s);
extern "C" void __fastcall CalculateSum_fastcall(int const a, int const b, int const c, int* s);

template<typename T>
class SumContainer {
public:
    template<typename Tfn>
    using caller = std::function<void(Tfn const, T const, T const, T const, T*)>;

    SumContainer() {
        std::random_device rd;
        std::mt19937 rng(rd());
        std::uniform_int_distribution<std::mt19937::result_type> dist(1, 5);

        T* vals = &a;       // not recommended
        std::fill(vals, vals + 3, 0);
        std::transform(vals, vals + 3, vals, [&](T& n) -> T { return n + dist(rng); });
    }

    template<typename Tfn>
    void CalcAndPrint(char const* name, caller<Tfn> caller, Tfn callee) {
        ClearRes();

        #ifdef ASM_CALL
        caller(callee, a, b, c, res);
        #else
        callee(a, b, c, res);
        #endif

        PrintRes(name);
    }

    // __thiscall:
    //	    -caller passes this using ECX
    //	    -pushes remaining arguments in reverse order onto the stack
    //      ->callee manages arguments on stack
    void CalcAndPrintThis() {
        ClearRes();

        // inline asm basically is the same as calling the member method
        #ifdef ASM_CALL
        _asm {
            mov ecx, this
            call dword ptr[CalculateSum_thiscall]
        }
        #else
        CalculateSum_thiscall();
        #endif

        PrintRes("__thiscall");
    }

    void __thiscall CalculateSum_thiscall();

    T const& Get(size_t const& index) {
        assert(0 <= index && index < sizeof(res) / sizeof(res[0]));
        return res[index];
    }

private:
    T a = 1;
    T b = 2;
    T c = 3;
    T res[3] = { 0,0,0 };

    void PrintRes(char const* name) {
        cout << name << ":\n";
        cout << "\ta=" << a << "; b=" << b << "; c=" << c << "\n";
        cout << "\ta + b + c = "                      << Get(0) << "\n";
        cout << "\tpow(a,2) + pow(b,2) + pow(c,2) = " << Get(1) << "\n";
        cout << "\tpow(a,3) + pow(b,3) + pow(c,3) = " << Get(2) << "\n";
    }

    constexpr void ClearRes() {
        std::fill(res, res + 3, 0);
    }
};

int main() {
    SumContainer<int> data{};
    data.CalcAndPrint<callee_cdecl>("__cdecl", Caller_cdecl, CalculateSum_cdecl);
    data.CalcAndPrint<callee_stdcall>("__stdcall", Caller_stdcall, CalculateSum_stdcall);
    data.CalcAndPrint<callee_fastcall>("__fastcall", Caller_fastcall, CalculateSum_fastcall);

    data.CalcAndPrintThis();
}

template<typename T>
void __thiscall SumContainer<T>::CalculateSum_thiscall() {
    __asm {
        sub esp, 12         // "allocate" 12 bytes

        // load arguments
        mov eax, [ecx]
        mov ebx, [ecx + 4]
        mov edx, [ecx + 8]

        // a + b + c
        mov[ebp - 12], eax
        add[ebp - 12], ebx
        add[ebp - 12], edx

        // a* a + b * b + c * c
        imul eax, eax
        imul ebx, ebx
        imul edx, edx
        mov[ebp - 8], eax
        add[ebp - 8], ebx
        add[ebp - 8], edx

        // a* a + b * b + c * c
        imul eax, [ecx]
        imul ebx, [ecx + 4]
        imul edx, [ecx + 8]
        mov[ebp - 4], eax
        add[ebp - 4], ebx
        add[ebp - 4], edx

        // save results
        mov eax, [ebp - 12]
        mov[ecx + 12], eax
        mov eax, [ebp - 8]
        mov[ecx + 16], eax
        mov eax, [ebp - 4]
        mov[ecx + 20], eax

        add esp,12
    }
}