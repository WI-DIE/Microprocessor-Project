	AREA MEMORY, CODE, READONLY
	
	EXPORT Function4_2_ARM

Function4_2_ARM

	PUSH		{LR}		
	
	LDR		R0, start_addr	 ; READ
	LDR     R1, start_addr_R ; WRITE
	LDR     R2, start_addr_G ; WRITE
	LDR		R3, start_addr_B ; WRITE
	LDR     R4, count     

convert_loop
	CMP     R4, R0        
	BEQ     end_convert   
	;R
    LDRB        R5, [R0], #1
    STRB        R5, [R1], #1
	;G
    LDRB        R5, [R0], #1
    STRB        R5, [R2], #1
	;B
    LDRB        R5, [R0], #1
    STRB        R5, [R3], #1
	;skip A
    ADD         R0, R0, #1

	B       convert_loop   

end_convert
	POP     {PC}          

start_addr	DCD     0x50000000
count	DCD     0x50258000 
start_addr_R	DCD     0x60000000
start_addr_G	DCD     0x60096000
start_addr_B	DCD     0x6012c000	
	END