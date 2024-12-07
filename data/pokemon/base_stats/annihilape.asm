	db DEX_ANNIHILAPE; pokedex id ; define byte

	db 110, 115,  80,  90,  50
	;   hp  atk  def  spd  spc

	db FIGHTING, GHOST ; type
	db 45 ; catch rate
	db 149 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/annihilape.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/annihilape.pic", 0, 1 ; sprite dimensions
ENDC
	dw AnnihilapePicFront, AnnihilapePicBack

	db SCRATCH, LEER, COUNTER, FOCUS_ENERGY ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm BODY_SLAM,    TAKE_DOWN, 	 DOUBLE_EDGE,  HYPER_BEAM,	 COUNTER,	   \
	     SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      EARTHQUAKE,   DIG, 	       \
	     METRONOME,	   SWIFT,        REST,  	   ROCK_SLIDE,   SUBSTITUTE,   \
	; end

	db BANK(AnnihilapePicFront)
	assert BANK(AnnihilapePicFront) == BANK(AnnihilapePicBack)