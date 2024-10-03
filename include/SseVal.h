#pragma once
#include "MiscDef.h"
#include <xmmintrin.h>

class SseVal
{
public:
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

	SseVal& SseAdd(SseVal const& val, AddOp const op);
	//SseVal& SseSub(SseVal const& val, SubOp const op);
	//SseVal& SseMul(SseVal const& val, MulOp const op);
	//SseVal& SseDiv(SseVal const& val, DivOp const op);
	//SseVal& SseMin(SseVal const& val, MinOp const op);
	//SseVal& SseMax(SseVal const& val, MaxOp const op);
	//SseVal& SseSqrt(SqrtOp const op);

	// SSE2
	union {
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
};

