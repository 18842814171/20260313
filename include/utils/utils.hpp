#ifndef UTIL_HPP
#define UTIL_HPP
#include <cassert>
#include <sstream>
#include <iostream>
#include <fstream>
#include <cstring>
#include <ctime>
#include <limits>
#ifndef DEBUG
#define DEBUG 1
#endif

/**
 * 运行时可改写（如 ./build/test ... --debug=0）。为 false 时：不输出 LOG/GAP、不挂接 LogRedirector 日志文件；
 * simulator 内非错误 stderr 亦被抑制。编译期 DEBUG!=1 时宏已为空，此开关仍可供 simulator 使用。
 */
inline bool& sim_debug_runtime_enabled() {
    static bool enabled = true;
    return enabled;
}

/**
 * 由测试入口与 CPU::run 协作维护：
 * - log_step_limit: 仅记录前 N 个 step 的 LOG（不影响实际运行步数）
 * - current_step / step_scope_enabled: CPU 运行时更新
 * - log_pipe_signals: 输出流水线寄存器字段日志（字段清单见 include/Pipe.hpp）
 */
struct SimLogConfig {
    static inline bool suppress_uart_mmio_logs = false;
    static inline size_t log_step_limit = std::numeric_limits<size_t>::max();
    static inline size_t current_step = 0;
    static inline bool step_scope_enabled = false;
    static inline bool log_pipe_signals = true;
};

#if DEBUG == 1
#include <iostream>


namespace
{
	namespace debug
	{
		std::string tab_counts;

		void _0__counts_pop()
		{
			if (!sim_debug_runtime_enabled()) return;
			if (!tab_counts.empty()) tab_counts.pop_back();
		}

		void _0__counts_push()
		{
			if (!sim_debug_runtime_enabled()) return;
			tab_counts += ' ';
		}

		void _0__log_if_func(const std::string& str, const bool cond)
		{
			if (!sim_debug_runtime_enabled() || !cond)
				return;
            if (SimLogConfig::step_scope_enabled &&
                SimLogConfig::current_step >= SimLogConfig::log_step_limit)
                return;
			std::cout << tab_counts << str << '\n';
		}

		void _0__log_func(const std::string& str)
		{
			if (!sim_debug_runtime_enabled()) return;
            if (SimLogConfig::step_scope_enabled &&
                SimLogConfig::current_step >= SimLogConfig::log_step_limit)
                return;
			std::cout << tab_counts << str << '\n';
		}

		void _0__gap_func()
		{
			if (!sim_debug_runtime_enabled()) return;
            if (SimLogConfig::step_scope_enabled &&
                SimLogConfig::current_step >= SimLogConfig::log_step_limit)
                return;
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

// ============================================================

// ============================================================

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

// Add these macros to your debug system
#define LOG_INST(a) debug::_0__log_func("[INST] " + std::string(a))
#define LOG_MEM(a) debug::_0__log_func("[MEM] " + std::string(a))
#define LOG_WB(a) debug::_0__log_func("[WB] " + std::string(a))
#define LOG_REG(a,b) debug::_0__log_func("[REG] x" + std::to_string(a) + " = " + HEX(b))
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
class Streambuf : public std::streambuf {
	private:
	std::ofstream file_;
	public:
	bool open(const std::string& filepath) {
		file_.open(filepath, std::ios::out | std::ios::trunc);
		return file_.is_open();
	}
	void close() { file_.close(); }
	protected:
	int overflow(int c) override {
		if (file_.is_open()) {
			file_.rdbuf()->sputc(static_cast<char>(c));
		}
		return c;
	}
	std::streamsize xsputn(const char* s, std::streamsize n) override {
		if (file_.is_open()) {
			file_.rdbuf()->sputn(s, n);
		}
		return n;
	}
};

class LogRedirector {
	private:
	Streambuf file_buf_;
	std::streambuf* old_buf_ = nullptr;
	bool active_ = false;

	static std::string make_filename(const std::string& elf_path) {
		auto now = std::time(nullptr);
		auto tm = *std::localtime(&now);
		const char* ts = "log/";
		//ts << std::put_time(&tm, "%Y%m%d_%H%M%S");
		std::string base = elf_path;
		size_t pos = base.rfind('/');
		if (pos != std::string::npos) base = base.substr(pos + 1);
		pos = base.rfind('.');
		if (pos != std::string::npos) base = base.substr(0, pos);
		return std::string(ts) + "-" + base + ".txt";
	}

	public:
	bool start(const std::string& elf_path) {
		std::string fname = make_filename(elf_path);
		if (!file_buf_.open(fname)) return false;
		old_buf_ = std::cout.rdbuf(&file_buf_);
		active_ = true;
		SimLogConfig::suppress_uart_mmio_logs = true;
		return true;
	}

	void stop() {
		if (!active_) return;
		std::cout.rdbuf(old_buf_);
		file_buf_.close();
		active_ = false;
		SimLogConfig::suppress_uart_mmio_logs = false;
	}
};
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



