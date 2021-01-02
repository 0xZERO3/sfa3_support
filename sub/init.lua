G_emulator = nil
G_version = nil
G_cpu = nil
G_mem = nil
G_scr = nil
G_delay = nil
G_frame = {}
m = nil
FG = (-0x006F0000)

if emu.app_name then
	G_emulator = "mame"
	G_cpu = manager:machine().devices[":maincpu"]
	G_mem = G_cpu.spaces["program"]
	G_dbg = manager:machine():debugger()
	G_scr = manager:machine().screens[":screen"]
	G_inp = manager:machine():input()
	-- psx
	if G_scr == nil then
		G_scr = manager:machine().screens[":gpu:screen"]
	end
	-- gba
	if G_scr == nil then
		G_scr = manager:machine().screens[":lcd:screen"]
	end
elseif mame then
	G_emulator = "mamerr"
elseif fba then
	if memory.getregister("m68000.pc") ~= nil then
		G_emulator = "fbarr"
	else
		G_emulator = "fcfbneo"
	end
elseif psxjin then
	G_emulator = "psxjin"
elseif vba then
	G_emulator = "vbarr"
elseif tastudio then
	G_emulator = "bizhawk"
else
	G_emulator = "pcsx2rrlua"
end
