main_cdg_load	proc near
		push	bp
		mov	bp, sp
		call	cdg_load_all pascal,  0, ds, offset aSft1_cd2
		call	cdg_load_all pascal, 10, ds, offset aSft2_cd2
		call	cdg_load_all pascal, 35, ds, offset aCar_cd2
		
		if GAME eq 5
		call	cdg_load_single_noalpha pascal, 40, ds, offset aSl00_cdg, 0
		call	cdg_load_single_noalpha pascal, 41, ds, offset aSl01_cdg, 0
		call	cdg_load_single_noalpha pascal, 42, ds, offset aSl02_cdg, 0
		call	cdg_load_single_noalpha pascal, 43, ds, offset aSl03_cdg, 0
		call	cdg_load_single pascal, 44, ds, offset aSlcl_cdg, 0
		call	cdg_load_single_noalpha pascal, 45, ds, offset aSl04_cdg, 0
		endif
		if GAME eq 4
		call    cdg_load_all_noalpha pascal, 40, ds, offset aSl_cd2
		endif
		
		
		pop	bp
		retn
main_cdg_load	endp

main_cdg_free	proc near
		push bp
		mov bp, sp
		call cdg_freeall
		pop bp
		retn
main_cdg_free	endp