#pragma once

#include <string>

#include "MiscDef.h"

namespace MMX {
	using string_t = std::string;
	using std::size_t;

	size_t constexpr INT8_MIN_INDEX = 0;
	size_t constexpr INT8_MAX_INDEX = 7;
	size_t constexpr INT16_MIN_INDEX = 0;
	size_t constexpr INT16_MAX_INDEX = 3;
	size_t constexpr INT32_MIN_INDEX = 0;
	size_t constexpr INT32_MAX_INDEX = 1;

	enum MmxAddOp : uint32 {
		paddb,			// packed byte add wraparound
		paddsb,			// packed byte add signed saturation
		paddusb,		// packed byte add unsigned saturation
		paddw,			// packed word add wraparound
		paddsw,			// packed word add signed saturation
		paddusw,		// packed word add unsigned saturation
		paddd,			// packed dword add wraparound
		paddq			// packed qword add wraparound
	};

	struct Mmx {
		union {
			// 64 bit per MMX register (x86)
			int8	i8[8];
			int16	i16[4];
			int32	i32[2];
			int64	i64;

			uint8	u8[8];
			uint16	u16[4];
			uint32	u32[2];
			uint64	u64;
		};

		_NODISCARD string_t ToString_i8() const;
		_NODISCARD string_t ToString_i16() const;
		_NODISCARD string_t ToString_i32() const;
		_NODISCARD string_t ToString_u8() const;
		_NODISCARD string_t ToString_u16() const;
		_NODISCARD string_t ToString_u32() const;

		_NODISCARD string_t ToString_i8(size_t const& i) const;
		_NODISCARD string_t ToString_i16(size_t const& i) const;
		_NODISCARD string_t ToString_i32(size_t const& i) const;
		_NODISCARD string_t ToString_i64() const;
		_NODISCARD string_t ToString_u8(size_t const& i) const;
		_NODISCARD string_t ToString_u16(size_t const& i) const;
		_NODISCARD string_t ToString_u32(size_t const& i) const;
		_NODISCARD string_t ToString_u64() const;
	};
}