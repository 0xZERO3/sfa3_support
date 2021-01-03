essensial_width   = 384
essensial_height  = 224

program = {
	{
		version   = {"980629", "980727", "980904"},
		draw_data1 = true,
		menu_enabled = true,
		delay_adjust = function() return (0x02) end,
		scr_shift_x = function() return (0x00) end,
		scr_shift_y = function() return (0x10) end,
		scale_x = 1,
		scale_y = 1,
		proj_alive = 0x04000000,
		addr_shift = (0x00000000),
		conf      = {p_num = 4, proj_num  = 24},
		isgame = function(s00, s01, s02, s03) return ((s00 == 0x02) and (s01 == 0x04) and (s02 == 0x06)) end,
		throw_bp_mame_coop = function(i, j) return G_dbg:command(string.format("bp 0x%08X, a6==0x%08X, {temp%d=(d0 & 0xFF);g}", RAM.throw_bp.throw[j], m.obj.p_base[i] , i + 1 )) end,
		throw_bp_mame_nocoop = function(i) return  G_dbg:command(string.format("bp 0x%08X, 1, {maincpu.pb@(a6+0x032F)=(d0 & 0xFF); g}", RAM.throw_bp.throw[i])) end,
		throw_bp_mame_old = function(i) return     print(string.format("bp 0x%08X, 1, {maincpu.pb@(a6+0x032F)=(d0 & 0xFF); g}", RAM.throw_bp.throw[i])) end,
		cheat = {
			{desc = "Unlock",             addr = 0x00FF8000 + 0x00EE         , data = 0x0004, size = 1,  how = 0,  enable = true},
			{desc = "Game Speed",         addr = 0x00FF8000 + 0x0116         , data = 0x00,   size = 1,  how = 0,  enable = true},    -- (0:NORMAL 6:TURBO1 8:TURBO2)
			{desc = "Timer U",            addr = 0x00FF8000 + 0x0109         , data = 0x63,   size = 1,  how = 0,  enable = true},
			{desc = "Timer D",            addr = 0x00FF8000 + 0x010A         , data = 0x3B,   size = 1,  how = 0,  enable = true},
			{desc = "Vital 1P",           addr = 0x00FF8400 + 0x0050 + 0x0000, data = 0x0090, size = 2,  how = 0,  enable = true},
			{desc = "Vital 2P",           addr = 0x00FF8400 + 0x0050 + 0x0400, data = 0x0090, size = 2,  how = 0,  enable = true},
			{desc = "Vital 3P",           addr = 0x00FF8400 + 0x0050 + 0x0800, data = 0x0090, size = 2,  how = 0,  enable = false},
			{desc = "Vital 4P",           addr = 0x00FF8400 + 0x0050 + 0x0C00, data = 0x0090, size = 2,  how = 0,  enable = false},
			{desc = "Gauge 1P",           addr = 0x00FF8400 + 0x011E + 0x0000, data = 0x0090, size = 2,  how = 0,  enable = true},
			{desc = "Gauge 2P",           addr = 0x00FF8400 + 0x011E + 0x0400, data = 0x0090, size = 2,  how = 0,  enable = true},
			{desc = "Gauge 3P",           addr = 0x00FF8400 + 0x011E + 0x0800, data = 0x0090, size = 2,  how = 0,  enable = false},
			{desc = "Gauge 4P",           addr = 0x00FF8400 + 0x011E + 0x0C00, data = 0x0090, size = 2,  how = 0,  enable = false},
			{desc = "Operator 1P",        addr = 0x00FF8400 + 0x0125 + 0x0000, data = 0x01,   size = 1,  how = 0,  enable = false},     -- (0:HUMAN 1:CPU)
			{desc = "Operator 2P",        addr = 0x00FF8400 + 0x0125 + 0x0400, data = 0x01,   size = 1,  how = 0,  enable = false},     -- (0:HUMAN 1:CPU)
			{desc = "Operator 3P",        addr = 0x00FF8400 + 0x0125 + 0x0800, data = 0x01,   size = 1,  how = 0,  enable = false},     -- (0:HUMAN 1:CPU)
			{desc = "Operator 4P",        addr = 0x00FF8400 + 0x0125 + 0x0C00, data = 0x01,   size = 1,  how = 0,  enable = false},     -- (0:HUMAN 1:CPU)
		},
		hb = {
			-- Layer top to bottom is orange > red > yellow > green > purple > blue
			{hb = "oshi",		hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = nil,        id_key = "oshi_id",     id_offset = nil  },
			{hb = "foot",		hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = nil,        id_key = "foot_id",     id_offset = nil  },
			{hb = "body",		hbsize = 8,  addr_key = "body_addr",   addr_alt_key = nil,        id_key = "body_id",     id_offset = nil  },
			{hb = "head",		hbsize = 8,  addr_key = "head_addr",   addr_alt_key = nil,        id_key = "head_id",     id_offset = nil  },
			{hb = "attack",		hbsize = 32, addr_key = "attack_addr", addr_alt_key = "anim_ptr", id_key = nil,           id_offset = 0x09 },
		},
		hbproj = {
			{hb = "projoshi",	hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = nil,        id_key = "oshi_id",     id_offset = nil  },
			{hb = "projfoot",	hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = nil,        id_key = "foot_id",     id_offset = nil  },
			{hb = "projbody",	hbsize = 8,  addr_key = "body_addr",   addr_alt_key = nil,        id_key = "body_id",     id_offset = nil  },
			{hb = "projhead",	hbsize = 8,  addr_key = "head_addr",   addr_alt_key = nil,        id_key = "head_id",     id_offset = nil  },
			{hb = "projattack",	hbsize = 32, addr_key = "attack_addr", addr_alt_key = "anim_ptr", id_key = nil,           id_offset = 0x09 },
		},
		hbthrow = {
			{hb = "throw",		hbsize = 32, addr_key = "attack_addr", addr_alt_key = nil,        id_key = "throw_id",    id_offset = nil  },
		},
		hbwire = {
			{hb = "wire",		hbsize = 32, addr_key = "attack_addr", addr_alt_key = nil,        id_key = "wire_src",    id_offset = nil  },
		},
		throw_bp = {
			["980629"]     = {throw = {0x0002E20C, 0x0002E226, 0x0002E3F8, 0x0002E410, 0x0002E430, 0x0002E44E, 0x0002E500, 0x0002E510, 0x0002E520}, wire = {0x000506CC}},	-- wire_x write:0x000506C0
			["980727"]     = {throw = {0x0002E212, 0x0002E22C, 0x0002E3FE, 0x0002E416, 0x0002E436, 0x0002E454, 0x0002E506, 0x0002E516, 0x0002E526}, wire = {0x000506D2}},	-- wire_x write:0x000506C6
			["980904"]     = {throw = {0x0002E3E4, 0x0002E402, 0x0002E5D8, 0x0002E5F4, 0x0002E618, 0x0002E63A, 0x0002E6F0, 0x0002E704, 0x0002E718}, wire = {0x000508CE}},	-- wire_x write:0x000508C2
		},
		cmm = {
			base  = 0x00FF8000,
			element = {
				status00       = {sign = "u",      size = 2,       offset = 0x0000},
				status01       = {sign = "u",      size = 2,       offset = 0x0004},
				status02       = {sign = "u",      size = 2,       offset = 0x0008},
				status03       = {sign = "u",      size = 2,       offset = 0x000C},
				status04       = {sign = "u",      size = 2,       offset = 0x0010},
				P1_org_button  = {sign = "u",      size = 1,       offset = 0x0058},
				P1_org_lever   = {sign = "u",      size = 1,       offset = 0x0059},
				P1_cp1_button  = {sign = "u",      size = 1,       offset = 0x005A},
				P1_cp1_lever   = {sign = "u",      size = 1,       offset = 0x005B},
				P2_org_button  = {sign = "u",      size = 1,       offset = 0x005C},
				P2_org_lever   = {sign = "u",      size = 1,       offset = 0x005D},
				P2_cp1_button  = {sign = "u",      size = 1,       offset = 0x005E},
				P2_cp1_lever   = {sign = "u",      size = 1,       offset = 0x005F},
				start_coin_org = {sign = "u",      size = 1,       offset = 0x0060},
				start_coin_cp1 = {sign = "u",      size = 1,       offset = 0x0061},
				start_coin_cp2 = {sign = "u",      size = 1,       offset = 0x0062},
				start_coin_cp3 = {sign = "u",      size = 1,       offset = 0x0063},
				service_org    = {sign = "u",      size = 1,       offset = 0x0064},
				service_cp1    = {sign = "u",      size = 1,       offset = 0x0065},
				service_cp2    = {sign = "u",      size = 1,       offset = 0x0066},
				service_cp3    = {sign = "u",      size = 1,       offset = 0x0067},
				credit_1P_n    = {sign = "u",      size = 1,       offset = 0x0071},
				credit_1P      = {sign = "u",      size = 1,       offset = 0x0076},
				credit_2P_n    = {sign = "u",      size = 1,       offset = 0x0079},
				credit_2P      = {sign = "u",      size = 1,       offset = 0x007E},
				lapsed_time    = {sign = "u",      size = 2,       offset = 0x00B2},
				coin_count     = {sign = "u",      size = 4,       offset = 0x00C0},
				service_count  = {sign = "u",      size = 4,       offset = 0x00C4},
				freeplay_count = {sign = "u",      size = 4,       offset = 0x00C8},
				stage          = {sign = "u",      size = 1,       offset = 0x0101},
				timer          = {sign = "u",      size = 1,       offset = 0x0109},
				timer_frame    = {sign = "u",      size = 1,       offset = 0x010A},
				turbo_speed    = {sign = "u",      size = 1,       offset = 0x0116},
				cam_x          = {sign = "s",      size = 2,       offset = 0x0290},
				cam_y          = {sign = "s",      size = 2,       offset = 0x0294},
			}
		},
		obj = {
			p_base    = {
				0x00FF8400, 0x00FF8800, 0x00FF8C00, 0x00FF9000
			},
			proj_base = {
				0x00FF9400, 0x00FF9500, 0x00FF9600, 0x00FF9700, 0x00FF9800, 0x00FF9900,
				0x00FF9A00, 0x00FF9B00, 0x00FF9C00, 0x00FF9D00, 0x00FF9E00, 0x00FF9F00,
				0x00FFA000, 0x00FFA100, 0x00FFA200, 0x00FFA300, 0x00FFA400, 0x00FFA500,
				0x00FFA600, 0x00FFA700, 0x00FFA800, 0x00FFA900, 0x00FFAA00, 0x00FFAB00
			},
			element = {
				exist			= {sign = "u",      size = 1,       offset = 0x0000},
				draw			= {sign = "u",      size = 1,       offset = 0x0001},
				motion00		= {sign = "u",      size = 1,       offset = 0x0004},
				motion01		= {sign = "u",      size = 1,       offset = 0x0005},
				motion02		= {sign = "u",      size = 1,       offset = 0x0006},
				motion03		= {sign = "u",      size = 1,       offset = 0x0007},
				direction		= {sign = "u",      size = 1,       offset = 0x000B},
				x				= {sign = "s",      size = 2,       offset = 0x0010},
				x_sub			= {sign = "u",      size = 2,       offset = 0x0012},
				y				= {sign = "s",      size = 2,       offset = 0x0014},
				y_sub			= {sign = "u",      size = 2,       offset = 0x0016},
				anim_ptr		= {sign = "u",      size = 4,       offset = 0x001C},
				char_state		= {sign = "u",      size = 1,       offset = 0x0031},
				anim_left		= {sign = "u",      size = 1,       offset = 0x0032},
				enemy_2byteaddr	= {sign = "u",      size = 2,       offset = 0x0038},
				multipurpose	= {sign = "u",      size = 2,       offset = 0x003A},
				speed_x			= {sign = "s",      size = 2,       offset = 0x0040},
				speed_x_sub		= {sign = "u",      size = 2,       offset = 0x0042},
				speed_y			= {sign = "s",      size = 2,       offset = 0x0044},
				speed_y_sub		= {sign = "u",      size = 2,       offset = 0x0046},
				accel_x			= {sign = "s",      size = 2,       offset = 0x0048},
				accel_x_sub		= {sign = "s",      size = 2,       offset = 0x004A},
				accel_y			= {sign = "s",      size = 2,       offset = 0x004C},
				accel_y_sub		= {sign = "s",      size = 2,       offset = 0x004E},
				vital			= {sign = "s",      size = 2,       offset = 0x0050},
				vital_copy		= {sign = "s",      size = 2,       offset = 0x0052},
				combo			= {sign = "u",      size = 1,       offset = 0x005E},
				freeze			= {sign = "u",      size = 1,       offset = 0x005F},
				throw_inv		= {sign = "u",      size = 1,       offset = 0x0067},
				wire_src		= {sign = "u",      size = 1,       offset = 0x0082},
				head_addr		= {sign = "u",      size = 4,       offset = 0x0090},
				body_addr		= {sign = "u",      size = 4,       offset = 0x0094},
				foot_addr		= {sign = "u",      size = 4,       offset = 0x0098},
				oshi_addr		= {sign = "u",      size = 4,       offset = 0x009C},
				attack_addr		= {sign = "u",      size = 4,       offset = 0x00A0},
				attack_flg		= {sign = "u",      size = 1,       offset = 0x00A9},
				trick_id		= {sign = "u",      size = 1,       offset = 0x00AA},
				corner_pos		= {sign = "u",      size = 1,       offset = 0x00AC},
				cc_left			= {sign = "u",      size = 1,       offset = 0x00BB},
				taunt_left		= {sign = "u",      size = 1,       offset = 0x00BC},
				cc_flg			= {sign = "u",      size = 1,       offset = 0x00B9},
				counter_flg		= {sign = "u",      size = 1,       offset = 0x00C7},
				head_id			= {sign = "u",      size = 1,       offset = 0x00C8},
				body_id			= {sign = "u",      size = 1,       offset = 0x00C9},
				foot_id			= {sign = "u",      size = 1,       offset = 0x00CA},
				oshi_id			= {sign = "u",      size = 1,       offset = 0x00CB},
				flag_inv		= {sign = "u",      size = 1,       offset = 0x00D6},
			},
			element_detail = {
				char_id			= {sign = "u",      size = 1,       offset = 0x0102},
				combo_max		= {sign = "u",      size = 1,       offset = 0x0115},
				power			= {sign = "s",      size = 2,       offset = 0x011E},
				control			= {sign = "u",      size = 1,       offset = 0x0125},
				wire_x			= {sign = "s",      size = 2,       offset = 0x01E4},
				throw_inv_f		= {sign = "u",      size = 1,       offset = 0x023F},
				guard_recov		= {sign = "u",      size = 1,       offset = 0x024B},
				guard_max		= {sign = "u",      size = 1,       offset = 0x024C},
				guard			= {sign = "u",      size = 1,       offset = 0x024D},
				guard_crushing	= {sign = "u",      size = 1,       offset = 0x024E},
				time_inv		= {sign = "u",      size = 1,       offset = 0x025D},
				shiten			= {sign = "u",      size = 1,       offset = 0x0284},
				shiten_frame	= {sign = "u",      size = 1,       offset = 0x0285},
				block_num		= {sign = "u",      size = 1,       offset = 0x0297},
				close			= {sign = "u",      size = 1,       offset = 0x0298},
				anim_addr1		= {sign = "u",      size = 4,       offset = 0x02B0},
				anim_addr2		= {sign = "u",      size = 4,       offset = 0x02B4},
				anim_addr3		= {sign = "u",      size = 4,       offset = 0x02B8},
				anim_addr4		= {sign = "u",      size = 4,       offset = 0x02BC},
				stun_recov		= {sign = "u",      size = 1,       offset = 0x02CB},
				stun			= {sign = "u",      size = 1,       offset = 0x02CC},
				stun_max		= {sign = "u",      size = 1,       offset = 0x02CD},
				stun_inv		= {sign = "u",      size = 1,       offset = 0x02CE},
				stun_flag		= {sign = "u",      size = 1,       offset = 0x02CF},
				throw_id		= {sign = "u",      size = 1,       offset = 0x032F},
			}
		},
		motion_table = {
			{0x00, 0x00, 0x00, 0x00, "None"},
			
			{0x02, 0x00, 0x00, 0x00, "Neutral"},
			{0x02, 0x00, 0x00, 0x02, "Stand"},
			{0x02, 0x00, 0x00, 0x04, "Sit"},
			
			{0x02, 0x00, 0x02, 0x00, "Stand->Sit01"},
			{0x02, 0x00, 0x02, 0x02, "Stand->Sit02"},
			{0x02, 0x00, 0x02, 0x04, "Sit->Stand01"},
			{0x02, 0x00, 0x02, 0x06, "Sit->Stand02"},
			
			---------------------------------------
			{0x02, 0x00, 0x04, 0x02, "Walk"},
			
			{0x02, 0x00, 0x06, 0x00, "BeforeJump"},
			{0x02, 0x00, 0x06, 0x02, "Jump"},
			{0x02, 0x00, 0x06, 0x04, "AfterJump"},
			{0x02, 0x00, 0x06, 0x06, "JumpAttack"},
			{0x02, 0x00, 0x06, 0x08, "JumpBlock"},
			{0x02, 0x00, 0x06, 0x0A, "CornerJump"},
			---------------------------------------
			---------------------------------------
			{0x02, 0x00, 0x06, 0x10, "Tech"},
			
			{0x02, 0x00, 0x08, 0x00, "StandChgDir"},
			{0x02, 0x00, 0x08, 0x02, "SitChgDir"},
			
			{0x02, 0x00, 0x0A, 0x00, "Attack01"},
			{0x02, 0x00, 0x0A, 0x02, "Attack02"},
			{0x02, 0x00, 0x0A, 0x04, "Attack03"},
			{0x02, 0x00, 0x0A, 0x06, "Attack04"},
			{0x02, 0x00, 0x0A, 0x08, "Attack05"},
			{0x02, 0x00, 0x0A, 0x0A, "Attack06"},
			{0x02, 0x00, 0x0A, 0x0C, "Attack07"},
			{0x02, 0x00, 0x0A, 0x0E, "Attack08"},
			
			{0x02, 0x00, 0x0C, 0x00, "StandBlock01"},
			{0x02, 0x00, 0x0C, 0x02, "StandBlock02"},
			{0x02, 0x00, 0x0C, 0x04, "SitBlock01"},
			{0x02, 0x00, 0x0C, 0x06, "SitBlock02"},
			---------------------------------------
			{0x02, 0x00, 0x0C, 0x0A, "Avoid01"},
			{0x02, 0x00, 0x0C, 0x0C, "Avoid02"},
			
			{0x02, 0x00, 0x0E, 0x00, "Special01"},
			{0x02, 0x00, 0x0E, 0x02, "Special02"},
			{0x02, 0x00, 0x0E, 0x04, "Special03"},
			{0x02, 0x00, 0x0E, 0x06, "Special04"},
			{0x02, 0x00, 0x0E, 0x08, "Special05"},
			{0x02, 0x00, 0x0E, 0x0A, "Special06"},
			{0x02, 0x00, 0x0E, 0x0C, "Special07"},
			{0x02, 0x00, 0x0E, 0x0E, "Special08"},
			{0x02, 0x00, 0x0E, 0x10, "Special09"},
			{0x02, 0x00, 0x0E, 0x12, "Special10"},
			{0x02, 0x00, 0x0E, 0x14, "Special11"},
			{0x02, 0x00, 0x0E, 0x16, "Special12"},
			{0x02, 0x00, 0x0E, 0x18, "Special13"},
			{0x02, 0x00, 0x0E, 0x1A, "Special14"},
			{0x02, 0x00, 0x0E, 0x1C, "Special15"},
			{0x02, 0x00, 0x0E, 0x1E, "Special16"},
			{0x02, 0x00, 0x0E, 0x20, "Special17"},
			{0x02, 0x00, 0x0E, 0x22, "Special18"},
			{0x02, 0x00, 0x0E, 0x24, "Special19"},
			
			{0x02, 0x00, 0x10, 0x00, "Super01"},
			{0x02, 0x00, 0x10, 0x02, "Super02"},
			{0x02, 0x00, 0x10, 0x04, "Super03"},
			{0x02, 0x00, 0x10, 0x06, "Super04"},
			{0x02, 0x00, 0x10, 0x08, "Super05"},
			{0x02, 0x00, 0x10, 0x0A, "Super06"},
			{0x02, 0x00, 0x10, 0x0C, "Super07"},
			{0x02, 0x00, 0x10, 0x0E, "Super08"},
			{0x02, 0x00, 0x10, 0x10, "Super09"},
			{0x02, 0x00, 0x10, 0x12, "Super10"},
			{0x02, 0x00, 0x10, 0x14, "Super11"},
			{0x02, 0x00, 0x10, 0x16, "Super12"},
			{0x02, 0x00, 0x10, 0x18, "Super13"},
			{0x02, 0x00, 0x10, 0x1A, "Super14"},
			{0x02, 0x00, 0x10, 0x1C, "Super15"},
			{0x02, 0x00, 0x10, 0x1E, "Super16"},
			{0x02, 0x00, 0x10, 0x20, "Super17"},
			{0x02, 0x00, 0x10, 0x22, "Super18"},
			{0x02, 0x00, 0x10, 0x24, "Super19"},
			{0x02, 0x00, 0x10, 0x26, "Super20"},
			{0x02, 0x00, 0x10, 0x28, "Super21"},
			{0x02, 0x00, 0x10, 0x2A, "Super22"},
			
			{0x02, 0x02, 0x00, 0x00, "Hit:Secial"},
			{0x02, 0x02, 0x00, 0x02, "Hit"},
			{0x02, 0x02, 0x00, 0x04, "Block"},
			
			{0x02, 0x02, 0x02, 0x00, "HitBack01"},
			{0x02, 0x02, 0x02, 0x02, "HitBack02"},
			{0x02, 0x02, 0x02, 0x04, "HitBack03"},
			{0x02, 0x02, 0x02, 0x06, "HitBack04"},
			{0x02, 0x02, 0x02, 0x08, "HitBack05"},
			{0x02, 0x02, 0x02, 0x0A, "HitBack06"},
			
			{0x02, 0x02, 0x04, 0x00, "Reversal"},
			
			{0x02, 0x04, 0x00, 0x00, "Throw01"},
			{0x02, 0x04, 0x00, 0x02, "Throw02"},
			{0x02, 0x04, 0x00, 0x04, "Throw03"},
			{0x02, 0x04, 0x00, 0x06, "Throw04"},
			{0x02, 0x04, 0x00, 0x08, "Throw05"},
			{0x02, 0x04, 0x00, 0x0A, "Throw06"},
			{0x02, 0x04, 0x00, 0x0C, "Throw07"},
			{0x02, 0x04, 0x00, 0x0E, "Throw08"},
			{0x02, 0x04, 0x00, 0x10, "Throw09"},
			{0x02, 0x04, 0x00, 0x12, "Throw10"},
			{0x02, 0x04, 0x00, 0x14, "Throw11"},
			{0x02, 0x04, 0x00, 0x16, "Throw12"},
			{0x02, 0x04, 0x00, 0x18, "Throw13"},
			
			{0x02, 0x06, 0x00, 0x00, "Thrown01"},
			{0x02, 0x06, 0x00, 0x02, "Thrown02"},
			
			{0x02, 0x08, 0x00, 0x00, "Winner01-01"},
			{0x02, 0x08, 0x00, 0x02, "Winner01-02"},
			{0x02, 0x08, 0x00, 0x04, "Winner01-03"},
			{0x02, 0x08, 0x00, 0x06, "Winner01-04"},
			{0x02, 0x08, 0x00, 0x08, "Winner01-05"},
			{0x02, 0x08, 0x00, 0x0A, "Winner01-06"},
			{0x02, 0x08, 0x00, 0x0C, "Winner01-07"},
			{0x02, 0x08, 0x00, 0x0E, "Winner01-08"},
			{0x02, 0x08, 0x00, 0x10, "Winner01-09"},
			{0x02, 0x08, 0x00, 0x12, "Winner01-10"},
			
			{0x02, 0x08, 0x02, 0x00, "Winner02-01"},
			
			{0x02, 0x08, 0x04, 0x00, "Winner03-01"},
			{0x02, 0x08, 0x04, 0x02, "Winner03-02"},
			{0x02, 0x08, 0x04, 0x04, "Winner03-03"},
			{0x02, 0x08, 0x04, 0x06, "Winner03-04"},
			{0x02, 0x08, 0x04, 0x08, "Winner03-05"},
			{0x02, 0x08, 0x04, 0x0A, "Winner03-06"},
			{0x02, 0x08, 0x04, 0x0C, "Winner03-07"},
			
			{0x02, 0x08, 0x06, 0x00, "Winner04-01"},
			{0x02, 0x08, 0x06, 0x02, "Winner04-02"},
			
			{0x02, 0x08, 0x08, 0x00, "Winner05-01"},
			{0x02, 0x08, 0x08, 0x02, "Winner05-02"},
			
			{0x02, 0x08, 0x0A, 0x00, "Winner06-01"},
			
			{0x02, 0x08, 0x0C, 0x00, "Winner07-01"},
			
			{0x02, 0x08, 0xFF, 0x00, "WinnerFF-01"},
			{0x02, 0x08, 0xFF, 0x02, "WinnerFF-02"},
			{0x02, 0x08, 0xFF, 0x04, "WinnerFF-03"},
			{0x02, 0x08, 0xFF, 0x06, "WinnerFF-04"},
			
			{0x02, 0x0A, 0x00, 0x00, "TimeUp01-01"},
			
			{0x02, 0x0A, 0x02, 0x00, "TimeUp02-01"},
			
			{0x02, 0x0A, 0x04, 0x00, "TimeUp03-01"},
			
			{0x02, 0x0A, 0x06, 0x00, "TimeUp04-01"},
			{0x02, 0x0A, 0x06, 0x02, "TimeUp04-02"},
			{0x02, 0x0A, 0x06, 0x04, "TimeUp04-03"},
			{0x02, 0x0A, 0x06, 0x06, "TimeUp04-04"},
			{0x02, 0x0A, 0x06, 0x08, "TimeUp04-05"},
			{0x02, 0x0A, 0x06, 0x0A, "TimeUp04-06"},
			{0x02, 0x0A, 0x06, 0x0C, "TimeUp04-07"},
			
			{0x02, 0x0C, 0x00, 0x00, "Loser01"},
			{0x02, 0x0C, 0x00, 0x02, "Loser02"},
			{0x02, 0x0C, 0x00, 0x04, "Loser03"},
			
			{0x02, 0x0E, 0x00, 0x00, "Ready01-01"},
			{0x02, 0x0E, 0x00, 0x02, "Ready01-02"},
			{0x02, 0x0E, 0x00, 0x04, "Ready01-03"},
			{0x02, 0x0E, 0x00, 0x06, "Ready01-04"},
			{0x02, 0x0E, 0x00, 0x08, "Ready01-05"},
			{0x02, 0x0E, 0x00, 0x0A, "Ready01-06"},
			{0x02, 0x0E, 0x00, 0x0C, "Ready01-07"},
			{0x02, 0x0E, 0x00, 0x0E, "Ready01-08"},
			{0x02, 0x0E, 0x00, 0x10, "Ready01-09"},
			{0x02, 0x0E, 0x00, 0x12, "Ready01-10"},
			{0x02, 0x0E, 0x00, 0x14, "Ready01-11"},
			{0x02, 0x0E, 0x00, 0x16, "Ready01-12"},
			{0x02, 0x0E, 0x00, 0x18, "Ready01-13"},
			{0x02, 0x0E, 0x00, 0x1A, "Ready01-14"},
			{0x02, 0x0E, 0x00, 0x1C, "Ready01-15"},
			{0x02, 0x0E, 0x00, 0x1E, "Ready01-16"},
			---------------------------------------
			{0x02, 0x0E, 0x00, 0x22, "Ready01-18"},
			
			{0x02, 0x0E, 0x02, 0x00, "Ready02-01"},
			{0x02, 0x0E, 0x02, 0x02, "Ready02-02"},
			
			{0x02, 0x0E, 0x04, 0x00, "Ready03-01"},
			{0x02, 0x0E, 0x04, 0x02, "Ready03-02"},
			
			{0x02, 0x0E, 0x06, 0x00, "Ready04-01"},
			
			{0x02, 0x0E, 0x08, 0x00, "Ready05-01"},
			
			{0x02, 0x10, 0x00, 0x00, "Roll01"},
			{0x02, 0x10, 0x02, 0x00, "Roll02"},
			{0x02, 0x10, 0x04, 0x00, "Roll03"},
		}
	},
	{
		version   = {"SLPM 66409"},
		draw_data1 = false,
		menu_enabled = false,
		delay_adjust = function() return (0x03) end,
		scr_shift_x = function() return (0x00) end,
		scr_shift_y = function() return (-0x202) end,
		scale_x = w_scr_width()/essensial_width,
		scale_y = w_scr_height()/essensial_height,
		proj_alive = 0x04000000,
		addr_shift = (0x00000000),
		conf      = {p_num = 4, proj_num  = 24},
		isgame = function(s00, s01, s02, s03) return ((s00 == 0x02) and (s01 == 0x04) and (s02 == 0x06)) end,
		hb = {
			-- Layer top to bottom is orange > red > yellow > green > purple > blue
			{hb = "oshi",		hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = nil,        id_key = "oshi_id",     id_offset = nil  },
			{hb = "foot",		hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = nil,        id_key = "foot_id",     id_offset = nil  },
			{hb = "body",		hbsize = 8,  addr_key = "body_addr",   addr_alt_key = nil,        id_key = "body_id",     id_offset = nil  },
			{hb = "head",		hbsize = 8,  addr_key = "head_addr",   addr_alt_key = nil,        id_key = "head_id",     id_offset = nil  },
			{hb = "attack",		hbsize = 32, addr_key = "attack_addr", addr_alt_key = "anim_ptr", id_key = nil,           id_offset = 0x09 },
		},
		hbproj = {
			{hb = "projoshi",	hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = nil,        id_key = "oshi_id",     id_offset = nil  },
			{hb = "projfoot",	hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = nil,        id_key = "foot_id",     id_offset = nil  },
			{hb = "projbody",	hbsize = 8,  addr_key = "body_addr",   addr_alt_key = nil,        id_key = "body_id",     id_offset = nil  },
			{hb = "projhead",	hbsize = 8,  addr_key = "head_addr",   addr_alt_key = nil,        id_key = "head_id",     id_offset = nil  },
			{hb = "projattack",	hbsize = 32, addr_key = "attack_addr", addr_alt_key = "anim_ptr", id_key = nil,           id_offset = 0x09 },
		},
		hbthrow = {
		},
		hbwire = {
		},
		throw_bp = {
			["SLPM 66409"] = {throw = {}, wire = {}},
		},
		cmm = {
			base  = 0x00FF8000 + FG,
			element = {
				status00    = {sign = "u",      size = 2,       offset = 0x0000},
				status01    = {sign = "u",      size = 2,       offset = 0x0004},
				status02    = {sign = "u",      size = 2,       offset = 0x0008},
				cam_x       = {sign = "s",      size = 2,       offset = 0x0292},
				cam_y       = {sign = "s",      size = 2,       offset = 0x0296},
			}
		},
		obj = {
			p_base    = {
				0x00FF8400 + FG, 0x00FF8800 + FG, 0x00FF8C00 + FG, 0x00FF9000 + FG
			},
			proj_base = {
				0x00FF9400 + FG, 0x00FF9500 + FG, 0x00FF9600 + FG, 0x00FF9700 + FG, 0x00FF9800 + FG, 0x00FF9900 + FG,
				0x00FF9A00 + FG, 0x00FF9B00 + FG, 0x00FF9C00 + FG, 0x00FF9D00 + FG, 0x00FF9E00 + FG, 0x00FF9F00 + FG,
				0x00FFA000 + FG, 0x00FFA100 + FG, 0x00FFA200 + FG, 0x00FFA300 + FG, 0x00FFA400 + FG, 0x00FFA500 + FG,
				0x00FFA600 + FG, 0x00FFA700 + FG, 0x00FFA800 + FG, 0x00FFA900 + FG, 0x00FFAA00 + FG, 0x00FFAB00 + FG
			},
			element = {
				exist			= {sign = "u",      size = 1,       offset = 0x0000},
				draw			= {sign = "u",      size = 1,       offset = 0x0001},
				motion00		= {sign = "u",      size = 1,       offset = 0x0004},
				motion01		= {sign = "u",      size = 1,       offset = 0x0005},
				motion02		= {sign = "u",      size = 1,       offset = 0x0006},
				motion03		= {sign = "u",      size = 1,       offset = 0x0007},
				direction		= {sign = "u",      size = 1,       offset = 0x000B},
				x_sub			= {sign = "s",      size = 2,       offset = 0x0010},
				x				= {sign = "s",      size = 2,       offset = 0x0012},
				y_sub			= {sign = "s",      size = 2,       offset = 0x0014},
				y				= {sign = "s",      size = 2,       offset = 0x0016},
				anim_ptr		= {sign = "u",      size = 4,       offset = 0x001C},
				head_addr		= {sign = "u",      size = 4,       offset = 0x0090},
				body_addr		= {sign = "u",      size = 4,       offset = 0x0094},
				foot_addr		= {sign = "u",      size = 4,       offset = 0x0098},
				oshi_addr		= {sign = "u",      size = 4,       offset = 0x009C},
				attack_addr		= {sign = "u",      size = 4,       offset = 0x00A0},
				head_id			= {sign = "u",      size = 1,       offset = 0x00C8},
				body_id			= {sign = "u",      size = 1,       offset = 0x00C9},
				foot_id			= {sign = "u",      size = 1,       offset = 0x00CA},
				oshi_id			= {sign = "u",      size = 1,       offset = 0x00CB},
			},
			element_detail = {
			}
		},
		cheat = {
		}
	},
	{
		version   = {"SLPS 01777"},
		draw_data1 = false,
		menu_enabled = false,
		delay_adjust = function() return (0x02) end,
		scr_shift_x = function() if (G_emulator == "mame" or G_emulator == "mame_old") then return (-0x0D) elseif (G_emulator == "bizhawk") then return (0x06) elseif (G_emulator == "psxjin") then return (0x00) end end,
		scr_shift_y = function() if (G_emulator == "mame" or G_emulator == "mame_old") then return (0x08)  elseif (G_emulator == "bizhawk") then return (0x07) elseif (G_emulator == "psxjin") then return (0x07) end end,
		scale_x = 1,
		scale_y = 1,
		proj_alive = 0x02000000,
		addr_shift = (-0x80000000),
		conf      = {p_num = 4, proj_num  = 24},
		isgame = function(s00, s01, s02, s03) return ((s00 == 0x01) and (s01 == 0x02) and (s02 == 0x03)) end,
		hb = {
			{hb = "oshi",		hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x03 },
			{hb = "foot",		hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x02 },
			{hb = "body",		hbsize = 8,  addr_key = "body_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x01 },
			{hb = "head",		hbsize = 8,  addr_key = "head_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x00 },
			{hb = "attack",		hbsize = 32, addr_key = "attack_addr", addr_alt_key = "attack_alt", id_key = nil, id_offset = 0x01 },
		},
		hbproj = {
			{hb = "projoshi",	hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x03 },
			{hb = "projfoot",	hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x02 },
			{hb = "projbody",	hbsize = 8,  addr_key = "body_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x01 },
			{hb = "projhead",	hbsize = 8,  addr_key = "head_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x00 },
			{hb = "projattack",	hbsize = 32, addr_key = "attack_addr", addr_alt_key = "attack_alt", id_key = nil, id_offset = 0x01 },
		},
		hbthrow = {
		},
		hbwire = {
		},
		throw_bp = {
			["SLPS 01777"] = {throw = {}, wire = {}},
		},
		cmm = {
			base  = 0x00193f28,
			element = {
				status00    = {sign = "u",      size = 2,       offset = 0x0000},
				status01    = {sign = "u",      size = 2,       offset = 0x0002},
				status02    = {sign = "u",      size = 2,       offset = 0x0004},
				cam_x       = {sign = "s",      size = 2,       offset = 0x0A32},
				cam_y       = {sign = "s",      size = 2,       offset = 0x0A36},
			}
		},
		obj = {
			p_base    = {
			--  1P          2P          3P          4P
				0x00194018, 0x00194460, 0x0019E248, 0x0019E690
			},
			proj_base = {
				0x0019D118, 0x0019D264, 0x0019D3B0, 0x0019D4FC, 0x0019D648, 0x0019D794,
				0x0019D8E0, 0x0019DA2C, 0x0019DB78, 0x0019DCC4, 0x0019DE10, 0x0019DF5C,
				0x0019AB50, 0x0019AC9C, 0x0019ADE8, 0x0019AF34, 0x0019B080, 0x0019B1CC,
				0x0019B318, 0x0019B464, 0x0019B5B0, 0x0019B6FC, 0x0019B848, 0x0019B994
			},
			element = {
				exist			= {sign = "u",      size = 1,       offset = 0x0000},
				draw			= {sign = "u",      size = 1,       offset = 0x0001},
				motion00		= {sign = "u",      size = 1,       offset = 0x0004},
				motion01		= {sign = "u",      size = 1,       offset = 0x0005},
				motion02		= {sign = "u",      size = 1,       offset = 0x0006},
				motion03		= {sign = "u",      size = 1,       offset = 0x0007},
				direction		= {sign = "u",      size = 1,       offset = 0x000B},
				x				= {sign = "s",      size = 2,       offset = 0x0012},
				x_sub			= {sign = "s",      size = 2,       offset = 0x0014},
				y				= {sign = "s",      size = 2,       offset = 0x0016},
				y_sub			= {sign = "s",      size = 2,       offset = 0x0018},
				head_addr		= {sign = "u",      size = 4,       offset = 0x00C4},
				body_addr		= {sign = "u",      size = 4,       offset = 0x00C8},
				foot_addr		= {sign = "u",      size = 4,       offset = 0x00CC},
				oshi_addr		= {sign = "u",      size = 4,       offset = 0x00D0},
				attack_addr		= {sign = "u",      size = 4,       offset = 0x00D4},
				form_set		= {sign = "u",      size = 4,       offset = 0x00F4},
				attack_alt		= {sign = "u",      size = 4,       offset = 0x011C},
			},
			element_detail = {
			}
		},
		cheat = {
--			{desc = "unlock01", addr = 0x001143B8, data = 0x01, size = 1, how = 0, enable = true},
--			{desc = "unlock02", addr = 0x001143D8, data = 0x01, size = 1, how = 0, enable = true},
--			{desc = "unlock03", addr = 0x001143F8, data = 0x01, size = 1, how = 0, enable = true},
		}
	},
	{
		-- Sega Saturn' endian is big(bad code)
		version   = {"T-1246G"},
		draw_data1 = false,
		menu_enabled = false,
		delay_adjust = function() return (0x02) end,
		scr_shift_x = function() return (-0x21) end,
		scr_shift_y = function() return (-0x1D1) end,
		scale_x = 2,
		scale_y = w_scr_height()/240,
		proj_alive = 0x04000000,
		addr_shift = (-0x00200000),
		conf      = {p_num = 4, proj_num  = 24},
		isgame = function(s00, s01, s02, s03) return ((s00 == 0x01) and (s01 == 0x02) and (s02 == 0x03)) end,
		hb = {
			-- Layer top to bottom is orange > red > yellow > green > purple > blue
			{hb = "oshi",		hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = nil,        id_key = "oshi_id",     id_offset = nil  },
			{hb = "foot",		hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = nil,        id_key = "foot_id",      id_offset = nil  },
			{hb = "body",		hbsize = 8,  addr_key = "body_addr",   addr_alt_key = nil,        id_key = "body_id",     id_offset = nil  },
			{hb = "head",		hbsize = 8,  addr_key = "head_addr",   addr_alt_key = nil,        id_key = "head_id",     id_offset = nil  },
			{hb = "attack",		hbsize = 30, addr_key = "attack_addr", addr_alt_key = "anim_ptr", id_key = nil,           id_offset = 0x08 },
		},
		hbproj = {
			{hb = "projoshi",	hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = nil,        id_key = "oshi_id",     id_offset = nil  },
			{hb = "projfoot",	hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = nil,        id_key = "foot_id",      id_offset = nil  },
			{hb = "projbody",	hbsize = 8,  addr_key = "body_addr",   addr_alt_key = nil,        id_key = "body_id",     id_offset = nil  },
			{hb = "projhead",	hbsize = 8,  addr_key = "head_addr",   addr_alt_key = nil,        id_key = "head_id",     id_offset = nil  },
			{hb = "projattack",	hbsize = 30, addr_key = "attack_addr", addr_alt_key = "anim_ptr", id_key = nil,           id_offset = 0x08 },
		},
		hbthrow = {
		},
		hbwire = {
		},
		throw_bp = {
			["T-1246G"] = {throw = {}, wire = {}},
		},
		cmm = {
			base  = 0x005DA74,
			element = {
				status00    = {sign = "u",      size = 2,       offset = 0x0000},
				status01    = {sign = "u",      size = 2,       offset = 0x0004},
				status02    = {sign = "u",      size = 2,       offset = 0x0008},
				cam_x       = {sign = "s",      size = 2,       offset = 0x8308},
				cam_y       = {sign = "s",      size = 2,       offset = 0x830C},
			}
		},
		obj = {
			p_base    = {
				0x0005DBE4, 0x005DFEC, 0x005E3F4, 0x005E7FC
			},
			proj_base = {
				0x0005EC04, 0x0005ED20, 0x0005EE3C, 0x0005EF58, 0x0005F074, 0x0005F190,
				0x0005F2AC, 0x0005F3C8, 0x0005F4E4, 0x0005F600, 0x0005F71C, 0x0005F838,
				0x0005F954, 0x0005FA70, 0x0005FB8C, 0x0005FCA8, 0x0005FDC4, 0x0005FEE0,
				0x0005FFFC, 0x00060118, 0x00060234, 0x00060350, 0x0006046C, 0x00060588
			},
			element = {
				exist			= {sign = "u",      size = 1,       offset = 0x0000},
				draw			= {sign = "u",      size = 1,       offset = 0x0001},
				motion00		= {sign = "u",      size = 1,       offset = 0x0004},
				motion01		= {sign = "u",      size = 1,       offset = 0x0005},
				motion02		= {sign = "u",      size = 1,       offset = 0x0006},
				motion03		= {sign = "u",      size = 1,       offset = 0x0007},
				direction		= {sign = "u",      size = 1,       offset = 0x000A},
				x				= {sign = "s",      size = 2,       offset = 0x0010},
				x_sub			= {sign = "s",      size = 2,       offset = 0x0012},
				y				= {sign = "s",      size = 2,       offset = 0x0014},
				y_sub			= {sign = "s",      size = 2,       offset = 0x0016},
				anim_ptr		= {sign = "u",      size = 4,       offset = 0x001C},
				head_addr		= {sign = "u",      size = 4,       offset = 0x00A0},
				body_addr		= {sign = "u",      size = 4,       offset = 0x00A4},
				foot_addr		= {sign = "u",      size = 4,       offset = 0x00A8},
				oshi_addr		= {sign = "u",      size = 4,       offset = 0x00AC},
				attack_addr		= {sign = "u",      size = 4,       offset = 0x00B0},
				body_id			= {sign = "u",      size = 1,       offset = 0x00DC},
				head_id			= {sign = "u",      size = 1,       offset = 0x00DD},
				oshi_id			= {sign = "u",      size = 1,       offset = 0x00DE},
				foot_id			= {sign = "u",      size = 1,       offset = 0x00DF},
			},
			element_detail = {
			}
		},
		cheat = {
		}
	},
	{
		version   = {"AGB-AZUJ-JPN"},
		draw_data1 = false,
		menu_enabled = false,
		delay_adjust = function() return (0x01) end,
		scr_shift_x = function() return (0x18) end,
		scr_shift_y = function() if (G_emulator == "mame" or G_emulator == "mame_old") or (G_emulator == "bizhawk") then return (0x37) elseif (G_emulator == "vbarr") then return (0x0C) end end,
		scale_x = 1/2,
		scale_y = 2/3,
		proj_alive = 0x02000000,
		addr_shift = (0x00000000),
		conf      = {p_num = 4, proj_num  = 24},
		isgame = function(s00, s01, s02, s03) return ((s00 == 0x01) and (s01 == 0x02) and (s02 == 0x03)) end,
		hb = {
			{hb = "oshi",		hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x03 },
			{hb = "foot",		hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x02 },
			{hb = "body",		hbsize = 8,  addr_key = "body_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x01 },
			{hb = "head",		hbsize = 8,  addr_key = "head_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x00 },
			{hb = "attack",		hbsize = 32, addr_key = "attack_addr", addr_alt_key = "attack_alt", id_key = nil, id_offset = 0x01 },
		},
		hbproj = {
			{hb = "projoshi",	hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x03 },
			{hb = "projfoot",	hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x02 },
			{hb = "projbody",	hbsize = 8,  addr_key = "body_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x01 },
			{hb = "projhead",	hbsize = 8,  addr_key = "head_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x00 },
			{hb = "projattack",	hbsize = 32, addr_key = "attack_addr", addr_alt_key = "attack_alt", id_key = nil, id_offset = 0x01 },
		},
		hbthrow = {
		},
		hbwire = {
		},
		throw_bp = {
			["AGB-AZUJ-JPN"] = {throw = {}, wire = {}},
		},
		cmm = {
			base  = 0x020042E0,
			element = {
				status00    = {sign = "u",      size = 2,       offset =  0x0000},
				status01    = {sign = "u",      size = 2,       offset =  0x0002},
				status02    = {sign = "u",      size = 2,       offset =  0x0004},
				cam_x       = {sign = "s",      size = 2,       offset = -0x049E},
				cam_y       = {sign = "s",      size = 2,       offset = -0x049A},
			}
		},
		obj = {
			p_base    = {
				0x02000200, 0x020007B0, 0x020043C0, 0x020073F0
			},
			proj_base = {
				0x0200B200, 0x0200B358, 0x0200B4B0, 0x0200B608, 0x0200B760, 0x0200B8B8,
				0x0200BA10, 0x0200BB68, 0x0200BCC0, 0x0200BE18, 0x0200BF70, 0x0200C0C8,
				0x020012D0, 0x02001428, 0x02001580, 0x020016D8, 0x02001830, 0x02001988,
				0x02001AE0, 0x02001C38, 0x02001D90, 0x02001EE8, 0x02002040, 0x02002198,
			},
			element = {
				exist			= {sign = "u",      size = 1,       offset = 0x0000},
				draw			= {sign = "u",      size = 1,       offset = 0x0001},
				motion00		= {sign = "u",      size = 1,       offset = 0x0004},
				motion01		= {sign = "u",      size = 1,       offset = 0x0005},
				motion02		= {sign = "u",      size = 1,       offset = 0x0006},
				motion03		= {sign = "u",      size = 1,       offset = 0x0007},
				direction		= {sign = "u",      size = 1,       offset = 0x000B},
				x				= {sign = "s",      size = 2,       offset = 0x0012},
				x_sub			= {sign = "s",      size = 2,       offset = 0x0014},
				y				= {sign = "s",      size = 2,       offset = 0x0016},
				y_sub			= {sign = "s",      size = 2,       offset = 0x0018},
				form_set		= {sign = "u",      size = 4,       offset = 0x00C4},
				head_addr		= {sign = "u",      size = 4,       offset = 0x00C8},
				body_addr		= {sign = "u",      size = 4,       offset = 0x00CC},
				foot_addr		= {sign = "u",      size = 4,       offset = 0x00D0},
				oshi_addr		= {sign = "u",      size = 4,       offset = 0x00D4},
				attack_addr		= {sign = "u",      size = 4,       offset = 0x00D8},
				attack_alt		= {sign = "u",      size = 4,       offset = 0x0120},
			},
			element_detail = {
			}
		},
		cheat = {
		}
	},
	{
		version   = {"SLPM 65047"},
		draw_data1 = false,
		menu_enabled = false,
		delay_adjust = function() return (0x02) end,
		scr_shift_x = function() return (0x13E) end,
		scr_shift_y = function() return (-0x212) end,
		scale_x = 1.63,
		scale_y = 2,
		proj_alive = 0x01000000,
		addr_shift = (0x00000000),
		conf      = {p_num = 2, proj_num  = 32},
		isgame = function(s00, s01, s02, s03) return ((s00 == 0x02) and (s01 == 0x01) and (s02 == 0x02) and (s03 == 0x02)) end,
		hb = {
			{hb = "oshi",		hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x03 },
			{hb = "foot",		hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x02 },
			{hb = "body",		hbsize = 8,  addr_key = "body_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x01 },
			{hb = "head",		hbsize = 8,  addr_key = "head_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x00 },
			{hb = "attack",		hbsize = 32, addr_key = "attack_addr", addr_alt_key = "anim_ptr",   id_key = nil, id_offset = 0x09 },
		},
		hbproj = {
			{hb = "projoshi",	hbsize = 8,  addr_key = "oshi_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x03 },
			{hb = "projfoot",	hbsize = 8,  addr_key = "foot_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x02 },
			{hb = "projbody",	hbsize = 8,  addr_key = "body_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x01 },
			{hb = "projhead",	hbsize = 8,  addr_key = "head_addr",   addr_alt_key = "form_set",   id_key = nil, id_offset = 0x00 },
			{hb = "projattack",	hbsize = 32, addr_key = "attack_addr", addr_alt_key = "anim_ptr",   id_key = nil, id_offset = 0x09 },
		},
		hbthrow = {
		},
		hbwire = {
		},
		throw_bp = {
			["SLPM 65047"] = {throw = {}, wire = {}},
		},
		cmm = {
			base  = 0x204A0F30,
			element = {
				status00    = {sign = "u",      size = 1,       offset =  0x0000},
				status01    = {sign = "u",      size = 1,       offset =  0x0001},
				status02    = {sign = "u",      size = 1,       offset =  0x0002},
				status03    = {sign = "u",      size = 1,       offset =  0x0003},
				cam_x       = {sign = "s",      size = 2,       offset = -0x03CA},
				cam_y       = {sign = "s",      size = 2,       offset = -0x03C6},
			}
		},
		obj = {
			p_base    = {
			--  1P          2P
				0x20485340, 0x20485910
			},
			proj_base = {
				0x20485EE0, 0x20486060, 0x204861E0, 0x20486360, 0x204864E0, 0x20486660, 0x204867E0, 0x20486960,
				0x20486AE0, 0x20486C60, 0x20486DE0, 0x20486F60, 0x204870E0, 0x20487260, 0x204873E0, 0x20487560,
				0x204876E0, 0x20487860, 0x204879E0, 0x20487B60, 0x20487CE0, 0x20487E60, 0x20487FE0, 0x20488160,
				0x204882E0, 0x20488460, 0x204885E0, 0x20488760, 0x204888E0, 0x20488A60, 0x20488BE0, 0x20488D60
			},
			element = {
				exist			= {sign = "u",      size = 1,       offset = 0x0000},
				draw			= {sign = "u",      size = 1,       offset = 0x0002},
				motion00		= {sign = "u",      size = 1,       offset = 0x0004},
				motion01		= {sign = "u",      size = 1,       offset = 0x0005},
				motion02		= {sign = "u",      size = 1,       offset = 0x0006},
				motion03		= {sign = "u",      size = 1,       offset = 0x0007},
				direction		= {sign = "u",      size = 1,       offset = 0x00A4},
				x				= {sign = "s",      size = 2,       offset = 0x003E},
				x_sub			= {sign = "s",      size = 2,       offset = 0x003C},
				y				= {sign = "s",      size = 2,       offset = 0x0042},
				y_sub			= {sign = "s",      size = 2,       offset = 0x0040},
				anim_ptr		= {sign = "u",      size = 4,       offset = 0x00B8},
				head_addr		= {sign = "u",      size = 4,       offset = 0x0160},
				body_addr		= {sign = "u",      size = 4,       offset = 0x0164},
				foot_addr		= {sign = "u",      size = 4,       offset = 0x0168},
				oshi_addr		= {sign = "u",      size = 4,       offset = 0x016C},
				attack_addr		= {sign = "u",      size = 4,       offset = 0x0170},
				form_set		= {sign = "u",      size = 4,       offset = 0x0178},
			},
			element_detail = {
			}
		},
		cheat = {
		}
	}
}
