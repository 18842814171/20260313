#ifndef UTIL_HPP
#define UTIL_HPP
#include <cassert>
#include <sstream>
#include <cstring>
#ifndef DEBUG
#define DEBUG 1
#endif

#if DEBUG == 1
#include <iostream>


namespace
{
	namespace debug
	{
		std::string tab_counts;

		void _0__counts_pop()
		{
			if (!tab_counts.empty()) tab_counts.pop_back();
		}

		void _0__counts_push()
		{
			tab_counts += ' ';
		}

		void _0__log_if_func(const std::string& str, const bool cond)
		{
			if (cond)
				std::cout << tab_counts << str << '\n';
		}

		void _0__log_func(const std::string& str)
		{
			std::cout << tab_counts << str << '\n';
		}

		void _0__gap_func()
		{
			std::cout << "==============================\n";
		}

		inline std::string to_hex(uint32_t value) {
			std::stringstream ss;
			ss << "0x" << std::hex << value;
			return ss.str();
		}
		
		inline std::string to_dec(uint32_t value) {
			return std::to_string(value);
		}

		template<typename T>
		std::string format(const char* fmt, T value) {
			char buffer[64];
			snprintf(buffer, sizeof(buffer), fmt, value);
			return std::string(buffer);
		}
	}
}


// Add a helper macro
#define SCOPE LogScope _scope
#define LOG(a) debug::_0__log_func(a)
#define LOGIF(a,b) debug::_0__log_if_func((a), (b))
#define GAP debug::_0__gap_func()
#define PUSH debug::_0__counts_push()
#define RUN(a) (a)
#define POP debug::_0__counts_pop()
#define HEX(value) debug::to_hex(value)
#define DEC(value) debug::to_dec(value)
struct LogScope {
    LogScope() { PUSH; }
    ~LogScope() { POP; }
};
#endif
#if DEBUG != 1
#define LOG(a)
#define LOGIF(a,b)
#define GAP
#define RUN(a)
#define PUSH
#define POP
#define HEX(value) 
#define DEC(value)
#endif
#endif

#ifndef OPEN_ASSERT
#define OPEN_ASSERT 1
#endif

#if OPEN_ASSERT == 1
#define ASSERT(a) assert(a)
#endif
#if OPEN_ASSERT != 1
#define ASSERT(a) 
#endif

#define ifThenOrThrow(cond, ifCondThen, Message) ASSERT(!(cond)  || (ifCondThen))