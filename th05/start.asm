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
		jnz	short @@ret
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

@@ret:
		pop	di
		pop	si
		pop	bp
		retn
start_extra	endp

public START_DEMO
start_demo	proc near
		push	bp
		mov	bp, sp
		push	si
		les	bx, _resident
		mov	es:[bx+resident_t.end_sequence], ES_SCORE
		mov	es:[bx+resident_t.stage], 0
		mov	es:[bx+resident_t.credit_lives], 3
		mov	es:[bx+resident_t.credit_bombs], 3
		inc	es:[bx+resident_t.demo_num]
		cmp	es:[bx+resident_t.demo_num], 4
		jbe	short @@demo_num_valid
		mov	es:[bx+resident_t.demo_num], 1

@@demo_num_valid:
		cmp	_key_det, INPUT_LEFT or INPUT_RIGHT
		jnz	short @@start_demo
		cmp	_extra_playable_with.PLAYCHAR_REIMU, 0
		jz	short @@no_demo
		cmp	_extra_playable_with.PLAYCHAR_MARISA, 0
		jz	short @@no_demo
		cmp	_extra_playable_with.PLAYCHAR_MIMA, 0
		jz	short @@no_demo
		cmp	_extra_playable_with.PLAYCHAR_YUUKA, 0
		jz	short @@no_demo
		les	bx, _resident
		mov	es:[bx+resident_t.demo_num], 5
		jmp	short @@start_demo
; ---------------------------------------------------------------------------

@@no_demo:
		les	bx, _resident
		mov	es:[bx+resident_t.demo_num], 0
		jmp	@@ret
; ---------------------------------------------------------------------------

@@start_demo:
		les	bx, _resident
		mov	al, es:[bx+resident_t.demo_num]
		mov	ah, 0
		dec	ax
		mov	bx, ax
		cmp	bx, 4
		ja	short @@score_clear_loop_begin
		add	bx, bx
		jmp	cs:demo_switch[bx]

demo_switch_reimu_st3:
		les	bx, _resident
		mov	es:[bx+resident_t.playchar], PLAYCHAR_REIMU
		mov	es:[bx+resident_t.demo_stage], 3
		jmp	short @@score_clear_loop_begin
; ---------------------------------------------------------------------------

demo_switch_marisa_st1:
		les	bx, _resident
		mov	es:[bx+resident_t.playchar], PLAYCHAR_MARISA
		mov	es:[bx+resident_t.demo_stage], 1
		jmp	short @@score_clear_loop_begin
; ---------------------------------------------------------------------------

demo_switch_mima_st2:
		les	bx, _resident
		mov	es:[bx+resident_t.playchar], PLAYCHAR_MIMA
		mov	es:[bx+resident_t.demo_stage], 2
		jmp	short @@score_clear_loop_begin
; ---------------------------------------------------------------------------

demo_switch_yuuka_st4:
		les	bx, _resident
		mov	es:[bx+resident_t.playchar], PLAYCHAR_YUUKA
		mov	es:[bx+resident_t.demo_stage], 4
		jmp	short @@score_clear_loop_begin
; ---------------------------------------------------------------------------

demo_switch_mima_st6:
		les	bx, _resident
		mov	es:[bx+resident_t.playchar], PLAYCHAR_MIMA
		mov	es:[bx+resident_t.demo_stage], 6
		kajacall	KAJA_SONG_FADE, 8

@@score_clear_loop_begin:
		xor	si, si
		jmp	short @@score_clear_loop_iter
; ---------------------------------------------------------------------------

@@score_clear_loop_main:
		les	bx, _resident
		add	bx, si
		mov	es:[bx+resident_t.score_last], 0
		mov	bx, word ptr _resident
		add	bx, si
		mov	es:[bx+resident_t.score_highest], 0
		inc	si

@@score_clear_loop_iter:
		cmp	si, 8
		jl	short @@score_clear_loop_main
		call	main_cdg_free
		call	cfg_save
		push	1
		call	palette_black_out
		call	game_exit
		pushd	0
		push	ds
		push	offset _aMain	; "main"
		push	ds
		push	offset _aMain	; "main"
		call	_execl
		add	sp, 0Ch

@@ret:
		pop	si
		pop	bp
		retn
start_demo	endp

demo_switch	dw offset demo_switch_reimu_st3
		dw offset demo_switch_marisa_st1
		dw offset demo_switch_mima_st2
		dw offset demo_switch_yuuka_st4
		dw offset demo_switch_mima_st6
