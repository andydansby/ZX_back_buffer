;optimization suggestions by catmeows
;https://spectrumcomputing.co.uk/forums/viewtopic.php?t=7632



	org $8000
start:
	halt
	di
	
	;sp = #5FE8
	call push_pop1

return:
	ei
	
endless:
	jp endless

originalStack:
defw $0000

screenThird:
defb $00


;;;;;;;;;;;;;;;;;;;;;;;;;;;

	org $C000
data:
incbin "girl.bin"
;include "testBuffer.asm"

end_of_data:

push_pop1:
;on entry stack is #5FE6

	;ld b, 0		;the first entry in the LUT
	;push bc		;save to stack for when we update the loop
	
	; sp = #5FE4
	;call coords_to_address
	; uses the B register to calculate pixel row
	;results in ix
	; sp = #5FE4
	
	ld ix, $400E
	
	ld iy, data
	;iy holds out buffer data
	
	;i of ir is going to be our loop data
	;ld a, (loopsteps)	; temp to be replaced with below	
	;ld a,192
	
	;64
	;ld a,64	;7t		1/3 of the screen
	;ld i, a	;9t
	
	; Einar Saukas optimization
	;Now that you are not using EX AF,AF' anymore, you can use EX AF,AF' instead of register I to preserve the loop counter.
	;saves 14 t-states per loop and 1 t-state per 1/3
		
	;using 'a to store loop
	ex af, af'	;4t
	ld a, 64	;7t
	ex af, af'	;4t
	
	
	;so at this point
	;IX is holding the screen address 
	;IY is holding out image buffer
	;I (of IR) is holding our loop info
	
	;lets save our original stack
	ld (originalStack), sp


loop1:
; sp = #5FE4
	ld sp, iy; 		10t
	;IY is for the image buffer
	pop af	;2		10t
	pop bc	;4		10t
	pop de	;6		10t
	pop hl	;8		10t
	exx		;	 	4t
	pop bc	;10		10t
	pop de	;12		10t
	pop hl	;14		10t
	;==84 t-states
	
	; Einar Saukas optimization
	; Instead of POP/PUSH AF twice in first block
	; use POP/PUSH AF once in both blocks. 
	; This way, you won't need EX AF,AF' anymore.
	; saves 28t states per loop
	ld sp, ix; 		10t
	;IX is set for the screen
	push hl	;14		11t
	push de	;12		11t
	push bc	;10		11t
	exx		;	 	4t
	push hl	;8		11t
	push de	;6		11t
	push bc	;4		11t			
	push af	;2		11t			4010
	;==91 t-states
	
;;;;;;;;;;;;;;;;;;

	;adjust our buffer
	ld bc, 14;			7t
	add iy, bc;			15t
	;adjust our screen
	ld c, 12;			10t	ld bc, $0a;	
	add ix, bc;			15t
	;we are going to reuse bc
	;Einar optimization
	
	;==47 t-states
	
	;;bc = $000E = 14
;;;;;;;;;;;;;;;;;;
	
	ld sp, iy; 		10t		buffer
	pop af	;16		10t
	pop de	;18		10t
	pop hl	;20		10t
	exx		;		4t
	pop bc	;22		10t
	pop hl	;24		10t
	pop de	;26		10t
	;==74 t-states
	
	ld sp, ix; 		10t
	push de	;26		11t
	push hl	;24		11t
	push bc	;22		11t
	exx		;		4t
	push hl	;22		11t
	push de	;20		11t
	push af	;16		11t
	;==80 t-states

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;optimizations by catmeows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	inc ixh;		8t
	ld a, ixh;		8t
	and 7;			7t
	jr z, updateIX;12/7t
	;this happen only once in 8 runs
	;so it is better to jump relative 
	;when it happens for 12 ticks
	;otherwise do nothing for 7 ticks
	ld a, ixl;		8t
	
	
	;Instead of POP/PUSH BC twice in second block, 
	;use POP/PUSH HL twice in second block. 
	;This way, you can reuse the same value of BC 
	;that you have set between both POP/PUSH blocks.
	;Einar Saukas optimization  Reuse C of BC
	;	sub 12;		7t	$0A;
	sub C;		4t
	;move back 12 character spaces
	;reused C as it is already in BC from above
	;C = 12
	
	ld ixl, a;		8t
	
	
	;modify buffer
buffer_update1:
	;iy holds out buffer data
	
	;ld bc, 12;		10t
	;add 12 character spaces in buffer
	;Instead of POP/PUSH BC twice in second block, 
	;use POP/PUSH HL twice in second block. 
	;This way, you can reuse the same value of BC 
	;that you have set between both POP/PUSH blocks.
	;Einar Saukas optimization  Reuse C of BC
	;reused C as it is already in BC from above
	
	
	add iy, bc;		15t
	
	;now lets decrease our counter in I
	ex af, af';		4t
	dec a;			4t
	;ex af, af';	4t
	
	;ld a, i;		9t
	;dec a;			4t
	;ld i, a;		9t
	
	jr nz, setup_next_pass;	12/7 t
	;==54/59  t-states

	;when we reach here, we are finished drawing 
	;1/3 of the screen
	
	jr nextthird; now let's just jump to test which 3rd

finished_copy:

	ld sp, (originalStack); back to our original stack
	;pop bc;		restore BC
ret

setup_next_pass:
	ex af, af';		4t
	jp loop1

;;this needs to be fixed;
;next line ntb $4020
updateIX:
;for moving down the next character line
	ld a, ixh;		8t
	sub 8;			7t
	ld ixh, a;		8t

	ld a, ixl;		8t
	add a, 20;		7t		add a, $16
	ld ixl, a;		8t

jr buffer_update1;12t


nextthird:
	ld a, (screenThird);	13t
	inc a;					4t
	ld (screenThird), a;	13t
	cp 1;					7t
	jr z, second;			12/7t
	cp 2;					7t
	jr z, third;			12/7t
	jp nz, finished_copy;	10t
jp finished_copy; just temp

second:
	ld ix, $480e;		14t
	
	
	
	;ld a,64;			7t	
	;ld i, a;			9t
	
	ex af, af';			4t
	ld a, 64;			7t
	;1/3 of the screen = 64 pixels
	ex af, af';			4t
	;15t
	
	
	jp loop1;			10t
	
third:
	ld ix, $500e;		14t
	
	
	;ld a,64;			7t
	;ld i, a;			9t
	ex af, af';			4t
	ld a, 64;			7t
	;1/3 of the screen = 64 pixels
	ex af, af';			4t
	;15t
	
	
	jp loop1;			10t
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;