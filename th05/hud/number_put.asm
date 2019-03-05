; Prints [val] using the bold gaiji font, right-aligned at ([x+5], [y]), with
; the given attribute.
; void pascal far hud_int_put(unsigned int x, unsigned int y, unsigned int val, unsigned int atrb);
public hud_int_put
hud_int_put	proc far

@@atrb		= word ptr  6
@@val		= word ptr  8

	push	bp
	mov	bp, sp
	push	di
; Avoid LEA being turned into MOV for immediate addresses
pushstate
nosmart
	lea	di, _hud_gaiji_row + (SCORE_DIGITS - 5)
	movzx	edx, [bp+@@val]
	lea	bx, _POWERS_OF_10_LONG + (2 * 4)
popstate
	mov	ax, [bp+@@atrb]
	mov	cx, 4
	jmp	short hud_digits_put
hud_int_put	endp
	nop


; Prints [points] using the bold gaiji font, right-aligned at ([x+8], [y]),
; in white, using up to 7 digits (8 if the "continue" digit is included).
; Larger numbers will overflow the most significant digit into the A-Z range.

; void pascal far hud_points_put(unsigned int x, unsigned int y, unsigned long points);
public hud_points_put
hud_points_put	proc far

@@points	= dword	ptr  6
@@y     	= word ptr  0Ah
@@x     	= word ptr  0Ch

	push	bp
	mov	bp, sp
	push	di
	mov	edx, [bp+@@points]
	mov	di, offset _hud_gaiji_row
	mov	ax, TX_WHITE
	mov	_hud_gaiji_row[SCORE_DIGITS - 1], gb_0_	; ("continues used" digit)
	mov	bx, offset _POWERS_OF_10_LONG
	mov	cx, SCORE_DIGITS - 2

hud_digits_put:
	push	[bp+@@x]
	push	[bp+@@y]
	push	ds
	push	di
	push	ax
	mov	ax, ds
	mov	es, ax

@@digit_loop:
	mov	eax, edx
	xor	edx, edx
	div	dword ptr [bx]
	or	ch, al
	jz	short @@omit_leading_zeroes
	add	al, GB_DIGITS
	jmp	short @@digit_next
; ---------------------------------------------------------------------------

@@omit_leading_zeroes:
	mov	al, g_EMPTY

@@digit_next:
	stosb
	add	bx, 4
	dec	cl
	jnz	short @@digit_loop
	add	dl, gb_0_	; (ones)
	mov	[di], dl
	call	gaiji_putsa
	pop	di
	pop	bp
	retf	8
hud_points_put	endp
