#pragma once
#include "MiscDef.h"
#include <xmmintrin.h>
#include <functional>
#include <string>
#include <cassert>
#include <format>
#include <sstream>

// SSE2 register
union XMM{
	double64 d64[2];
	float32	f32[4];

	int64 i64[2];
	int32 i32[4];
	int16 i16[8];
	int8 i8[16];

	uint64 u64[2];
	uint32 u32[4];
	uint16 u16[8];
	uint8 u8[16];

	__m128 m128;
	__m64 m64[2];
};

class SseVal
{
public:
	using string_t = std::string;
	using stringstream_t = std::stringstream;
	using index_t = std::size_t;
	using format_t = std::function<std::ios_base& __CLRCALL_OR_CDECL(std::ios_base& ios)>;
	using tostring_t = std::function<string_t()>;

	enum AddOp {
		addss,
		addsd,
		addps,
		addpd
	};

	enum SubOp {
		subss,
		subsd,
		subps,
		subpd
	};

	enum MulOp {
		mulss,
		mulsd,
		mulps,
		mulpd
	};

	enum DivOp {
		divss,
		divsd,
		divps,
		divpd
	};

	enum MinOp {
		minss,
		minsd,
		minps,
		minpd
	};

	enum MaxOp {
		maxss,
		maxsd,
		maxps,
		maxpd
	};

	enum SqrtOp {
		sqrtss,
		sqrtsd,
		sqrtps,
		sqrtpd
	};

	enum AndOp {
		andps, 
		andpd,
		andnps,
		andnpd
	};

	SseVal& SseAdd(SseVal const& val, AddOp const op);
	SseVal& SseSub(SseVal const& val, SubOp const op);
	SseVal& SseMul(SseVal const& val, MulOp const op);
	SseVal& SseDiv(SseVal const& val, DivOp const op);
	SseVal& SseMin(SseVal const& val, MinOp const op);
	SseVal& SseMax(SseVal const& val, MaxOp const op);
	SseVal& SseSqrt(SqrtOp const op);
	SseVal& SseAnd(SseVal const& val, AndOp const op);
	

	template<typename T>
		requires std::is_arithmetic_v<T>
	string_t to_string(format_t fn = std::dec) {
		stringstream_t ss{};
		fn(ss);

		T* v = nullptr;
		if constexpr (std::is_same_v<double64, T>) {
			v = xmm.d64;
		}
		else if constexpr (std::is_same_v<float32, T>) {
			v = xmm.f32;
		}
		else if constexpr (std::is_same_v<int64, T>) {
			v = xmm.i64;
		}
		else if constexpr (std::is_same_v<int32, T>) {
			v = xmm.i32;
		}
		else if constexpr (std::is_same_v<int16, T>) {
			v = xmm.i16;
		}
		else if constexpr (std::is_same_v<int8, T>) {
			v = xmm.i8;
		}
		else if constexpr (std::is_same_v<uint64, T>) {
			v = xmm.u64;
		}
		else if constexpr (std::is_same_v<uint32, T>) {
			v = xmm.u32;
		}
		else if constexpr (std::is_same_v<uint16, T>) {
			v = xmm.u16;
		}
		else if constexpr (std::is_same_v<uint8, T>) {
			v = xmm.u8;
		}
		else {
			assert(false && "not castable");
		}

		for (size_t i = sizeof(__m128) / sizeof(T) - 1; i < -1; --i) {
			ss << v[i] << "\t";
		}
		return ss.str();
	}

	XMM xmm;
};

