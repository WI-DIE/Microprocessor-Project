	AREA CONVERT, CODE, READONLY
	
	EXPORT Function1_1_3Area_ARM

Function1_1_3Area_ARM

	PUSH		{LR}		
	 
	LDR		R0, start_addr	 ; Write
	LDR     R1, start_addr_r ; READ
	LDR     R2, start_addr_g ; READ
	LDR		R3, start_addr_b ; READ
	LDR		R4, color_count
	
	MOV R8, #0 ; store / init 0
	
convert_loop
	CMP     R3, R2        
	BEQ     end_convert   

	; 32bit R, G, B (5,6,7)
	LDRB     R5, [R1], #1
	LDRB     R6, [R2], #1  	
	LDRB     R7, [R3], #1  
	
	; R[7:5], G[7:5], B[7:6]
	AND R5, R5, #224
	AND R6, R6, #224
	AND R7, R7, #192

	LSR R6, R6, #3 ; 00011100      
	LSR R7, R7, #6 ; 00000011      
	
	ORR R8, R6, R5 
	ORR R8, R8, R7

	STRB    R8, [R0], #1   

	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
start_addr_r  DCD     0x60000000
start_addr_g  DCD     0x60096000
start_addr_b  DCD     0x6012c000
color_count  DCD     0x601c2000		


	END