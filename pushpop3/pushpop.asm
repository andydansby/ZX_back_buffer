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
end_of_data:

push_pop1:
;on entry stack is #5FE6

	ld b, 0		;the first entry in the LUT
	push bc		;save to stack for when we update the loop
	
	; sp = #5FE4
	;call coords_to_address
	; uses the B register to calculate pixel row
	;results in ix
	; sp = #5FE4
	
	ld ix, $4010
	
	ld iy, data
	;iy holds out buffer data
	
	;i of ir is going to be our loop data
	;ld a, (loopsteps)	; temp to be replaced with below	
	;ld a,192
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
	;our stack is set to image buffer
	;== 10 t-states
	
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
	;==88 t-states
	
	
	ld sp, ix; 		10t
	;our stack is set to the screen
	;== 10 t-states
	
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
	;==96 t-states
	
	;adjust our screen
	ld bc, $0a;			10t
	add ix, bc;			15t
	;adjust our buffer
	ld c, $10;			7t
	add iy, bc;			15t
	;==50 t-states
	
	ld sp, iy; 		10t		buffer
	pop bc	;18		10t
	pop de	;20		10t
	pop hl	;22		10t
	exx		;		4t
	pop bc	;24		10t
	pop de	;26		10t
	;==64 t-states
	
	ld sp, ix; 		10t
	;== 10 t-states

	push de	;26		11t
	push bc	;24		11t
	exx		;		4t
	push hl	;22		11t
	push de	;20		11t
	push bc	;18		11t
	;==59 t-states
	
;$d3c4
;at this point 
;IX = $401A
;needs to be
;4110

; at the end of 8 lines
;ix = $471a

;dont read the stack with 
;ld sp, (xxxx), 
;it is very expensive
;also don't copy IX to DE unless you need it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	inc ixh
	ld a, ixh
	and 7
	jr z, updateIx1
	;this happen only once in 8 runs
	;so it is better to jump relative 
	;when it happens for 12 ticks
	;otherwise do nothing for 7 ticks
	ld a, ixl
	sub $0A
	ld ixl, a
	
	
	;modify buffer
buffer_update1:
	;iy holds out buffer data
	ld bc, 10				;10t	
	add iy, bc				;15t
	
	;now lets decrease our counter in I
	ld a, i					;9t
	dec a					;4t
	ld i, a					;9t	
	
	jr nz, loop1				;12/7 t
	;==54/59  t-states


	;halt
	;when we reach here, we are finished drawing 
	;1/3 of the screen
	
	jr nextthird

finished_copy:

	ld sp, (originalStack)
;sp = #5FE4


	;I think I'm having a stack problem with returning
	pop bc
ret


updateIx1:

;;entering with $481a
	;should  exit with $4030
	;instead exit with $4910

 ;update ix and go to continue
 	;ld sp, (originalStack)	;20t
	;==20 t-states

	ld a, ixh;	a = #48
	sub 8;		a =	#40
	ld ixh, a;

	ld a, ixl
	add a, $16
	ld ixl, a

jr buffer_update1


nextthird:
	ld a, (screenThird)
	inc a
	ld (screenThird), a
	cp 1
	jr z, second
	cp 2
	jr z, third
	jp nz, finished_copy


second:
	ld ix, $4810
	ld a,64
	ld i, a
	jp loop1
	
third:
	ld ix, $5010
	ld a,64
	ld i, a
	jp loop1