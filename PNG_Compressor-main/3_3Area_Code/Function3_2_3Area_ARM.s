	AREA CONVERT, CODE, READONLY
	
	EXPORT Function2_2_3Area_ARM

Function2_2_3Area_ARM

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
	
	; 32bit R, G, B (5,6,7)
	LDR     R5, [R1], #4
	LDR     R6, [R2], #4  	
	LDR     R7, [R3], #4  
	
	; Round1 
	AND R9, R5, #255
	AND R10, R6, #255
	AND R11, R7, #255
	ADD R9, R9, R10
	ADD R9, R9, R11
	MOV	R8, #0
	ADD R8, R8, R9, LSR #2  
    ADD R8, R8, R9, LSR #3    
	SUB	R8, R8, R9, LSR #4    
	STRB R8, [R0], #1
	
	; Round2
	LSR R5, R5, #8
	LSR R6, R6, #8
	LSR R7, R7, #8
	
	AND R9, R5, #255
	AND R10, R6, #255
	AND R11, R7, #255
	ADD R9, R9, R10
	ADD R9, R9, R11
	MOV	R8, #0
	ADD R8, R8, R9, LSR #2  
    ADD R8, R8, R9, LSR #3  
	SUB	R8, R8, R9, LSR #4   
	STRB R8, [R0], #1
	
	; Round3
	LSR R5, R5, #8
	LSR R6, R6, #8
	LSR R7, R7, #8
	
	AND R9, R5, #255
	AND R10, R6, #255
	AND R11, R7, #255
	ADD R9, R9, R10
	ADD R9, R9, R11
	MOV	R8, #0
	ADD R8, R8, R9, LSR #2   
    ADD R8, R8, R9, LSR #3  
	SUB	R8, R8, R9, LSR #4   
	STRB R8, [R0], #1
	
	; Round4
	LSR R5, R5, #8
	LSR R6, R6, #8
	LSR R7, R7, #8
	
	AND R9, R5, #255
	AND R10, R6, #255
	AND R11, R7, #255
	ADD R9, R9, R10
	ADD R9, R9, R11
	MOV	R8, #0
	ADD R8, R8, R9, LSR #2   
    ADD R8, R8, R9, LSR #3   
	SUB	R8, R8, R9, LSR #4  
	STRB R8, [R0], #1


	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
start_addr_r  DCD     0x60000000
start_addr_g  DCD     0x60096000
start_addr_b  DCD     0x6012c000
color_count  DCD     0x601c2000		


	END