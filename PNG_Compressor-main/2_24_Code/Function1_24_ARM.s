	AREA CONVERT, CODE, READONLY
	
	EXPORT Function1_24_ARM

Function1_24_ARM

	PUSH		{LR}		
	 
	LDR     R1, start_addr ; write
	LDR     R2, start_addr ; read
	LDR     R3, count     
	
	MOV R7, #0 ; store / init 0
	
convert_loop
	CMP     R3, R2        
	BEQ     end_convert   

	; 32bit R, G, B  
	LDRB     R4, [R2], #1
	LDRB     R5, [R2], #1  	
	LDRB     R6, [R2], #1  
	;ADD		R2, R2, #1 ; meaning less for compiler optimization
	
	; R[7:5], G[7:5], B[7:6]
	AND R4, R4, #224
	AND R5, R5, #224
	AND R6, R6, #192

	LSR R5, R5, #3 ; 00011100      
	LSR R6, R6, #6 ; 00000011      
	
	ORR R7, R4, R5 
	ORR R7, R7, R6

	STRB    R7, [R1], #1   

	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
count       DCD     0x50258000 

	END