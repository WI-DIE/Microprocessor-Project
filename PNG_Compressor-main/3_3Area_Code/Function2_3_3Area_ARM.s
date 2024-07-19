	AREA CONVERT, CODE, READONLY
	
	EXPORT Function2_3_3Area_ARM

Function2_3_3Area_ARM

	PUSH		{LR}		
	 
	LDR		R0, start_addr	 ; Write
	LDR     R1, start_addr_r ; READ
	LDR     R2, start_addr_g ; READ
	LDR		R3, start_addr_b ; READ
	LDR		R4, color_count
	
convert_loop 
	CMP     R3, R4        
	BEQ     end_convert   
	
	; 32bit R, G, B (5,6,7)
	LDRB     R5, [R1], #1
	LDRB     R6, [R2], #1  	
	LDRB     R7, [R3], #1  
	
	; Round1 
	ADD R8, R5, R6
	ADD R8, R8, R7
	MOV	R10, #0
	ADD R10, R10, R8, LSR #2  
    ADD R10, R10, R8, LSR #3    
	SUB	R10, R10, R8, LSR #4    
	STRB R10, [R0], #1
	
	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
start_addr_r  DCD     0x60000000
start_addr_g  DCD     0x60096000
start_addr_b  DCD     0x6012c000
color_count  DCD     0x601c2000		


	END