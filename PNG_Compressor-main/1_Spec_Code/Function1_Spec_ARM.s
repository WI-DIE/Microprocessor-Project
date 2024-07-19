	AREA CONVERT, CODE, READONLY
	
	EXPORT Function1_Spec_ARM

Function1_Spec_ARM

	PUSH		{LR}		
	 
	LDR     R1, start_addr ; write
	LDR     R2, start_addr ; read
	LDR     R3, count     
	
	MOV R7, #0 ; store / init 0
	
convert_loop
	CMP     R3, R2        
	BEQ     end_convert   

	; 32bit R, G, B  
	LDR     R0, [R2], #4  
	
	; assumption: R0 = 0F100AFF
	; MOV     R4, R0, LSR #24 ;0F (RED)
	; MOV     R5, R0, LSR #16 ;0F10 (GREEN)
	; MOV     R6, R0, LSR #8 ;0F100A (BLUE)
	
	; Fact: R0 = FF0A100F
	MOV		R4, R0
	MOV     R5, R0, LSR #8 ; FF0A10 (GREEN)
	MOV     R6, R0, LSR #16 ; FF0A (BLUE)
	
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