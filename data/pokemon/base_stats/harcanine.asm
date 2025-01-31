	db DEX_ARCANINE ; pokedex id

	db  95, 115,  80,  90,  85
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 75 ; catch rate
	db 213 ; base exp

IF GEN_2_GRAPHICS
	INCBIN "gfx/pokemon/gsfront/arcanine.pic", 0, 1 ; sprite dimensions
ELSE
	INCBIN "gfx/pokemon/front/arcanine.pic", 0, 1 ; sprite dimensions
ENDC
	dw ArcaninePicFront, ArcaninePicBack

	db ROAR, EMBER, LEER, TAKE_DOWN ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     RAGE,         DRAGON_RAGE,  DIG,          TELEPORT,     MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   SWIFT,        \
	     SKULL_BASH,   REST,         SUBSTITUTE
	; end

	db BANK(ArcaninePicFront)
