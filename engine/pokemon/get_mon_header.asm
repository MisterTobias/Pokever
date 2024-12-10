; PureRGBnote: CHANGED: MOVED: This code was moved out of home bank since it's getting complicated and needs some jump tables to facilitate 
GetMonHeader2::
	push bc
	push de
	push hl
	ld a, [wPokedexNum]
	push af
	ld a, [wCurSpecies]
	ld [wPokedexNum], a
	ld hl, NonPokemonSpecies
	ld de, 4
	call IsInArray
	jr nc, .notNonPokemonSpecies
	inc hl
	ld a, [hli]
	ld b, a
	de_deref
	ld hl, wMonHSpriteDim
	ld a, b
	ld [hli], a ; write sprite dimensions
	ld a, e
	ld [hli], a ; write front sprite pointer
	ld [hl], d
	jr .done
.notNonPokemonSpecies
	ld a, [wCurSpecies]
	ld hl, NonDexPokemonSpecies
	ld de, 1
	call IsInArray
	jr nc, .notNonDexPokemonSpecies
	ld a, b
	ld hl, NonDexMonsBaseStats
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	jr .copyBaseStats
.notNonDexPokemonSpecies
	predef IndexToPokedex   ; convert pokemon ID in [wPokedexNum] to pokedex number
	ld a, [wPokedexNum]
	dec a
	ld bc, BASE_DATA_SIZE
	ld hl, BaseStats
	call AddNTimes
.copyBaseStats
	ld bc, BASE_DATA_SIZE
	ld de, wMonHeader
	call CopyData ; PureRGBnote: CHANGED: mew header now in same bank as rest of base stat data so no need to farcopy
.done
	ld a, [wCurSpecies]
	ld [wMonHIndex], a
	pop af
	ld [wPokedexNum], a
	pop hl
	pop de
	pop bc
	ret

NonPokemonSpecies:
	db FOSSIL_KABUTOPS, $66
	dw FossilKabutopsPic
	db MON_GHOST, $66
	dw GhostPic
	db FOSSIL_AERODACTYL, $77
	dw FossilAerodactylPic
	db -1

NonDexPokemonSpecies:
	db ANNIHILAPE
	db -1