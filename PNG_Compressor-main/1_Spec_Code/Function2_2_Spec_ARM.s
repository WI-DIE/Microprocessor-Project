	AREA CONVERT, CODE, READONLY
	EXPORT Function2_2_Spec_ARM

Function2_2_Spec_ARM

	PUSH		{LR}		
	 
	LDR     R1, start_addr ; write
	LDR     R2, start_addr ; read
	LDR     R3, count     
	

; we can use 2 algorithms here to make gray_convert_loop
; 1. average; G=(R+G=B)/3
; 2. min_max; G=(max(R,G,B)+min(R,G,B))/2; what we used here

gray_convert_loop
	CMP     R3, R2        
	BEQ     end_convert

	; 32bit R, G, B 
	LDR     R0, [R2], #4  
	MOV		R4, R0
	MOV     R5, R0, LSR #8 ; FF0A10 (GREEN)
	MOV     R6, R0, LSR #16 ; FF0A (BLUE)
	
	AND R4, R4, #255	;0b11111111	(RED)
	AND R5, R5, #255	;0b11111111 (GREEN)
	AND R6, R6, #255 	;0b11111111 (BLUE)
	
	; Find the maximum of R, G, B
	MOV     R7, R4      ; R7 = R
	CMP     R5, R7
	MOVGT   R7, R5      ; R7 = max(R, G)
	CMP     R6, R7
	MOVGT   R7, R6      ; R7 = max(B, max(R, G))

	; Find the minimum of R, G, B
	MOV     R8, R4      ; R8 = R
	CMP     R5, R8
	MOVLT   R8, R5      ; R8 = min(R, G)
	CMP     R6, R8
	MOVLT   R8, R6      ; R8 = min(B, min(R, G))

	ADD     R9, R7, R8  ; R9 = max(R, G, B) + min(R, G, B)	
	LSR		R9, R9, #1	; R9/2
	STRB    R9, [R1], #1  
	
	B      gray_convert_loop   
	
end_convert
    POP         {PC}        

start_addr  DCD     0x50000000
gray_count	DCD		0x50096000
count       DCD     0x50258000

	END