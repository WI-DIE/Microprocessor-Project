	AREA MEMORY, CODE, READONLY
	
	EXPORT Function4_1_1_ARM

Function4_1_1_ARM

	PUSH		{LR}		
	 
	LDR     R1, start_addr ; WRITE
	LDR     R2, start_addr ; READ
	LDR     R3, count     

convert_loop
	CMP     R3, R2        
	BEQ     end_convert   
	
    LDRB        R0, [R2], #1
    STRB        R0, [R1], #1
    LDRB        R0, [R2], #1
    STRB        R0, [R1], #1
    LDRB        R0, [R2], #1
    STRB        R0, [R1], #1
    ADD         R2, R2, #1

	B       convert_loop   

end_convert
	POP     {PC}          

start_addr  DCD     0x50000000
count       DCD     0x50258000 

	END