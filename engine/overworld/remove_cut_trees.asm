CutTreeLocations:
; first byte = The map the tree is on
; second byte = The Y coordinate of the block
; third byte = The X coordinate of the block
	db VIRIDIAN_CITY, 2, 7
	db VIRIDIAN_CITY, 11, 4
	db ROUTE_2, 11, 7
	db ROUTE_2, 26, 6
	db ROUTE_2, 30, 6
	db ROUTE_2, 34, 6
	db PEWTER_CITY, 2, 13
	db CERULEAN_CITY, 14, 9
	db ROUTE_8, 5, 20
	db ROUTE_8, 6, 14
	db ROUTE_9, 4, 3
	db VERMILION_CITY, 9, 7
	db ROUTE_10, 9, 4
	db ROUTE_10, 10, 4
	db ROUTE_10, 11, 4
	db ROUTE_10, 12, 4
	db CELADON_CITY, 10, 23
	db ROUTE_13, 2, 17
	db ROUTE_14, 16, 5
	db ROUTE_14, 13, 2
	db ROUTE_14, 21, 1
	db ROUTE_16, 4, 17
	db ROUTE_25, 1, 13
	db $FF ; list terminator

SetCutTreeFlags::
	ld a, [wYCoord]
	sra a
	ld d, a ; d holds the Y block loc
	ld a, [wXCoord]
	sra a
	ld e, a ; e holds the X block loc
	ld a, [wSpriteStateData1 + 9] ; player sprite's facing direction
	and a
	jr z, .down
	cp SPRITE_FACING_UP
	jr z, .up
	cp SPRITE_FACING_LEFT
	jr z, .left
; right	
	ld a, [wXBlockCoord]
	and a
	jr z, .findMapLoc
	inc e
	jr .findMapLoc
.down
	ld a, [wYBlockCoord]
	and a
	jr z, .findMapLoc
	inc d
	jr .findMapLoc
.up
	ld a, [wYBlockCoord]
	and a
	jr nz, .findMapLoc
	dec d
	jr .findMapLoc
.left
	ld a, [wXBlockCoord]
	and a
	jr nz, .findMapLoc
	dec e
.findMapLoc
	ld a,[wCurMap]
	ld b, a 
	ld hl, CutTreeLocations ; d = Y loc ; e = X loc ; b = map loc
	ld c, 0
	jr .loopfirst
.loopinctwo
	inc hl
.loopincone
	inc hl
	inc c
.loopfirst ; find the matching tile block in the array
	ld a, [hl]
	inc hl
	cp $ff
	ret z ; Not in list; return with a cleared carry flag
	cp b ; Compare map
	jr nz, .loopinctwo
	ld a, [hl]  ; hl +1 (Y loc)
	inc hl
	cp d
	jr nz, .loopincone
	ld a, [hl]  ; hl +2 (X loc)
	cp e
	jr nz, .loopincone
	ld b, 1
	ld hl, wCutTrees
	ld a, c
	cp 8
	jr c, .setByte
	; second byte of wCutTrees
	sub 8
	inc hl
	ld c, a
.setByte
	predef FlagActionPredef
	ret

RemoveAlreadyCutTrees::
	ld hl, CutTreeLocations
	ld c, 0
	jr .loopfirst
.loopinctwo
	inc hl
.loopincone
	inc hl
	inc c
.loopfirst ; find the matching tile block in the array
	ld a,[wCurMap]
	ld b, a
	ld a, [hl]
	inc hl
	cp $ff
	ret z ; Not in list; return with a cleared carry flag
	cp b ; Compare map
	jr nz, .loopinctwo
	
	ld d, [hl]  ; hl +1 (Y loc)
	inc hl
	ld e, [hl]  ; hl +2 (X loc)
	push hl
	ld hl, wCutTrees
	ld a, c
	ld [wTempCoins1], a ; temporarily store the current iteration
.iterByte
	cp 8
	jr c, .checkByte
	sub 8
	inc hl
	ld c, a
	jr .iterByte
.checkByte
	ld b, 2
	predef FlagActionPredef
	ld a, c
	and a
	ld a, [wTempCoins1]
	ld c, a
	pop hl
	jr z, .loopincone
	ld b, d
	ld c, e
	push hl
	predef FindTileBlock ; hl holds block ID at X,Y coord on the map
	ld a, [hl]
	ld [wNewTileBlockID], a
	push hl
	farcall FindTileBlockReplacementCut
	pop hl
	ld a, [wNewTileBlockID]
	ld [hl], a
	ld a, [wTempCoins1]
	ld c, a
	pop hl
	jr .loopincone
