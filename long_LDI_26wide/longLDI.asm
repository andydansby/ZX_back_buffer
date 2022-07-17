; test vertical scroll



	;screen: defw #4000
	
	org $8000
	
start:

	halt
	ld sp, $c000 ; normal stack location, keep out of bankable
	
	di
	;transfers a byte of data from the memory location pointed to by hl to the memory location pointed to by de  then hl and de are incremented and bc is decremented
	
	;this is a brute force method that is a huge memory HOG
	;this test only does the first 8 lines


; about 18304 t-states to 32 y columns 4 character rows
start_copy:
	
	
	call copyBuffer



ei

pete_repete:
	jp pete_repete


	org #C000
data:
incbin "girl.bin"
;defb $000, $001, $002, $003, $004, $005, $006, $007, $008, $009, $00a, $00b, $00c, $00d, $00e, $00f, $010, $011, $012, $013, $014, $015, $016, $017, $018, $019, $01a, $01b;row 1
; 28 entries
end_of_data:

copyBuffer:
	ld hl, data; get the address of the data

character00:		
	ld de, $4000;0
	call copy_8_lines
	
character01:		
	ld de, $4020;8
	call copy_8_lines
	
character02:			
	ld de, $4040;16
	call copy_8_lines
	
character03:			
	ld de, $4060;16
	call copy_8_lines
		
character04:			
	ld de, $4080;0
	call copy_8_lines
	
character05:			
	ld de, $40a0;8
	call copy_8_lines
	
character06:			
	ld de, $40c0;16
	call copy_8_lines

character07:
	ld de, $40e0;16
	call copy_8_lines	

character08:
	ld de, $4800;0
	call copy_8_lines

character09:
	ld de, $4820;8
	call copy_8_lines
	
character10:
	ld de, $4840;16
	call copy_8_lines

character11:
	ld de, $4860;16
	call copy_8_lines
		
character12:
	ld de, $4880;0
	call copy_8_lines
	
character13:
	ld de, $48a0;8
	call copy_8_lines

character14:
	ld de, $48c0;16
	call copy_8_lines

character15:
	ld de, $48e0;16
	call copy_8_lines		
	
character16:
	ld de, $5000;0
	call copy_8_lines
	
character17:
	ld de, $5020;8
	call copy_8_lines

character18:
	ld de, $5040;16
	call copy_8_lines
	
character19:
	ld de, $5060;16
	call copy_8_lines
		
character20:
	ld de, $5080;0
	call copy_8_lines
	
character21:
	ld de, $50a0;8
	call copy_8_lines
	
character22:
	ld de, $50c0;16
	call copy_8_lines
	
character23:
	ld de, $50e0;16
	call copy_8_lines
ret

copy_8_lines:
	call left_right_copy	;0
	call Next_Line
	
	call left_right_copy	;1
	call Next_Line
	
	call left_right_copy	;2
	call Next_Line
	
	call left_right_copy	;3
	call Next_Line
	
	call left_right_copy	;4
	call Next_Line
	
	call left_right_copy	;5
	call Next_Line
	
	call left_right_copy	;6
	call Next_Line
	
	call left_right_copy	;7
	call Next_Line
	
	
	

ret

;moved to the next pixel line down
;in speccy display
Next_Line:
    inc d
	ld a, e
	sub $1a		;subtract 26 to get to start of next row
	ld e, a
ret					;10t

;LDI transfers a byte of data from the memory location pointed to by hl to the memory location pointed to by de.  then hl and de are incremented and bc is decremented
;LDD transfers a byte of data from the memory location pointed to by hl to the memory location pointed to by de.  then hl, de and bc are decremented
left_right_copy:
	; each ldi is 16 tstates
	ldi;0	16t
	ldi;1	16t
	ldi;2	16t
	ldi;3	16t
	ldi;4	16t
	ldi;5	16t
	ldi;6	16t
	ldi;7	16t
	ldi;8	16t
	ldi;9	16t
	ldi;10	16t
	ldi;11	16t
	ldi;12	16t
	ldi;13	16t
	ldi;14	16t
	ldi;15	16t
	ldi;16	16t
	ldi;17	16t
	ldi;18	16t
	ldi;19	16t
	ldi;20	16t
	ldi;21	16t
	ldi;22	16t
	ldi;23	16t
	ldi;24	16t
	ldi;25	16t
ret				;10t
