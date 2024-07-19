	AREA CONVERT, CODE, READONLY
	
	EXPORT Function1_2_3Area_ARM

Function1_2_3Area_ARM

	PUSH		{LR}		
	 
	LDR		R0, start_addr	 ; Write
	LDR     R1, start_addr_r ; READ
	LDR     R2, start_addr_g ; READ
	LDR		R3, start_addr_b ; READ
	LDR		R4, color_count
	
	MOV R12, #0 ; store / init 0
	
convert_loop
	CMP     R3, R4        
	BEQ     end_convert   
	; little endian / RRGRGGBB -> BBGGGRRR
	; development over head -> test efficiency
	
	; 32bit R, G, B (5,6,7)
	LDR     R5, [R1], #4
	LDR     R6, [R2], #4  	
	LDR     R7, [R3], #4  
	
	; Round1 
	AND R9, R5, #224
	AND R10, R6, #224
	AND R11, R7, #192
	LSR R10, R10, #3 ; 00011100      
	LSR R11, R11, #6 ; 00000011      
	ORR R12, R9, R10 
	ORR R12, R12, R11
	STRB R12, [R0], #1
	
	; Round2 
	LSR R5, R5, #8
	LSR R6, R6, #8
	LSR R7, R7, #8
	
	AND R9, R5, #224
	AND R10, R6, #224
	AND R11, R7, #192
	LSR R10, R10, #3 ; 00011100      
	LSR R11, R11, #6 ; 00000011      
	ORR R12, R9, R10 
	ORR R12, R12, R11
	STRB R12, [R0], #1
	
	; Round3
	LSR R5, R5, #8
	LSR R6, R6, #8
	LSR R7, R7, #8
	
	AND R9, R5, #224
	AND R10, R6, #224
	AND R11, R7, #192
	LSR R10, R10, #3 ; 00011100      
	LSR R11, R11, #6 ; 00000011      
	ORR R12, R9, R10 
	ORR R12, R12, R11
	STRB R12, [R0], #1
	
	; Round4 
	LSR R5, R5, #8
	LSR R6, R6, #8
	LSR R7, R7, #8
	
	AND R9, R5, #224
	AND R10, R6, #224
	AND R11, R7, #192
	LSR R10, R10, #3 ; 00011100      
	LSR R11, R11, #6 ; 00000011      
	ORR R12, R9, R10 
	ORR R12, R12, R11
	STRB R12, [R0], #1

	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
start_addr_r  DCD     0x60000000
start_addr_g  DCD     0x60096000
start_addr_b  DCD     0x6012c000
color_count  DCD     0x601c2000		


	END