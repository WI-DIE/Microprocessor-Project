	AREA CONVERT, CODE, READONLY
	
	EXPORT Function3_Spec_ARM

Function3_Spec_ARM

	PUSH		{LR}		
	 
	LDR     R1, start_addr ; write
	LDR     R2, start_addr ; read
	LDR     R3, count     
	
	MOV R9, #0 ; result
    MOV R10, #0 ; round

; we can use 2 algorithms here to make gray_convert_loop
; 1. average; G=(R+G=B)/3; (what we used here)
; 2. min_max; G=max(R,G,B)+min(R,G,B)

gray_convert_loop
	CMP     R3, R2        
	BEQ     end_convert   

	; 32bit R, G, B 
	LDR     R0, [R2], #4  
	MOV		R4, R0
	MOV     R5, R0, LSR #8 ; FF0A10 (GREEN)
	MOV     R6, R0, LSR #16 ; FF0A (BLUE)
	
	AND R4, R4, #255	;0b11111111	
	AND R5, R5, #255	;0b11111111
	AND R6, R6, #255 	;0b11111111
	
	ADD         R7, R4, R5       ; R + G
	ADD         R7, R7, R6       ; R + G + B
	
	MOV		R8, #0 ;
	ADD     R8, R8, R7, LSR #2    ; R8 += R7*0.25
    ADD     R8, R8, R7, LSR #3    ; R8 += R7*0.125
	SUB		R8, R8, R7, LSR #4    ; R8 -= R7*0.0625

    CMP R8, #127        
    MOVGT R11, #1        
    MOVLE R11, #0      
	
    ORR R9, R9, R11, LSL R10
    
	ADD R10, R10, #1        
    CMP R10, #8                
	BNE gray_convert_loop
	
    STRB R9, [R1], #1
	MOV R9, #0 ; result
    MOV R10, #0 ; round	
	B	gray_convert_loop   
	
end_convert
    POP         {PC}        

start_addr  DCD     0x50000000
gray_count	DCD		0x50096000
count       DCD     0x50258000

	END