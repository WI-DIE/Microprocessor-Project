// main.c for Project_24
	
// for C code
#include "base.h"
#include <stdint.h>
#define START_ADDR  ((uint32_t *)0x50000000)
#define COUNT       ((uint32_t *)0x50258000)

#define START_ADDR_8  ((uint8_t *)0x50000000)
#define COUNT_8       ((uint8_t *)0x50258000)

void Function4_1_2_C(void) {
		uint8_t *write_ptr = START_ADDR_8;
		uint32_t *read_ptr = START_ADDR;
		uint32_t buffer;
		uint32_t *count = COUNT;

		while (read_ptr < count) {
				// RGB sequential 3 byte
				buffer = *read_ptr++;
				*write_ptr++ = buffer & 0xFF;
				*write_ptr++ = (buffer >> 8) & 0xFF;
				*write_ptr++ = (buffer >> 16)& 0xFF;
		}
}

// [copy paste function definition here]

//extern void Function1_24_ARM();
//extern void Function2_24_ARM();
//extern void Function3_24_ARM();
//extern void Function4_1_1_ARM();
//extern void Function4_1_2_ARM();

int main(void){
	
	//Function4_1_1_C();
	Function4_1_2_C(); // Default used for Test
	//Function4_1_1_ARM();
	//Function4_1_2_ARM();
	//Function1_24_C(); // to 8-bit // Little Endian, 4byte LDR is faster
	//Function2_24_C(); // to gray // no overflow in uint8, divide once is faster, Function2_1
	//Function3_24_C(); // to binary // Select Function2_1, mid value = 96, partial = 157
	
	//Function1_24_ARM(); // to 8-bit // Little Endian, 4byte LDR is faster
	//Function2_24_ARM(); // to gray // Faster than 2_2 (Select)
	//Function3_24_ARM(); // to binary // So, Select Function2_1
	_sys_exit(0);
}

/* Memory Relocation 

// 4_1_C (24-bit) 
void Function4_1_1_C(void) { // 1byte read, 1byte write
		uint8_t *write_ptr = START_ADDR_8;
		uint8_t *read_ptr = START_ADDR_8;
		uint8_t *count = COUNT_8;

		while (read_ptr < count) {
				// RGB sequential 3 byte
				*write_ptr++ = *read_ptr++;
				*write_ptr++ = *read_ptr++;
				*write_ptr++ = *read_ptr++;
				read_ptr++;  // skip A
		}
}

void Function4_1_2_C(void) { // 4byte read, 1byte write (Faster)
		uint8_t *write_ptr = (uint8_t*)START_ADDR;
		uint32_t *read_ptr = START_ADDR;
		uint32_t buffer;
		uint32_t *count = COUNT;

		while (read_ptr < count) {
				// RGB sequential 3 byte
				buffer = *read_ptr++;
				*write_ptr++ = buffer & 0xFF;
				*write_ptr++ = (buffer >> 8) & 0xFF;
				*write_ptr++ = (buffer >> 16)& 0xFF;
		}
}
*/

/*
// to 8-bit
void Function1_24_C(void) { // 1byte read, 1byte write
    uint8_t *src = START_ADDR_8;
    uint8_t *end = COUNT_8;
    uint8_t *dst = START_ADDR_8;

    while (src < end) {
				uint8_t r =  (*src++) & 224;
        uint8_t g = (*src++) & 224;
        uint8_t b = (*src++) & 192;

        uint8_t result = r | (g >> 3) | (b >> 6);
        *dst++ = result;
    }
}

// to gray
void Function2_24_C(void) { // 1byte read, 1byte write
    uint8_t *src = START_ADDR_8;
    uint8_t *end = COUNT_8;
    uint8_t *dst = START_ADDR_8;

    while (src < end) {
				uint8_t r =  (*src++) & 255;
        uint8_t g = (*src++) & 255;
        uint8_t b = (*src++) & 255;
        uint8_t gray = (r+g+b)/3;
        *dst++ = gray; // Store the 8-bit
    }
}

// to binary
void Function3_24_C(void) { // 1byte read, 1byte write
    uint8_t *src = START_ADDR_8;
    uint8_t *end = COUNT_8;
    uint8_t *dst = START_ADDR_8;
		uint8_t result=0;
		uint8_t round=0;
    while (src < end) {
				uint8_t r =  (*src++) & 255;
        uint8_t g = (*src++) & 255;
        uint8_t b = (*src++) & 255;
        uint8_t gray = (r+g+b)/3;
				uint8_t bit = (gray > 157) ? 1 : 0; // 96, 127, 157 test done
				result |= (bit << round);
				round++;
				if(round==8){
					*dst++=result;
					result = 0;
					round = 0;
				}
		}
}
*/
