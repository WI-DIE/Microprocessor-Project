	AREA CONVERT, CODE, READONLY
	EXPORT Function2_3_Spec_ARM

Function2_3_Spec_ARM

	PUSH		{LR}		
	 
	LDR     R1, start_addr ; write
	LDR     R2, start_addr ; read
	LDR     R3, count     

gray_convert_loop
	CMP     R3, R2        
	BEQ     end_convert

	; 32bit R, G, B 
	LDRB    R4, [R2], #1
	LDRB	R5, [R2], #1
	LDRB	R6, [R2], #1
	ADD		R2, R2, #1
	
	ADD         R7, R4, R5       ; R + G
	ADD         R7, R7, R6       ; R + G + B
	
	MOV		R8, #0 ;
	ADD     R8, R8, R7, LSR #2    ; R8 += R7*0.25
    ADD     R8, R8, R7, LSR #3    ; R8 += R7*0.125
	SUB		R8, R8, R7, LSR #4    ; R8 -= R7*0.0625
	
	STRB    R8, [R1], #1  
	
	B      gray_convert_loop   
	
end_convert
    POP         {PC}        

start_addr  DCD     0x50000000
gray_count	DCD		0x50096000
count       DCD     0x50258000

	END