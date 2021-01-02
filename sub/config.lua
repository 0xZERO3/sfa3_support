-- user config


-- const
c = {
	delay = {
		["mame"] = 0,
		["mamerr"] = 0,
		["bizhawk"] = 0,
		["fbarr"] = 1,
		["fcfbneo"] = 0,
		["vbarr"] = 1,
		["psxjin"] = 1,
		["pcsx2rrlua"] = 5
	},
	text_shadow = false,
	axis_len = 4,
	debug_coop = false,
	clear_id = true,
	lua_debug = false,
	input_line = 5,
	color = {
		axis		= {color = 0xEE6600,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- orange
		oshi		= {color = 0x2266FF,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- blue
		head		= {color = 0xFFFF44,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- yellow
		body		= {color = 0x77CC77,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- green
		foot		= {color = 0xAA44DD,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- paple
		attack		= {color = 0xFF3333,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- red
		projoshi	= {color = 0x2266FF,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- light blue
		projhead	= {color = 0x00FFFF,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- 
		projbody	= {color = 0x77CC77,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- green
		projfoot	= {color = 0xAA44DD,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- paple
		projattack	= {color = 0xFF66FF,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- pink
		throw		= {color = 0xFFFFFF,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- white
		wire		= {color = 0xFF4444,	fill = 0x00,	outline = 0xFF,		alpha = nil},	-- wine red
		menu		= {color = 0x555555,	fill = 0xD0,	outline = 0xD0,		alpha = nil},	-- gray
		grid		= {color = 0xFFFFFF,	fill = 0x20,	outline = nil,		alpha = 0x20},	-- white
		text		= {color = 0xFFFFFF,	fill = 0x00,	outline = nil,		alpha = 0xFF},	-- white
	}
}

-- version
v = {
	{romname = {"sfz3jr2"},                                    console = "CPS2",  version = {"980629"}						},
	{romname = {"sfz3jr1"},                                    console = "CPS2",  version = {"980727"}						},
	{romname = {"sfa3", "sfa3u", "sfz3j"},                     console = "CPS2",  version = {"980904"}						},
	{romname = {"psj", "PSX"},                                 console = "PSX",   version = {"SLPS 01777", "SLPM 86877"}	},
	{romname = {"saturnjp", "SAT"},                            console = "SS",    version = {"T-1246G", "T-1247G"}			},
	{romname = {"gba", "GBA"},                                 console = "GBA",   version = {"AGB-AZUJ-JPN"}				},
	{romname = {"ps2", "PS2"},                                 console = "PS2",   version = {"SLPM 66409", "SLPM 66854"}	},
--	{romname = {"ps2", "PS2"},                                 console = "PS2",   version = {"SLPM 65047"}					},		-- cvs2
}

MENUTRIGGER = {"ENTER",	"SHIFT"}

KEYBOARD = {
	ENTER     = {mame = "ENTER",		mamerr = "enter",		fbarr = "enter",	fcfbneo = "enter",		prev = false,	toggle = false},
	SHIFT     = {mame = "RSHIFT",		mamerr = "shift",		fbarr = "shift",	fcfbneo = "shift",		prev = false,	toggle = false},
	UP        = {mame = "UP",			mamerr = "up",			fbarr = "up",		fcfbneo = "up",			prev = false,	toggle = false},
	DOWN      = {mame = "DOWN",			mamerr = "down",		fbarr = "down",		fcfbneo = "down",		prev = false,	toggle = false},
	LEFT      = {mame = "LEFT",			mamerr = "left",		fbarr = "left",		fcfbneo = "left",		prev = false,	toggle = false},
	RIGHT     = {mame = "RIGHT",		mamerr = "right",		fbarr = "right",	fcfbneo = "right",		prev = false,	toggle = false},
}

MENU = {
	v = 1,
	{kind = "STATIC CHEAT",			status = false,		h = 1,		desc = {"OFF",		"ON"}														},
	{kind = "INPUT DISPLAY",		status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "RESTART",				status = false,		h = 1,		desc = {"OFF",		"RESTART"}													},
	{kind = "CHANGE CHAR",			status = false,		h = 1,		desc = {"OFF",		"CHANGE CHAR"}												},
	{kind = "TIMER",				status = false,		h = 1,		desc = {"OFF",		"STOP"}														},
	{kind = "SPEED",				status = false,		h = 1,		desc = {"OFF",		"NORMAL",	"TURBO1",	"TURBO2",	"RAPID"}				},
	{kind = "1P EXISTENCE",			status = false,		h = 1,		desc = {"OFF",		"NOT DRAW",	"NONE"}											},
	{kind = "2P EXISTENCE",			status = false,		h = 1,		desc = {"OFF",		"NOT DRAW",	"NONE"}											},
	{kind = "1P VITAL",				status = false,		h = 1,		desc = {"OFF",		"REFILL",	"MAX"}											},
	{kind = "2P VITAL",				status = false,		h = 1,		desc = {"OFF",		"REFILL",	"MAX"}											},
	{kind = "1P GAUGE",				status = false,		h = 1,		desc = {"OFF",		"0",		"1/3",		"1/2",		"2/3",	"MAX"}			},
	{kind = "2P GAUGE",				status = false,		h = 1,		desc = {"OFF",		"0",		"1/3",		"1/2",		"2/3",	"MAX"}			},
	{kind = "1P STUN",				status = false,		h = 1,		desc = {"OFF",		"ALWAYS",	"NONE"}											},
	{kind = "2P STUN",				status = false,		h = 1,		desc = {"OFF",		"ALWAYS",	"NONE"}											},
	{kind = "HITBOX AXIS",			status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX HEAD",			status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX BODY",			status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX FOOT",			status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX OSHI",			status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX ATTACK",		status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX THROW",			status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX WIRE",			status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX PROJECTILE",	status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "HITBOX DATA1",			status = false,		h = 1,		desc = {"OFF",		"STANDARD",	"ADVANCED"}										},
	{kind = "HITBOX DATA2",			status = false,		h = 1,		desc = {"OFF",		"PLAYER",	"PROJ ATTACK",	"PROJ HEAD",	"PROJ OSHI",}	},
	{kind = "ANIMATION DATA",		status = false,		h = 1,		desc = {"OFF",		"ON"}														},
	{kind = "VARIOUS DATA1",		status = false,		h = 2,		desc = {"OFF",		"ON"}														},
	{kind = "GRID",					status = false,		h = 1,		desc = {"OFF",		"TYPE1",	"TYPE2",	"TYPE3"}							},
	{kind = "HUD",					status = false,		h = 1,		desc = {"NORMAL",	"DISABLE",	"RESTORE"}										},
	{kind = "BACK GROUND",			status = false,		h = 1,		desc = {"NORMAL",	"DISABLE",	"RESTORE"}										},
-- input,recoard
}

-- black screen
BLSCR = {
	["980629"] = {
		{cmd = "maincpu.pw@", addr = 0xFFD600, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFD800, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFDA00, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFDC00, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFF1C0, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pb@", addr = 0xFF8033, bg = true,  bglayer = true,  size = 1, data = 0},
		{cmd = "maincpu.ow@", addr = 0x009528, bg = true,  bglayer = false, size = 2, data = 0x4E71},
		{cmd = "maincpu.od@", addr = 0x00952A, bg = true,  bglayer = false, size = 4, data = 0x4E714E71}
	},
	["980727"] = {
		{cmd = "maincpu.pw@", addr = 0xFFD600, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFD800, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFDA00, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFDC00, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFF1C0, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pb@", addr = 0xFF8033, bg = true,  bglayer = true,  size = 1, data = 0},
		{cmd = "maincpu.ow@", addr = 0x00952E, bg = true,  bglayer = false, size = 2, data = 0x4E71},
		{cmd = "maincpu.od@", addr = 0x009530, bg = true,  bglayer = false, size = 4, data = 0x4E714E71}
	},
	["980904"] = {
		{cmd = "maincpu.pw@", addr = 0xFFD600, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFD800, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFDA00, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFDC00, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pw@", addr = 0xFFF1C0, bg = false, bglayer = false, size = 2, data = 0},
		{cmd = "maincpu.pb@", addr = 0xFF8033, bg = true,  bglayer = true,  size = 1, data = 0},
		{cmd = "maincpu.ow@", addr = 0x00958C, bg = true,  bglayer = false, size = 2, data = 0x4E71},
		{cmd = "maincpu.od@", addr = 0x00958E, bg = true,  bglayer = false, size = 4, data = 0x4E714E71}
	}
}

HITBOX = {
	{desc = "coordinate_x",			short = "COX",	veryshort = "CX",	disp = "%3d",	size = 2,	standard = false,	advanced = true,	offset = 0x00},
	{desc = "",						short = "",		veryshort = "",		disp = nil,		size = 0,	standard = false,	advanced = false,	offset = 0x01},
	{desc = "coordinate_y",			short = "COY",	veryshort = "CY",	disp = "%3d",	size = 2,	standard = false,	advanced = true,	offset = 0x02},
	{desc = "",						short = "",		veryshort = "",		disp = nil,		size = 0,	standard = false,	advanced = false,	offset = 0x03},
	{desc = "radius_x",				short = "RAX",	veryshort = "RX",	disp = "%3d",	size = 2,	standard = false,	advanced = true,	offset = 0x04},
	{desc = "",						short = "",		veryshort = "",		disp = nil,		size = 0,	standard = false,	advanced = false,	offset = 0x05},
	{desc = "radius_y",				short = "RAY",	veryshort = "RY",	disp = "%3d",	size = 2,	standard = false,	advanced = true,	offset = 0x06},
	{desc = "",						short = "",		veryshort = "",		disp = nil,		size = 0,	standard = false,	advanced = false,	offset = 0x07},
	{desc = "Damage",				short = "POW",	veryshort = "PO",	disp = "%3d",	size = 1,	standard = true,	advanced = true,	offset = 0x08},
	{desc = "HitBack",				short = "HBK",	veryshort = "HB",	disp = "%3d",	size = 1,	standard = true,	advanced = true,	offset = 0x09},
	{desc = "Vector",				short = "VEC",	veryshort = "VE",	disp = "%3d",	size = 1,	standard = true,	advanced = true,	offset = 0x0A},
	{desc = "Direction",			short = "DIR",	veryshort = "DI",	disp = "%3d",	size = 1,	standard = true,	advanced = true,	offset = 0x0B},
	{desc = "Stun",					short = "STN",	veryshort = "ST",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x0C},
	{desc = "Motion",				short = "MTN",	veryshort = "MT",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x0D},
	{desc = "Hit",					short = "HIT",	veryshort = "HI",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x0E},
	{desc = "Sound",				short = "SND",	veryshort = "SN",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x0F},
	{desc = "HitStop",				short = "HST",	veryshort = "HS",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x10},
	{desc = "Gauge",				short = "GAU",	veryshort = "GA",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x11},
	{desc = "BlockDamage",			short = "BDA",	veryshort = "BD",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x12},
	{desc = "Unknown0",				short = "??0",	veryshort = "?0",	disp = "%02X",	size = 1,	standard = false,	advanced = true,	offset = 0x13},
	{desc = "Effect",				short = "EFE",	veryshort = "EF",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x14},
	{desc = "Block",				short = "BLK",	veryshort = "BL",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x15},
	{desc = "Icon",					short = "ICO",	veryshort = "IC",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x16},
	{desc = "Finish",				short = "FNS",	veryshort = "FN",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x17},
	{desc = "Adjust",				short = "ADJ",	veryshort = "AD",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x18},
	{desc = "Deactivate",			short = "DEA",	veryshort = "DE",	disp = "%02X",	size = 1,	standard = false,	advanced = true,	offset = 0x19},
	{desc = "Unknown1",				short = "??1",	veryshort = "?1",	disp = "%02X",	size = 1,	standard = false,	advanced = true,	offset = 0x1A},
	{desc = "Juggle",				short = "UKM",	veryshort = "UK",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x1B},
	{desc = "DownTime",				short = "DOT",	veryshort = "DO",	disp = "%3d",	size = 1,	standard = false,	advanced = true,	offset = 0x1C},
	{desc = "Unknown2",				short = "??2",	veryshort = "?2",	disp = "%02X",	size = 1,	standard = false,	advanced = true,	offset = 0x1D},
	{desc = "Reserve0",				short = "---",	veryshort = "--",	disp = "%02X",	size = 1,	standard = false,	advanced = true,	offset = 0x1E},
	{desc = "Reserve1",				short = "---",	veryshort = "--",	disp = "%02X",	size = 1,	standard = false,	advanced = true,	offset = 0x1F}
}

ANIMATION = {
	{desc = "Frame Count      :",	disp = "%02X",	size = 1,	offset = 0x00},
	{desc = "Flag Data        :",	disp = "%02X",	size = 1,	offset = 0x01},
	{desc = "Unknown          :",	disp = "%02X",	size = 1,	offset = 0x02},
	{desc = "Unknown          :",	disp = "%02X",	size = 1,	offset = 0x03},
	{desc = "Graphic pointer  :",	disp = "%08X",	size = 4,	offset = 0x04},
	{desc = "Box Setup        :",	disp = "%02X",	size = 1,	offset = 0x08},
	{desc = "Attack Box       :",	disp = "%02X",	size = 1,	offset = 0x09},
	{desc = "Sound effect     :",	disp = "%02X",	size = 1,	offset = 0x0A},
	{desc = "Allow Underground:",	disp = "%02X",	size = 1,	offset = 0x0B},
	{desc = "Unknown          :",	disp = "%02X",	size = 1,	offset = 0x0C},
	{desc = "Block properties :",	disp = "%02X",	size = 1,	offset = 0x0D},
	{desc = "Shadow           :",	disp = "%02X",	size = 1,	offset = 0x0E},
	{desc = "Unknown          :",	disp = "%02X",	size = 1,	offset = 0x0F},
	{desc = "Effect           :",	disp = "%02X",	size = 1,	offset = 0x10},
	{desc = "Unknown          :",	disp = "%02X",	size = 1,	offset = 0x11},
	{desc = "Unknown          :",	disp = "%02X",	size = 1,	offset = 0x12},
	{desc = "Unknown          :",	disp = "%02X",	size = 1,	offset = 0x13},
}

INPUT = {
	{kind = "button",		name = "LP",		display = "P",		color = 0x0000FF,	value = 0x01},
	{kind = "button",		name = "MP",		display = "P",		color = 0xFFFF00,	value = 0x02},
	{kind = "button",		name = "HP",		display = "P",		color = 0xFF0000,	value = 0x04},
	{kind = "button",		name = "LK",		display = "K",		color = 0x0000FF,	value = 0x10},
	{kind = "button",		name = "MK",		display = "K",		color = 0xFFFF00,	value = 0x20},
	{kind = "button",		name = "HK",		display = "K",		color = 0xFF0000,	value = 0x40},
	{kind = "lever",		name = "RIGHT",		display = ">",		color = 0xFFFFFF,	value = 0x01},
	{kind = "lever",		name = "LEFT",		display = "<",		color = 0xFFFFFF,	value = 0x02},
	{kind = "lever",		name = "DOWN",		display = "v",		color = 0xFFFFFF,	value = 0x04},
	{kind = "lever",		name = "UP",		display = "^",		color = 0xFFFFFF,	value = 0x08},
	{kind = "1pstart_coin",	name = "1P START",	display = "S",		color = 0xFFFFFF,	value = 0x01},
	{kind = "2pstart_coin",	name = "2P START",	display = "S",		color = 0xFFFFFF,	value = 0x02},
	{kind = "1pstart_coin",	name = "1P COIN",	display = "C",		color = 0xFFFFFF,	value = 0x10},
	{kind = "2pstart_coin",	name = "2P COIN",	display = "C",		color = 0xFFFFFF,	value = 0x20},
	{kind = "service",		name = "TEST",		display = "T",		color = 0xFFFFFF,	value = 0x02},
	{kind = "service",		name = "SERVICE",	display = "C",		color = 0xFFFFFF,	value = 0x04},
}

RAM = {
	draw_detail = nil,
	hitbox_data1 = "",
	hitbox_data2 = "",
	hud = nil,
	blackscr = nil,
	version = nil,
	draw_detail = nil,
	throw_bp = nil,
	draw_hb_axis = true,
	draw_hb_oshi = true,
	draw_hb_foot = true,
	draw_hb_body = true,
	draw_hb_head = true,
	draw_hb_attack = true,
	draw_hb_proj = true,
	draw_hb_throw = true,
	draw_hb_wire = true,
	animation = false,
	draw_p1 = true,
	draw_p2 = true,
	exist_p1 = true,
	exist_p2 = true,
	menu_prev = false,
	menu_toggle = false,
	cheat = false,
	cheatchanged = false,
	draw_input = true,
	input_buf = {},
	throw_temp = {},
}
