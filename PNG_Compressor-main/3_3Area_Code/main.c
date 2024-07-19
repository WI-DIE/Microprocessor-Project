// main.c for Project_3Area
	
// for C code
#include "base.h"
#include <stdint.h>
#define START_ADDR  ((uint32_t *)0x50000000)
#define COUNT       ((uint32_t *)0x50258000)
#define COLOR_COUNT       ((uint32_t *)0x601c2000)

#define START_ADDR_R   ((uint32_t *)0x60000000)
#define START_ADDR_G   ((uint32_t *)0x60096000)
#define START_ADDR_B   ((uint32_t *)0x6012c000)

#define START_ADDR_8  ((uint8_t *)0x50000000)
#define COUNT_8       ((uint8_t *)0x50258000)
#define COLOR_COUNT_8       ((uint8_t *)0x601c2000)

#define START_ADDR_R_8   ((uint8_t *)0x60000000)
#define START_ADDR_G_8   ((uint8_t *)0x60096000)
#define START_ADDR_B_8   ((uint8_t *)0x6012c000)

//extern void Function1_1_3Area_ARM(); // 1byte read, 1byte write
//extern void Function1_2_3Area_ARM(); // 4byte read, 1byte write
//extern void Function2_1_3Area_ARM(); // 1byte read, 1byte write
//extern void Function2_2_3Area_ARM(); // 4byte read, 1byte write
//extern void Function2_3_3Area_ARM(); // 1byte read, 1byte write
//extern void Function3_1_3Area_ARM(); // 1byte read, 1byte write // 3_2_3 not enough register // faster than c

//extern void Function4_2_ARM();

// 4_2_C (R,G,B each)
void Function4_2_C(void) { // 4byte read, 1byte write
      uint32_t *read_ptr = START_ADDR;
      uint8_t *write_ptr_r = START_ADDR_R_8;
      uint8_t *write_ptr_g = START_ADDR_G_8;
      uint8_t *write_ptr_b = START_ADDR_B_8;
	
			uint32_t buffer;
      uint32_t *count = COUNT;

		while (read_ptr < count) {
				// RGB sequential 3 byte
				buffer = *read_ptr++;
				*write_ptr_r++ = buffer & 0xFF;
				*write_ptr_g++ = (buffer >> 8) & 0xFF;
				*write_ptr_b++ = (buffer >> 16)& 0xFF;
		}
}

// [copy paste function definition here]

int main(void){
	
	Function4_2_C(); // Default used for test
	
	//Function1_1_3Area_C(); // to 8-bit // hard-coding (4byte / 1st)
	//Function1_2_3Area_C(); // to 8-bit // for loop (4byte / 3rd)
	//Function1_3_3Area_C(); // to 8-bit // (1byte / 2nd)
	//Function2_3Area_C(); // to gray // (1byte)
	//Function3_3Area_C(); // to binary // (1byte)
	
	//Function1_1_3Area_ARM(); // to 8-bit // 1byte read, 1byte write (loop)
	//Function1_2_3Area_ARM(); // to 8-bit // 4byte read, 1byte write (hard coding)
	//Function2_1_3Area_ARM(); // to gray // 1byte read, 1byte write (loop)
	//Function2_2_3Area_ARM(); // to gray // 4byte read, 1byte write (hard coding)
	//Function2_3_3Area_ARM();
	//Function3_1_3Area_ARM(); // to binary // 1byte read, 1byte write (loop) // 3_2_3 not enough register // faster than c
	_sys_exit(0);
}

