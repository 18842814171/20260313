#pragma once
#include <assert.h>
#include <cstddef>
#include <cstring>
#include <climits>

#define NEEDCHECK 0

#if NEEDCHECK == 1
#define CHECK(a) assert(a)
#endif

#if NEEDCHECK != 1
#define CHECK(a) 
#endif

//============================右移============================
// 逻辑右移
inline int logicalRightShift(int i, int amount)
{
	CHECK(amount >= 0 && amount < 32);
#if RIGHTSHIFTINMATH
	unsigned i2 = i2uKeepBits(i);
	i2 >>= amount;
	return u2iKeepBits(i2);
#else
	return i >> amount;
#endif
}
// 逻辑右移
inline long long logicalRightShift(long long i, int amount)
{
	CHECK(amount >= 0 && amount < 64);
#if RIGHTSHIFTINMATH
	unsigned long long i2 = ll2ullKeepBits(i);
	i2 >>= amount;
	return ULL2LLKeepBits(i2);
#else
	return i >> amount;
#endif
}
// 逻辑右移
inline unsigned int logicalRightShift(unsigned int i, int amount)
{
	CHECK(amount >= 0 && amount < 32);
	return i >> amount;
}
// 逻辑右移
inline unsigned long long logicalRightShift(unsigned long long i, int amount)
{
	CHECK(amount >= 0 && amount < 64);
	return i >> amount;
}

// 算数右移
inline int arithmeticRightShift(int i, int amount)
{
	CHECK(amount >= 0 && amount < 32);
#if RIGHTSHIFTINMATH
	return i >> amount;
#else
	if (!(i & INT_MIN)) return i >> amount;
	return ~((~i) >> amount);
#endif
}
// 算数右移
inline long long arithmeticRightShift(long long i, int amount)
{
	CHECK(amount >= 0 && amount < 64);
#if RIGHTSHIFTINMATH
	return i >> amount;
#else
	if (!(i & LLONG_MIN)) return i >> amount;
	return ~((~i) >> amount);
#endif
}
// 算数右移
inline unsigned int arithmeticRightShift(unsigned int i, int amount)
{
	CHECK(amount >= 0 && amount < 32);
	if (!(i & 0X80000000U)) return i >> amount;
	return ~((~i) >> amount);
}
// 算数右移
inline unsigned long long arithmeticRightShift(unsigned long long i, int amount)
{
	CHECK(amount >= 0 && amount < 64);
	if (!(i & 0X8000000000000000U)) return i >> amount;
	return ~((~i) >> amount);
}
