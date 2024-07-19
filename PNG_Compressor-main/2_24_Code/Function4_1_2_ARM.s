	AREA MEMORY, CODE, READONLY
	
	EXPORT Function4_1_2_ARM

Function4_1_2_ARM

	PUSH		{LR}		
	 
	LDR     R1, start_addr ; WRITE
	LDR     R2, start_addr ; READ
	LDR     R3, count     

convert_loop
	CMP     R3, R2        
	BEQ     end_convert   
	
    LDR		R0, [R2], #4 ; FF0A100F
	MOV     R5, R0, LSR #8 ; FF0A10 (GREEN)
	MOV     R6, R0, LSR #16 ; FF0A (BLUE)
	AND		R4, R0, #0xFF
	AND 	R5, R5, #0xFF
	AND 	R6, R6,#0xFF
	STRB    R4, [R1], #1  
	STRB    R5, [R1], #1  
	STRB    R6, [R1], #1  
	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
count       DCD     0x50258000 

	END