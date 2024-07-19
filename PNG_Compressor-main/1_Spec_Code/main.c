// main.c for Project_Spec
#include "base.h"
	
// for C code
#include <stdint.h> // for C code

#define START_ADDR_8  ((uint8_t *)0x50000000)
#define COUNT_8       ((uint8_t *)0x50258000)

#define START_ADDR  ((uint32_t *)0x50000000)
#define COUNT       ((uint32_t *)0x50258000)

//extern void Function1_Spec_ARM();
//extern void Function2_1_Spec_ARM();
//extern void Function2_2_Spec_ARM(); 
//extern void Function2_3_Spec_ARM();
//extern void Function3_Spec_ARM();

// [Copy Paste Function Definition here]

int main(void){
	//Function1_Spec_C(); // to 8-bit // Little Endian, 4byte LDR is faster
	//Function2_Spec_C(); // to gray // no overflow in uint8, divide once is faster, Function2_1
	//Function3_Spec_C(); // to binary // Select Function2_1, mid value = 96, partial = 157
	
	//Function1_Spec_ARM(); // to 8-bit // Little Endian, 4byte LDR is faster
	//Function2_1_Spec_ARM(); // to gray // Faster than 2_2 (Select)
	//Function2_2_Spec_ARM(); // to gray // Slower than 2_1
	//Function3_Spec_ARM(); // to binary // So, Select Function2_1
	_sys_exit(0);
}



/*
// to 8-bit
void Function1_Spec_C(void) { 
    uint32_t *src = START_ADDR;
    uint32_t *end = COUNT;
    uint8_t *dst = (uint8_t *)START_ADDR;

    while (src < end) {
        uint32_t pixel = *src++;
				uint8_t r = (pixel) & 224;
        uint8_t g = (pixel >> 8) & 224; 
        uint8_t b = (pixel >> 16) & 192;

        uint8_t result = r | (g >> 3) | (b >> 6);
        *dst++ = result;
    }
}

// to gray
void Function2_Spec_C(void) { // 4byte

    uint32_t *src = START_ADDR;
    uint32_t *end = COUNT;
    uint8_t *dst = (uint8_t *)START_ADDR;

    while (src < end) {
        uint32_t pixel = *src++;
				uint8_t r = (pixel) & 255;
        uint8_t g = (pixel >> 8) & 255; 
        uint8_t b = (pixel >> 16) & 255;
        uint8_t gray = (r+g+b)/3;
        *dst++ = gray; // Store the 8-bit
    }
}

// to gray
void Function2_Spec_C(void) { // 1 byte

    uint8_t *src = START_ADDR_8;
    uint8_t *end = COUNT_8;
    uint8_t *dst = START_ADDR_8;

    while (src < end) {
				uint8_t r = (*src++) & 255;
        uint8_t g = (*src++) & 255; 
        uint8_t b = (*src++) & 255;
				src++;
        uint8_t gray = (r+g+b)/3;
        *dst++ = gray; // Store the 8-bit
    }
}

// to binary
void Function3_Spec_C(void) { // 4byte
	  uint32_t *src = START_ADDR; // read
    uint32_t *end = COUNT; // end of read
    uint8_t *dst = (uint8_t *)START_ADDR; // write
		uint8_t result=0;
		uint8_t round=0;
    while (src < end) {
			uint32_t pixel = *src++;
			uint8_t r = (pixel) & 255;
			uint8_t g = (pixel >> 8) & 255; 
			uint8_t b = (pixel >> 16) & 255;
			uint8_t gray = (r+g+b)/3;
			uint8_t bit = (gray > 127) ? 1 : 0; // 96, 157 test done
			result |= (bit << round);
			round++;
			if(round==8){
				*dst++=result;
				result = 0;
				round = 0;
			}
		}
}

void Function3_Spec_C(void) { // 1byte
	  uint32_t *src = START_ADDR; // read
    uint32_t *end = COUNT; // end of read
    uint8_t *dst = (uint8_t *)START_ADDR; // write
		uint8_t result=0;
		uint8_t round=0;
    while (src < end) {
			uint32_t pixel = *src++;
			uint8_t r = (pixel) & 255;
			uint8_t g = (pixel >> 8) & 255; 
			uint8_t b = (pixel >> 16) & 255;
			uint8_t gray = (r+g+b)/3;
			uint8_t bit = (gray > 127) ? 1 : 0; // 96, 157 test done
			result |= (bit << round);
			round++;
			if(round==8){
				*dst++=result;
				result = 0;
				round = 0;
			}
		}
}

int Total_Gray_C(void) { // result : 96
    uint32_t *src = START_ADDR;
    uint32_t *end = COUNT;
		long total=0;
    while (src < end) {
        uint32_t pixel = *src++;
				uint8_t r = (pixel) & 255;
        uint8_t g = (pixel >> 8) & 255; 
        uint8_t b = (pixel >> 16) & 255;
        uint8_t gray = (r+g+b)/3;
				total +=gray;
    }
		total /= 0x96000;
		return total;
}

int Partial_Gray_C(void) { // result : 157
    uint32_t *src = START_ADDR;
    uint32_t *end = COUNT;
		long partial=0;
		int cnt = 0;
    while (src < end) {
        uint32_t pixel = *src++;
				uint8_t r = (pixel) & 255;
        uint8_t g = (pixel >> 8) & 255; 
        uint8_t b = (pixel >> 16) & 255;
        uint8_t gray = (r+g+b)/3;
				if (gray > 96){
					partial +=gray;
					cnt++;
				}
    }
		partial /= cnt;
		return partial;
}

*/
