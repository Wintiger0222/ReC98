clear_score macro func
		xor	si, si
		jmp	short @@loop_digit_next
@@loop_digit_main:
		les	bx, _resident
		add	bx, si
		mov	es:[bx+resident_t.score_last], 0
		mov	bx, word ptr _resident
		add	bx, si
		mov	es:[bx+resident_t.score_highest], 0
		xor	di, di
		jmp	short @@loop_stage_next
@@loop_stage_main:
		mov	ax, di
		shl	ax, 3
		les	bx, _resident
		add	bx, ax
		mov	es:[bx+si+resident_t.stage_score], 0
		inc	di

@@loop_stage_next:
		cmp	di, MAIN_STAGE_COUNT
		jl	short @@loop_stage_main
		inc	si

@@loop_digit_next:
		cmp	si, SCORE_DIGITS
		jl	short @@loop_digit_main
endm



public START_GAME
start_game	proc near
		push	bp
		mov	bp, sp
		push	si
		push	di
		les	bx, _resident
		mov	es:[bx+resident_t.end_sequence], ES_SCORE
		mov	es:[bx+resident_t.demo_num], 0
		mov	es:[bx+resident_t.stage], 0
		mov	al, es:[bx+resident_t.cfg_lives]
		mov	es:[bx+resident_t.credit_lives], al
		mov	al, es:[bx+resident_t.cfg_bombs]
		mov	es:[bx+resident_t.credit_bombs], al
		call	playchar_menu
		or	ax, ax
		jnz	short @@playchar_menu_quit
		clear_score
		call	main_cdg_free
		call	cfg_save
		kajacall	KAJA_SONG_FADE, 10
		call	game_exit
		les	bx, _resident
		cmp	es:[bx+resident_t.debug_mode], 0
		jnz	short @@debug
		pushd	0
		push	ds
		push	offset _aMain	; "main"
		push	ds
		push	offset _aMain	; "main"
		jmp	short @@exec
; ---------------------------------------------------------------------------

@@debug:
		pushd	0
		push	ds
		push	offset _aDeb	; "deb"
		push	ds
		push	offset _aDeb	; "deb"

@@exec:
		call	_execl
		add	sp, 0Ch

@@playchar_menu_quit:
		pop	di
		pop	si
		pop	bp
		retn
start_game	endp

public START_EXTRA
start_extra	proc near
		push	bp
		mov	bp, sp
		push	si
		push	di
		les	bx, _resident
		mov	es:[bx+resident_t.demo_num], 0
		mov	es:[bx+resident_t.stage], STAGE_EXTRA
		mov	es:[bx+resident_t.credit_lives], 3
		mov	es:[bx+resident_t.credit_bombs], 3
		call	playchar_menu
		or	ax, ax
		jnz	short loc_A4CB
		clear_score
		call	main_cdg_free
		call	cfg_save
		kajacall	KAJA_SONG_FADE, 10
		call	game_exit
		pushd	0
		push	ds
		push	offset _aMain	; "main"
		push	ds
		push	offset _aMain	; "main"
		call	_execl
		add	sp, 0Ch

loc_A4CB:
		pop	di
		pop	si
		pop	bp
		retn
start_extra	endp
