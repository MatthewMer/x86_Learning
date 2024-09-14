#include <type_traits>

#include "MmxVal.h"

namespace MMX {
	using std::to_string;
	
	namespace {
		template<typename T = size_t>
		_NODISCARD constexpr T const& clamp_valid(T const& in, T const& min, T const& max) {
			return std::min(max, std::max(min, in));
		}
	}

	string_t Mmx::ToString_i8() const {
		string_t res = "";
		for (size_t i = INT8_MAX_INDEX; i != -1; --i) {
			res += to_string(i8[i]);
			res += "\t";
		}
		return res;
	}

	string_t Mmx::ToString_i16() const {
		string_t res = "";
		for (size_t i = INT16_MAX_INDEX; i != -1; --i) {
			res += to_string(i16[i]);
			res += "\t";
		}
		return res;
	}

	string_t Mmx::ToString_i32() const {
		string_t res = "";
		for (size_t i = INT32_MAX_INDEX; i != -1; --i) {
			res += to_string(i32[i]);
			res += "\t";
		}
		return res;
	}

	string_t Mmx::ToString_u8() const {
		string_t res = "";
		for (size_t i = INT8_MAX_INDEX; i != -1; --i) {
			res += to_string(u8[i]);
			res += "\t";
		}
		return res;
	}

	string_t Mmx::ToString_u16() const {
		string_t res = "";
		for (size_t i = INT16_MAX_INDEX; i != -1; --i) {
			res += to_string(u16[i]);
			res += "\t";
		}
		return res;
	}

	string_t Mmx::ToString_u32() const {
		string_t res = "";
		for (size_t i = INT32_MAX_INDEX; i != -1; --i) {
			res += to_string(u32[i]);
			res += "\t";
		}
		return res;
	}

	string_t Mmx::ToString_i8(size_t const& i) const {
		return to_string(i8[clamp_valid(i, static_cast<size_t>(0), INT8_MAX_INDEX)]);
	}

	string_t Mmx::ToString_i16(size_t const& i) const {
		return to_string(i16[clamp_valid(i, static_cast<size_t>(0), INT16_MAX_INDEX)]);
	}

	string_t Mmx::ToString_i32(size_t const& i) const {
		return to_string(i32[clamp_valid(i, static_cast<size_t>(0), INT32_MAX_INDEX)]);
	}

	string_t Mmx::ToString_i64() const {
		return to_string(i64);
	}

	string_t Mmx::ToString_u8(size_t const& i) const {
		return to_string(u8[clamp_valid(i, static_cast<size_t>(0), INT8_MAX_INDEX)]);
	}

	string_t Mmx::ToString_u16(size_t const& i) const {
		return to_string(u16[clamp_valid(i, static_cast<size_t>(0), INT16_MAX_INDEX)]);
	}

	string_t Mmx::ToString_u32(size_t const& i) const {
		return to_string(u32[clamp_valid(i, static_cast<size_t>(0), INT32_MAX_INDEX)]);
	}

	string_t Mmx::ToString_u64() const {
		return to_string(u64);
	}
}