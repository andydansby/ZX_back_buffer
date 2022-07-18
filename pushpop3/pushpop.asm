;optimization suggestions by catmeows
;https://spectrumcomputing.co.uk/forums/viewtopic.php?t=7632

;catmeows optimizations save from 77t to 82t per loop









	org $8000
start:
	;halt
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
end_of_data:

push_pop1:
;on entry stack is #5FE6

	ld b, 0		;the first entry in the LUT
	push bc		;save to stack for when we update the loop

	ld ix, $4010
	
	ld iy, data
	;iy holds out buffer data
	
	;i of ir is going to be our loop data
	ld a,64
	ld i, a
	
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
	ex af, af';	 	4t
	pop af	;10		10t
	pop bc	;12		10t
	pop de	;14		10t
	pop hl	;16		10t
	;==98 t-states
	
	
	ld sp, ix; 		10t
	;IX is set for the screen
	push hl	;16		11t
	push de	;14		11t
	push bc	;12		11t
	push af	;10		11t
	exx		;	 	4t
	ex af, af';	 	4t
	push hl	;8		11t
	push de	;6		11t
	push bc	;4		11t
	push af	;2		11t
	;==106 t-states
	
	;adjust our screen
	ld bc, $0a;			10t
	add ix, bc;			15t
	;adjust our buffer
	ld c, $10;			7t
	add iy, bc;			15t
	;==47 t-states
	
	ld sp, iy; 		10t		buffer
	pop bc	;18		10t
	pop de	;20		10t
	pop hl	;22		10t
	exx		;		4t
	pop bc	;24		10t
	pop de	;26		10t
	;==64 t-states
	
	ld sp, ix; 		10t
	push de	;26		11t
	push bc	;24		11t
	exx		;		4t
	push hl	;22		11t
	push de	;20		11t
	push bc	;18		11t
	;==69 t-states
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;optimizations by catmeows
	inc ixh;		8t
	ld a, ixh;		8t
	and 7;			7t
	jr z, updateIX;12/7t
	;this happen only once in 8 runs
	;so it is better to jump relative 
	;when it happens for 12 ticks
	;otherwise do nothing for 7 ticks
	ld a, ixl;		8t
	sub $0A;		7t
	ld ixl, a;		8t
	
	;was 50
	;now 53/58
	
	
	;modify buffer
buffer_update1:
	;iy holds out buffer data
	
	;ld bc, 10;		10t	
	ld bc, 10
	
	add iy, bc;		15t
	
	;now lets decrease our counter in I
	ld a, i;		9t
	dec a;			4t
	ld i, a;		9t	
	
	jr nz, loop1;	12/7 t
	;==54/59  t-states

	;when we reach here, we are finished drawing 
	;1/3 of the screen
	
	jr nextthird; now let's just jump to test which 3rd

finished_copy:

	ld sp, (originalStack); back to our original stack
	pop bc;		restore BC
ret


updateIX:

	ld a, ixh;		8t
	sub 8;			7t
	ld ixh, a;		8t

	ld a, ixl;		8t
	add a, $16;		7t
	ld ixl, a;		8t

jr buffer_update1;12t


nextthird:
	ld a, (screenThird); 13t
	inc a				; 4t
	ld (screenThird), a; 13t
	cp 1;				  7t
	jr z, second;		12/7t
	cp 2;				  7t
	jr z, third;		12/7t
	jp nz, finished_copy; 10t


second:
	ld ix, $4810;		14t
	ld a,64;			 7t
	ld i, a;			 9t
	jp loop1;			10t
	
third:
	ld ix, $5010;		14t
	ld a,64;			 7t
	ld i, a;			 9t
	jp loop1;			10t
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;