	AREA CONVERT, CODE, READONLY
	
	EXPORT Function3_1_3Area_ARM

Function3_1_3Area_ARM

	PUSH		{LR}		
	 
	LDR		R0, start_addr	 ; Write
	LDR     R1, start_addr_r ; READ
	LDR     R2, start_addr_g ; READ
	LDR		R3, start_addr_b ; READ
	LDR		R9, color_count
	
	MOV R4, #0 ; round / init 0
	MOV R12, #0 ; result
convert_loop 
	
	CMP     R3, R9
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
	
	CMP R10, #157
    MOVGT R11, #1        
    MOVLE R11, #0      
	
    ORR R12, R12, R11, LSL R4
    
	ADD R4, R4, #1        
    CMP R4, #8                
	BNE convert_loop
	
    STRB R12, [R0], #1
	MOV R12, #0 ; result
    MOV R4, #0 ; round	
	
	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
start_addr_r  DCD     0x60000000
start_addr_g  DCD     0x60096000
start_addr_b  DCD     0x6012c000	
color_count  DCD     0x601c2000

	END