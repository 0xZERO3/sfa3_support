_L = 0						-- left
_R = w_scr_width()			-- right
_T = 0						-- top
_B = w_scr_height()			-- bottom
_C = w_scr_width()/2		-- center

disp = {
	timer          = {x = (_C -  10 +   0), y = (_T +   6 +   0), draw = true},
	turbo_speed    = {x = (_C -  16 +   0), y = (_T +   0 +   0), draw = true},
	p1freeze       = {x = (_L +   1 +   0), y = (_T +   6 +   0), draw = true},
	p2freeze       = {x = (_R -  38 +   0), y = (_T +   6 +   0), draw = true},
	p1anim_left    = {x = (_L +  64 +   0), y = (_B -   8 +   0), draw = true},
	p2anim_left    = {x = (_R - 110 +   0), y = (_B -   8 +   0), draw = true},
	p1motion00     = {x = (_L + 114 +   0), y = (_B -   8 +   0), draw = true},
	p2motion00     = {x = (_R - 160 +   0), y = (_B -   8 +   0), draw = true},
	p1char_state   = {x = (_L + 164 +   0), y = (_B -   8 +   0), draw = true},
	p2char_state   = {x = (_R - 190 +   0), y = (_B -   8 +   0), draw = true},
	p1block_num    = {x = (_L +  40 +   0), y = (_T +   6 +   0), draw = true},
	p2block_num    = {x = (_R -  72 +   0), y = (_T +   6 +   0), draw = true},
	p1cc_left      = {x = (_L +  76 +   0), y = (_T +   6 +   0), draw = true},
	p2cc_left      = {x = (_R -  98 +   0), y = (_T +   6 +   0), draw = true},
	p1x            = {x = (_L +   1 +   0), y = (_B -  22 +   0), draw = true},
	p2x            = {x = (_R -  92 +   0), y = (_B -  22 +   0), draw = true},
	p1vital        = {x = (_L +  34 +   0), y = (_T +  22 +   0), draw = true},
	p2vital        = {x = (_R -  60 +   0), y = (_T +  22 +   0), draw = true},
	p1power        = {x = (_L +  34 +   0), y = (_B -   8 +   0), draw = true},
	p2power        = {x = (_R -  60 +   0), y = (_B -   8 +   0), draw = true},
	p1guard        = {x = (_C -  70 +   0), y = (_T +  32 +   0), draw = true},
	p2guard        = {x = (_C +  10 +   0), y = (_T +  32 +   0), draw = true},
	p1stun         = {x = (_L +  34 +   0), y = (_T +  34 +   0), draw = true},
	p2stun         = {x = (_R - 120 +   0), y = (_T +  34 +   0), draw = true},
	p1combo        = {x = (_L +  34 +   0), y = (_T +  28 +   0), draw = true},
	p1combo_max    = {x = (_L +  70 +   0), y = (_T +  28 +   0), draw = true},
	p2combo        = {x = (_R -  76 +   0), y = (_T +  28 +   0), draw = true},
	p2combo_max    = {x = (_R -  40 +   0), y = (_T +  28 +   0), draw = true},
	p1direction    = {x = (_L +   1 +   0), y = (_B -   8 +   0), draw = true},
	p2direction    = {x = (_R -  20 +   0), y = (_B -   8 +   0), draw = true},
	p1close        = {x = (_L +   1 +   0), y = (_B -  14 +   0), draw = true},
	p2close        = {x = (_R -  20 +   0), y = (_B -  14 +   0), draw = true},
	p1corner_pos   = {x = (_L +  24 +   0), y = (_B -   8 +   0), draw = true},
	p2corner_pos   = {x = (_R -  28 +   0), y = (_B -   8 +   0), draw = true},
	p1title_inv    = {x = (_L +   1 +   0), y = (_T +   0 +   0), draw = true},
	p1flag_inv     = {x = (_L +   1 +  46), y = (_T +   0 +   0), draw = true},
	p1throw_inv    = {x = (_L +   1 +  60), y = (_T +   0 +   0), draw = true},
	p1stun_inv     = {x = (_L +   1 +  82), y = (_T +   0 +   0), draw = true},
	p1time_inv     = {x = (_L +   1 +  96), y = (_T +   0 +   0), draw = true},
	p1throw_inv_f  = {x = (_L +   1 + 114), y = (_T +   0 +   0), draw = true},
	p2title_inv    = {x = (_R - 112 +   0), y = (_T +   0 +   0), draw = true},
	p2flag_inv     = {x = (_R - 112 +  46), y = (_T +   0 +   0), draw = true},
	p2throw_inv    = {x = (_R - 112 +  60), y = (_T +   0 +   0), draw = true},
	p2stun_inv     = {x = (_R - 112 +  82), y = (_T +   0 +   0), draw = true},
	p2time_inv     = {x = (_R - 112 +  96), y = (_T +   0 +   0), draw = true},
	p2throw_inv_f  = {x = (_R - 156 +   0), y = (_T +   0 +   0), draw = true},
	p1anim_ptr     = {x = (_L + 102 +   0), y = (_T +   6 +   0), draw = true},
	p2anim_ptr     = {x = (_R - 160 +   0), y = (_T +   6 +   0), draw = true},
	p1animation    = {x = (_L +  34 +   0), y = (_T +  48 +   0), draw = true},
	p2animation    = {x = (_R - 144 +   0), y = (_T +  48 +   0), draw = true},
	p1leftframe    = {x = (_L + 102 +   0), y = (_T +  39 +   0), draw = true},
	p2leftframe    = {x = (_R - 160 +   0), y = (_T +  39 +   0), draw = true},
	p1multipurpose = {x = (_L +   1 +   0), y = (_B -   8 +   0), draw = true},
	p2multipurpose = {x = (_R -  24 +   0), y = (_B -   8 +   0), draw = true},
}