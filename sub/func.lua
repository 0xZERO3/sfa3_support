if tonumber(string.sub(_VERSION, 5)) >= 5.3 then
	dofile("./sub/wrapper.lua")
else
	dofile("./sub/wrapper_lesslua53.lua")
end

get_w_table_subscript = function()
	for i = 1, #G_wrapper_table do
		if G_emulator == G_wrapper_table[i].emulator then
			return i
		end
	end
	return nil
end

w_gui_text = function(v1, v2, msg, color, alpha) return G_wrapper_table[get_w_table_subscript()].w_gui_text(v1, v2, msg, color, alpha) end

w_ru8 = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_ru8(v1, v2) end
w_rs8 = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_rs8(v1, v2) end
w_ru16 = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_ru16(v1, v2) end
w_rs16 = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_rs16(v1, v2) end
w_ru32 = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_ru32(v1, v2) end
w_rs32 = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_rs32(v1, v2) end

w_wu8 = function(v1, v2, v3) return G_wrapper_table[get_w_table_subscript()].w_wu8(v1, v2, v3) end
w_wu16 = function(v1, v2, v3) return G_wrapper_table[get_w_table_subscript()].w_wu16(v1, v2, v3) end
w_wu32 = function(v1, v2, v3) return G_wrapper_table[get_w_table_subscript()].w_wu32(v1, v2, v3) end

w_and = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_and(v1, v2) end
w_lshift = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_lshift(v1, v2) end
w_rshift = function(v1, v2) return G_wrapper_table[get_w_table_subscript()].w_rshift(v1, v2) end

w_gui_drawline = function(v1, v2, v3, v4, color, alpha) return G_wrapper_table[get_w_table_subscript()].w_gui_drawline(v1, v2, v3, v4, color, alpha) end
w_gui_drawbox = function(v1, v2, v3, v4, color, fill_a, outline_a) return G_wrapper_table[get_w_table_subscript()].w_gui_drawbox(v1, v2, v3, v4, color, fill_a, outline_a) end

w_scr_width = function () return G_wrapper_table[get_w_table_subscript()].w_scr_width() end
w_scr_height = function () return G_wrapper_table[get_w_table_subscript()].w_scr_height() end

w_input_pressed = function (v1) return G_wrapper_table[get_w_table_subscript()].w_input_pressed(v1) end

w_emu_framecount = function() return G_wrapper_table[get_w_table_subscript()].w_emu_framecount() end
w_emu_pause = function () return G_wrapper_table[get_w_table_subscript()].w_emu_pause() end
w_emu_paused = function () return G_wrapper_table[get_w_table_subscript()].w_emu_paused() end
w_read_pc = function () return G_wrapper_table[get_w_table_subscript()].w_read_pc() end
w_unique = function () return G_wrapper_table[get_w_table_subscript()].w_unique() end

G_cycle_table = {
	{emulator = "mame",				cycle_type = "register",		get_data_func = function() emu.register_frame(get_data) return end,			draw_func = function() emu.register_frame_done(draw) return end,	},
	{emulator = "mame_old",			cycle_type = "register",		get_data_func = function() emu.register_frame(get_data) return end,			draw_func = function() emu.register_frame_done(draw) return end,	},
	{emulator = "mamerr",			cycle_type = "register",		get_data_func = function() emu.registerafter(get_data)  return end,			draw_func = function() gui.register(draw)            return end,	},
	{emulator = "fbarr",			cycle_type = "register",		get_data_func = function() emu.registerafter(get_data)  return end,			draw_func = function() gui.register(draw)            return end,	},
	{emulator = "fcfbneo",			cycle_type = "register",		get_data_func = function() emu.registerafter(get_data)  return end,			draw_func = function() gui.register(draw)            return end,	},
	{emulator = "psxjin",			cycle_type = "register",		get_data_func = function() emu.registerafter(get_data)  return end,			draw_func = function() gui.register(draw)            return end,	},
	{emulator = "vbarr",			cycle_type = "register",		get_data_func = function() emu.registerafter(get_data)  return end,			draw_func = function() gui.register(draw)            return end,	},
	{emulator = "bizhawk",			cycle_type = "register",		get_data_func = function() event.onframeend(get_data)   return end,			draw_func = function() event.onframestart(draw)      return end,	},
	{emulator = "pcsx2rrlua",		cycle_type = "register",		get_data_func = function() emu.registerbefore(get_data) return end,			draw_func = function() emu.registerafter(draw)       return end,	},
}

function r(f, base, element, id, kind)
	if element[kind].sign == "u" then
		if element[kind].size == 1 then
			f[id .. kind] = w_ru8(base + element[kind].offset, nil)
		elseif element[kind].size == 2 then
			f[id .. kind] = w_ru16(base + element[kind].offset, nil)
		elseif element[kind].size == 4 then
			f[id .. kind] = w_ru32(base + element[kind].offset, nil)
		end
	elseif element[kind].sign == "s" then
		if element[kind].size == 1 then
			f[id .. kind] = w_rs8(base + element[kind].offset, nil)
		elseif element[kind].size == 2 then
			f[id .. kind] = w_rs16(base + element[kind].offset, nil)
		elseif element[kind].size == 4 then
			f[id .. kind] = w_rs32(base + element[kind].offset, nil)
		end
	end
end

function guitext(v1, v2, msg, color, alpha)
	if color == nil then color = 0xFFFFFF end
	if alpha == nil then alpha = 0xFF end
	
	if c.text_shadow == true then
		w_gui_text(v1, v2 + 1, msg, 0x000000, 0xFF)
	end
	w_gui_text(v1, v2, msg, color,alpha)
end

function guiline(v1, v2, v3, v4, color, alpha)
	if color == nil then color = 0xFFFFFF end
	if alpha == nil then alpha = 0xFF end
	
	w_gui_drawline(v1, v2, v3, v4, color, alpha)
end

function guibox(v1, v2, v3, v4, color, fill_a, outline_a)
	if color == nil then color = 0xFFFFFF end
	if fill_a == nil then fill_a = 0xFF end
	if outline_a == nil then outline_a = 0xFF end
	
	w_gui_drawbox(v1, v2, v3, v4, color, fill_a, outline_a)
end

-- for saturn(bad code)
function byteswap(value, order)
	local tmp = 0
	
	if order == 4 then
		tmp = tmp +
			  w_rshift(w_and(value, 0x00FF0000), 16) +
			  w_rshift(w_and(value, 0xFF000000), 16) +
			  w_lshift(w_and(value, 0x000000FF), 16) +
			  w_lshift(w_and(value, 0x0000FF00), 16)
	elseif order == 2 then
		tmp = value
	else
		tmp = value
	end
	return tmp
end

-- for ps2(bad code)
function ToSignedByForce(value, order)
	local tmp = value
	if order == 4 then
		if w_and(value, 0x80000000) > 0 then
			tmp = -4294967296													-- equal 0xFFFFFFFF00000000 (cheap code for add sign)
			tmp = tmp +
				  w_and(value, 0xFF000000) +
				  w_and(value, 0x00FF0000) +
				  w_and(value, 0x0000FF00) +
				  w_and(value, 0x000000FF)
--			print(string.format("value=0x%X, tmp=0x%X" , value, tmp))
		end
	elseif order == 2 then
		if w_and(value, 0x00008000) > 0 then
			tmp = -65536														-- equal 0xFFFFFFFFFFFF0000 (cheap code for add sign)
			tmp = tmp +
				  w_and(value, 0xFF00) +
				  w_and(value, 0x00FF)
--			print(string.format("value=0x%X, tmp=0x%X" , value, tmp))
		end
	end
	return tmp
end