/* Memory Relocation 
// 4_2_C (R,G,B each)
void Function4_2_C(void) {
      uint8_t *read_ptr = START_ADDR;
      uint8_t *write_ptr_r = START_ADDR_R;
      uint8_t *write_ptr_g = START_ADDR_G;
      uint8_t *write_ptr_b = START_ADDR_B;
      uint8_t *count_ptr = COUNT_ADDR;

      while (read_ptr < count_ptr) {
            // Read R, G, B and skip A
            *write_ptr_r++ = *read_ptr++; // R
            *write_ptr_g++ = *read_ptr++; // G
            *write_ptr_b++ = *read_ptr++; // B
            read_ptr++;  // Skip A
      }
}

// to 8-bit
void Function1_1_3Area_C(void) { // 4byte
    uint32_t *src_r = START_ADDR_R;
		uint32_t *src_g = START_ADDR_G;
		uint32_t *src_b = START_ADDR_B;
    uint32_t *end = COLOR_COUNT;
	
    uint8_t *dst = START_ADDR_8;

    while (src_b < end) {
				uint32_t buffer_r = *src_r++; // 32bit
				uint32_t buffer_g = *src_g++; // 32bit
				uint32_t buffer_b = *src_b++; // 32bit
			
				uint8_t r = buffer_r & 224;
        uint8_t g = buffer_g & 224;
        uint8_t b = buffer_b & 192;
        uint8_t result = r | (g >> 3) | (b >> 6);
				*dst++ = result;
			
				r = buffer_r >> 8 & 224;
        g = buffer_g >> 8 & 224;
        b = buffer_b >> 8 & 192;
        result = r | (g >> 3) | (b >> 6);
				*dst++ = result;
			
				r = buffer_r >> 16 & 224;
        g = buffer_g >> 16 & 224;
        b = buffer_b >> 16 & 192;
        result = r | (g >> 3) | (b >> 6);
        *dst++ = result;
				
				r = buffer_r >> 24 & 224;
        g = buffer_g >> 24 & 224;
        b = buffer_b >> 24 & 192;
        result = r | (g >> 3) | (b >> 6);
        *dst++ = result;
    }
}

void Function1_2_3Area_C(void) { // 4byte read, 1byte write
    uint32_t *src_r = START_ADDR_R;
		uint32_t *src_g = START_ADDR_G;
		uint32_t *src_b = START_ADDR_B;
    uint32_t *end = COLOR_COUNT;
	
    uint8_t *dst = START_ADDR_8;
		
		uint8_t r; uint8_t g; uint8_t b; uint8_t result;
	
    while (src_b < end) {
			uint32_t buffer_r = *src_r++; // 32bit
			uint32_t buffer_g = *src_g++; // 32bit
			uint32_t buffer_b = *src_b++; // 32bit

			for(int i=0; i<4; i++){
				r = (buffer_r >> i*8)& 224;
        g = (buffer_g >> i*8) & 224;
        b = (buffer_b >> i*8) & 192;
        result = r | (g >> 3) | (b >> 6);
				*dst++ = result;
			}
    }
}

void Function1_3_3Area_C(void) { // 1byte read, 1byte write
    uint8_t *src_r = START_ADDR_R_8;
		uint8_t *src_g = START_ADDR_G_8;
		uint8_t *src_b = START_ADDR_B_8;
    uint8_t *end = COLOR_COUNT_8;
    uint8_t *dst = START_ADDR_8;
	
    while (src_b < end) {
				uint8_t r = *src_r++ & 224;
        uint8_t g = *src_g++ & 224;
        uint8_t b = *src_b++ & 192;
        uint8_t result = r | (g >> 3) | (b >> 6);
				*dst++ = result;
		}
}

// to gray
void Function2_3Area_C(void) { // 1byte read, 1byte write
    uint8_t *src_r = START_ADDR_R_8;
		uint8_t *src_g = START_ADDR_G_8;
		uint8_t *src_b = START_ADDR_B_8;
    uint8_t *end = COLOR_COUNT_8;
    uint8_t *dst = START_ADDR_8;
	
    while (src_b < end) {
				uint8_t r = *src_r++;
        uint8_t g = *src_g++;
        uint8_t b = *src_b++;
        uint8_t gray = (r+g+b)/3;
        *dst++ = gray; // Store the 8-bit
		}
}

// to binary
void Function3_3Area_C(void) { // 1byte read, 1byte write
    uint8_t *src_r = START_ADDR_R_8;
		uint8_t *src_g = START_ADDR_G_8;
		uint8_t *src_b = START_ADDR_B_8;
    uint8_t *end = COLOR_COUNT_8;
    uint8_t *dst = START_ADDR_8;
		uint8_t result=0;
		uint8_t round=0;
    while (src_b < end) {
				uint8_t r = *src_r++;
        uint8_t g = *src_g++;
        uint8_t b = *src_b++;
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
