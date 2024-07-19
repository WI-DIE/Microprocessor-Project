#include "base.h"
#include <stdint.h> // for C code
#define START_ADDR  ((uint8_t *)0x50000000)

// https://en.wikipedia.org/wiki/Integer_overflow
// C's unsigned integer types are modulo in the LIA-1 sense
// in that overflows or out-of-bounds results silently wrap.

void Test_overflow_1(void){
	uint8_t *write = START_ADDR;
	uint8_t r1=100;
	uint8_t b1=100;
	uint8_t g1=100;
	uint8_t result1 = (r1+b1+g1)/3;
	*write = result1;
}

void Test_overflow_2(void){
	uint8_t *write = START_ADDR+1;
	uint8_t r1=100;
	uint8_t b1=100;
	uint8_t g1=100;
	uint8_t result2 = (r1/3+b1/3+g1/3);
	*write = result2;
}

int main() {
	Test_overflow_1();
	Test_overflow_2();
	_sys_exit(0);
}