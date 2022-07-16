
	org $8000	
start:
	
	di
	
	;sp = #5FE8
	call push_pop

return:
	ei
	
endless:
	jp endless

originalStack:
defw $0000


;;;;;;;;;;;;;;;;;;;;;;;;;;;

	org $C000
data:
incbin "girl.bin"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;for testing purposes only
;defb $000, $001, $002, $003, $004, $005, $006, $007, $008, $009, $00a, $00b, $00c, $00d, $00e, $00f, $010, $011, $012, $013, $014, $015, $016, $017, $018, $019;row 1
; 26 entries	$4000

;defb $020, $021, $022, $023, $024, $025, $026, $027, $028, $029, $02a, $02b, $02c, $02d, $02e, $02f, $030, $031, $032, $033, $034, $035, $036, $037, $038, $039;row 2 
; 26 entries	$4100

;defb $040, $041, $042, $043, $044, $045, $046, $047, $048, $049, $04a, $04b, $04c, $04d, $04e, $04f, $050, $051, $052, $053, $054, $055, $056, $057, $058, $059;row 3
; 26 entries	$4200

;defb $060, $061, $062, $063, $064, $065, $066, $067, $068, $069, $06a, $06b, $06c, $06d, $06e, $06f, $070, $071, $072, $073, $074, $075, $076, $077, $078, $079;row 4 
; 26 entries	$4300

;defb $080, $081, $082, $083, $084, $085, $086, $087, $088, $089, $08a, $08b, $08c, $08d, $08e, $08f, $090, $091, $092, $093, $094, $095, $096, $097, $098, $099;row 5 
; 26 entries	$4400

;defb $0A0, $0A1, $0A2, $0A3, $0A4, $0A5, $0A6, $0A7, $0A8, $0A9, $0AA, $0AB, $0AC, $0AD, $0AE, $0AF, $0B0, $0B1, $0B2, $0B3, $0B4, $0B5, $0B6, $0B7, $0B8, $0B9;row 6 
; 26 entries	$4500

;defb $0C0, $0C1, $0C2, $0C3, $0C4, $0C5, $0C6, $0C7, $0C8, $0C9, $0CA, $0CB, $0CC, $0CD, $0CE, $0CF, $0D0, $0D1, $0D2, $0D3, $0D4, $0D5, $0D6, $0D7, $0D8, $0D9;row 7 
; 26 entries	$4600	

;defb $0E0, $0E1, $0E2, $0E3, $0E4, $0E5, $0E6, $0E7, $0E8, $0E9, $0EA, $0EB, $0EC, $0ED, $0EE, $0EF, $0F0, $0F1, $0F2, $0F3, $0F4, $0F5, $0F6, $0F7, $0F8, $0F9;row 8
; 26 entries	$4700

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;defb $0E0, $0E1, $0E2, $0E3, $0E4, $0E5, $0E6, $0E7, $0E8, $0E9, $0EA, $0EB, $0EC, $0ED, $0EE, $0EF, $0F0, $0F1, $0F2, $0F3, $0F4, $0F5, $0F6, $0F7, $0F8, $0F9;row 9
; 26 entries	$4020

;defb $0C0, $0C1, $0C2, $0C3, $0C4, $0C5, $0C6, $0C7, $0C8, $0C9, $0CA, $0CB, $0CC, $0CD, $0CE, $0CF, $0D0, $0D1, $0D2, $0D3, $0D4, $0D5, $0D6, $0D7, $0D8, $0D9;row 10 
; 26 entries	$4120

;defb $0A0, $0A1, $0A2, $0A3, $0A4, $0A5, $0A6, $0A7, $0A8, $0A9, $0AA, $0AB, $0AC, $0AD, $0AE, $0AF, $0B0, $0B1, $0B2, $0B3, $0B4, $0B5, $0B6, $0B7, $0B8, $0B9;row 11
; 26 entries	$4220

;defb $080, $081, $082, $083, $084, $085, $086, $087, $088, $089, $08a, $08b, $08c, $08d, $08e, $08f, $090, $091, $092, $093, $094, $095, $096, $097, $098, $099;row 12
; 26 entries	$4320

;defb $060, $061, $062, $063, $064, $065, $066, $067, $068, $069, $06a, $06b, $06c, $06d, $06e, $06f, $070, $071, $072, $073, $074, $075, $076, $077, $078, $079;row 13
; 26 entries	$4420

;defb $040, $041, $042, $043, $044, $045, $046, $047, $048, $049, $04a, $04b, $04c, $04d, $04e, $04f, $050, $051, $052, $053, $054, $055, $056, $057, $058, $059;row 14
; 26 entries	$4520

;defb $020, $021, $022, $023, $024, $025, $026, $027, $028, $029, $02a, $02b, $02c, $02d, $02e, $02f, $030, $031, $032, $033, $034, $035, $036, $037, $038, $039;row 15
; 26 entries	$4620

;defb $000, $001, $002, $003, $004, $005, $006, $007, $008, $009, $00a, $00b, $00c, $00d, $00e, $00f, $010, $011, $012, $013, $014, $015, $016, $017, $018, $019;row 16
; 26 entries	$4720
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end_of_data:

push_pop:

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
	ld a,192
	ld i, a
	
	;so at this point
	;IX is holding the screen address 
	;IY is holding out image buffer
	;I (of IR) is holding our loop info
	
	;lets save our original stack
	ld (originalStack), sp


loop:
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
	ld bc, $10;			10t
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
	
	ld sp, (originalStack)	;20t
	;==20 t-states
	;https://worldofspectrum.org/forums/discussion/comment/315782/#Comment_315782
	
	ld d, ixh;		8t
	ld e, ixl;		8t
	uphl:
	inc d;			4t
	ld a,d;			4t
	and 7;			7t
	jp nz, end_of_next_line;	10t
	
	ld a,e;			4t
	add a,32;		7t
	ld e,a;			4t

	jr c, end_of_next_line;		12/7t
	
	ld a,d;			4t
	sub 8;			7t
	ld d,a;			4t

end_of_next_line:

	ld a,e;			4t
	ld l, $A;		7t
	sub l;			4t
	ld e,a;			4t
	
	ld ixh, d;		8t
	ld ixl, e;		8t
	;==113 to 118
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;iy holds out buffer data
	ld bc, 10				;10t
	
	add iy, bc				;15t
	
	ld a, i					;9t
	dec a					;4t
	ld i, a					;9t	
	
	jr nz, loop				;12/7 t
	;==54/59  t-states
	
;;;end loop	
;; entire loop for 1 line is
;	==574 / 584 t-states per line

;LDI method 2 = 506T per line
	

ld sp, (originalStack)
;sp = #5FE4


	;I think I'm having a stack problem with returning
	pop hl
ret
