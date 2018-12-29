; Each tile defines a 384×80 section of the background, which internally are
; further divided into 5 rows of 16 pixels each.

; No idea why ZUN just didn't go with the actually visible space of 384
; horizontal tiles. That's 8 wasted tiles per row that the game doesn't do
; anything with?
TILES_MEMORY_X = 512 / TILE_W

; Subdivides each 16×16 tile into two 16×8 halves and marks whether that half
; should be redrawn by the next call to tiles_redraw_invalidated() if its
; entry is nonzero.
public _halftiles_dirty, _halftiles_dirty_end
_halftiles_dirty	db (TILES_MEMORY_X * TILE_FLAGS_Y) dup(?)
_halftiles_dirty_end	label byte

; TH04 starts addressing individual tiles directly via their 16-bit offset
; in the VRAM.
public _tile_ring
_tile_ring	dw (TILES_MEMORY_X * TILES_Y) dup(?)

if GAME eq 5
public _tile_index_ptr
_tile_index_ptr	dw ?
else
public _tile_index
_tile_index    	dw ?
endif

public _tile_row, _tile_scrollspeed_ptr
_tile_row	db ?
         	db ?
_tile_scrollspeed_ptr	dw ?
