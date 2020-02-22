;
; +-------------------------------------------------------------------------+
; |   This file has been generated by The Interactive Disassembler (IDA)    |
; |        Copyright (c) 2009 by Hex-Rays, <support@hex-rays.com>           |
; +-------------------------------------------------------------------------+
;
; Input	MD5   :	C84DB5A5C97E54BA50E3BE80D8C24034

; File Name   :	th04/ZUN.COM:RES_HUMA (-S)
; Format      :	MS-DOS COM-file
; Base Address:	0h Range: 100h-19D8h Loaded length: 18D8h
; OS type	  :  MS	DOS
; Application type:  Executable	16bit

		.286
		.model tiny
		__TINY__ equ 1

include ReC98.inc
include th04/th04.inc

; ===========================================================================

; Segment type:	Pure code
_TEXT		segment	word public 'CODE' use16
		assume cs:_TEXT
		assume es:nothing, ss:nothing, ds:_TEXT

include libs/BorlandC/c0.asm

; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

sub_367		proc near

var_10		= byte ptr -10h
var_F		= byte ptr -0Fh
var_E		= byte ptr -0Eh
var_D		= byte ptr -0Dh
var_C		= byte ptr -0Ch
var_B		= byte ptr -0Bh
var_7		= byte ptr -7
var_6		= byte ptr -6
arg_0		= byte ptr  4

		enter	10h, 0
		push	si
		mov	si, offset aMiko_cfg ; "miko.cfg"
		lea	ax, [bp+var_6]
		push	ss
		push	ax
		push	ds
		push	offset unk_15FF
		mov	cx, 6
		call	N_SCOPY@
		push	si
		call	file_ropen
		or	ax, ax
		jnz	short loc_396

loc_386:
		push	si
		call	file_create
		push	ss
		lea	ax, [bp+var_6]
		push	ax
		push	6
		call	file_write
		jmp	short loc_3DC
; ---------------------------------------------------------------------------

loc_396:
		push	ss
		lea	ax, [bp+var_10]
		push	ax
		push	0Ah
		call	file_read
		call	file_close
		mov	al, [bp+var_10]
		cbw
		push	ax
		mov	al, [bp+var_F]
		cbw
		pop	dx
		add	dx, ax
		mov	al, [bp+var_E]
		cbw
		add	dx, ax
		mov	al, [bp+var_D]
		cbw
		add	dx, ax
		mov	al, [bp+var_C]
		cbw
		add	dx, ax
		mov	al, [bp+var_B]
		cbw
		add	dx, ax
		mov	al, [bp+var_7]
		cbw
		cmp	dx, ax
		jnz	short loc_386
		push	si
		call	file_append
		push	0
		push	6
		push	0
		call	file_seek

loc_3DC:
		push	ss
		lea	ax, [bp+arg_0]
		push	ax
		push	2
		call	file_write
		push	ds
		push	offset byte_15FE
		push	1
		call	file_write
		push	ss
		lea	ax, [bp+var_7]
		push	ax
		push	1
		call	file_write
		call	file_close
		pop	si
		leave
		retn
sub_367		endp


; =============== S U B	R O U T	I N E =======================================

; Attributes: bp-based frame

; int __cdecl main(int argc, const char	**argv,	const char **envp)
_main		proc near

var_C		= dword	ptr -0Ch
var_8		= dword	ptr -8
var_4		= word ptr -4
var_2		= word ptr -2
_argc		= word ptr  4
_argv		= word ptr  6
_envp		= word ptr  8

		enter	0Ch, 0
		push	si
		push	di
		mov	si, [bp+_argv]
		mov	[bp+var_2], offset aHumaconfig ; "HUMAConfig"
		push	[bp+var_2]
		push	0Ah
		push	10h
		call	resdata_exist
		mov	di, ax
		push	offset aUmx	; "\n\n東方幻想郷用　 常駐プログラム　RES_HU"...
		call	dos_puts2
		call	graph_clear
		cmp	[bp+_argc], 2
		jnz	short loc_485
		mov	bx, [si+2]
		cmp	byte ptr [bx], '-'
		jz	short loc_435
		cmp	byte ptr [bx], '/'
		jnz	short loc_45A

loc_435:
		mov	bx, [si+2]
		cmp	byte ptr [bx+1], 'R'
		jz	short loc_444
		cmp	byte ptr [bx+1], 'r'
		jnz	short loc_45A

loc_444:
		or	di, di
		jnz	short loc_44D
		push	offset aVavVBavVVvvVV ;	"わたし、まだいませんよぉ\n\n"
		jmp	short loc_4A4
; ---------------------------------------------------------------------------

loc_44D:
		push	di
		call	dos_free
		push	offset aVVcvVcbavVIqvj ; "さよなら、また会えたらいいな\n\n"
		call	dos_puts2
		jmp	loc_4F5
; ---------------------------------------------------------------------------

loc_45A:
		mov	bx, [si+2]
		cmp	byte ptr [bx], '-'
		jz	short loc_467
		cmp	byte ptr [bx], '/'
		jnz	short loc_47D

loc_467:
		mov	bx, [si+2]
		cmp	byte ptr [bx+1], 'D'
		jz	short loc_476
		cmp	byte ptr [bx+1], 'd'
		jnz	short loc_47D

loc_476:
		mov	byte_15FE, 1
		jmp	short loc_485
; ---------------------------------------------------------------------------

loc_47D:
		push	offset aVV	; "そんなオプション付けられても、困るんで・...
		call	dos_puts2
		jmp	short loc_4A7
; ---------------------------------------------------------------------------

loc_485:
		or	di, di
		jz	short loc_491
		push	offset aVavVBavVVVvvVV ; "わたし、すでにいますよぉ\n\n"
		call	dos_puts2
		jmp	short loc_4A7
; ---------------------------------------------------------------------------

loc_491:
		push	[bp+var_2]
		push	0Ah
		push	10h
		call	resdata_create
		mov	di, ax
		or	di, di
		jnz	short loc_4AC
		push	offset aNVVVV	; "作れません、わたしの居場所がないの！\n\n"

loc_4A4:
		call	dos_puts2

loc_4A7:
		mov	ax, 1
		jmp	short loc_4F7
; ---------------------------------------------------------------------------

loc_4AC:
		mov	word ptr [bp+var_8+2], di
		mov	word ptr [bp+var_8], 0
		push	offset aVVVVBavcvivVnv ; "それでは、よろしくお願いします\n\n"
		call	dos_puts2
		mov	[bp+var_4], 0Bh
		jmp	short loc_4CE
; ---------------------------------------------------------------------------

loc_4C1:
		les	bx, [bp+var_8]
		add	bx, [bp+var_4]
		mov	byte ptr es:[bx], 0
		inc	[bp+var_4]

loc_4CE:
		cmp	[bp+var_4], 100h
		jl	short loc_4C1
		push	di
		call	sub_367
		pop	cx
		mov	dx, word ptr [bp+var_8+2]
		mov	ax, word ptr [bp+var_8]
		mov	word ptr [bp+var_C+2], dx
		mov	word ptr [bp+var_C], ax
		cmp	byte_15FE, 0
		jz	short loc_4F5
		les	bx, [bp+var_C]
		mov	es:[bx+resident_t.debug_mode], 1

loc_4F5:
		xor	ax, ax

loc_4F7:
		pop	di
		pop	si
		leave
		retn
_main		endp

; ---------------------------------------------------------------------------
		db 0
include libs/master.lib/graph_clear.asm
include libs/master.lib/resdata.asm
include libs/master.lib/file_read.asm
include libs/master.lib/file_close.asm
include libs/master.lib/file_ropen.asm
include libs/master.lib/file_write.asm
include libs/master.lib/file_create.asm
include libs/master.lib/file_seek.asm
include libs/master.lib/file_append.asm
include libs/master.lib/dos_free.asm
include libs/master.lib/dos_axdx.asm
include libs/master.lib/dos_puts2.asm
include libs/master.lib/dos_ropen.asm
include libs/BorlandC/_abort.asm
include libs/BorlandC/atexit.asm
include libs/BorlandC/errormsg.asm
include libs/BorlandC/exit.asm
include libs/BorlandC/ioerror.asm
include libs/BorlandC/_isatty.asm
include libs/BorlandC/lseek.asm
include libs/BorlandC/n_scopy.asm
include libs/BorlandC/setupio.asm
include libs/BorlandC/brk.asm
include libs/BorlandC/nearheap.asm
include libs/BorlandC/pathops.asm
include libs/BorlandC/fflush.asm
include libs/BorlandC/flushall.asm
include libs/BorlandC/fseek.asm
include libs/BorlandC/setvbuf.asm
include libs/BorlandC/_strlen.asm
include libs/BorlandC/write.asm
include libs/BorlandC/writea.asm
include libs/BorlandC/xfflush.asm
include libs/BorlandC/setargv.asm
		db 8 dup(0)
; ---------------------------------------------------------------------------

include libs/BorlandC/c0[data].asm

byte_15FE	db 0
unk_15FF	db 0FFh
		db    CFG_LIVES_DEFAULT
		db    CFG_BOMBS_DEFAULT
		db    1
		db    1
		db    1
aMiko_cfg	db 'miko.cfg',0
aHumaconfig	db 'HUMAConfig',0
aUmx		db 0Ah
		db 0Ah
		db '東方幻想郷用　 常駐プログラム　RES_HUMA.com Version1.00       (c)zun 1998',0Ah,0
aVavVBavVVvvVV	db 'わたし、まだいませんよぉ',0Ah
		db 0Ah,0
aVVcvVcbavVIqvj	db 'さよなら、また会えたらいいな',0Ah
		db 0Ah,0
aVV		db 'そんなオプション付けられても、困るんですけど',0Ah
		db 0Ah,0
aVavVBavVVVvvVV	db 'わたし、すでにいますよぉ',0Ah
		db 0Ah,0
aNVVVV		db '作れません、わたしの居場所がないの！',0Ah
		db 0Ah,0
aVVVVBavcvivVnv	db 'それでは、よろしくお願いします',0Ah
		db 0Ah,0
include libs/master.lib/version[data].asm
include libs/master.lib/grp[data].asm
include libs/master.lib/resdata[data].asm
include libs/master.lib/fil[data].asm
include libs/master.lib/dos_ropen[data].asm
include libs/BorlandC/_abort[data].asm
include libs/BorlandC/atexit[data].asm
include libs/BorlandC/exit[data].asm
include libs/BorlandC/files[data].asm
__heaplen	dw 0
include libs/BorlandC/ioerror[data].asm
include libs/BorlandC/stklen[data].asm
include libs/BorlandC/nearheap[data].asm
include libs/BorlandC/pathops[data].asm
include libs/BorlandC/setvbuf[data].asm
include libs/BorlandC/sysnerr[data].asm
include libs/BorlandC/setargv[data].asm

InitStart	label byte
include libs/BorlandC/setupio[initdata].asm
include libs/BorlandC/pathops[initdata].asm
include libs/BorlandC/setargv[initdata].asm
InitEnd	label byte

ExitStart	label byte
ExitEnd	label byte

bdata@	label byte
include libs/master.lib/fil[bss].asm
include libs/BorlandC/atexit[bss].asm
edata@	label byte
_TEXT		ends


		end startx
