-- sfa3_support v1.0
dofile("./sub/deepcopy.lua")
dofile("./sub/config.lua")
dofile("./sub/func.lua")
dofile("./sub/init.lua")
dofile("./sub/program.lua")
dofile("./sub/drawconf.lua")

function init_game()
	local tmp
	for _, i in ipairs(v) do
		for _, j in ipairs(i.romname) do
			if w_unique() == j then
				for _, k in ipairs(program) do
					for _, l in ipairs(k.version) do
						if i.version[1] == l then
							tmp = l
							m = deepcopy(k)
							break
						end
					end
				end
			end
		end
	end
	G_delay = c.delay[G_emulator] + m.delay_adjust()
	
	RAM.version = tmp
	RAM.draw_data1 = m.draw_data1
	RAM.menu_enabled = m.menu_enabled
	RAM.throw_bp = deepcopy(m.throw_bp[RAM.version])
end

function get_throw_id(kind)
	local base = memory.getregister("m68000.a6")

	for i = 1, #m.obj.p_base do
		if m.obj.p_base[i] == base then
			RAM.throw_temp[i] = w_and(memory.getregister("m68000.d0"), 0xFF)
		end
	end
end

function register_bp()
	if G_emulator == "mame" or G_emulator == "mame_old" or G_emulator == "mamerr" then
		if G_dbg ~= nil then
			if c.debug_coop == true then
				for i = 1, m.conf.p_num do
					for j = 1, #RAM.throw_bp.throw do
						m.throw_bp_mame_coop(i, j)
					end
				end
			else
				for i = 1, #RAM.throw_bp.throw do
					m.throw_bp_mame_nocoop(i)
				end
			end
		else
			print("Throw HITBOX:Execute below command in the debug window")
			for i = 1, #RAM.throw_bp.throw do
				m.throw_bp_mame_old(i)
			end
		end
	elseif G_emulator == "fbarr" or G_emulator == "fcfbneo" then
		for i = 1, m.conf.p_num do
			for j = 1, #RAM.throw_bp.throw do
				memory.registerexec(RAM.throw_bp.throw[j], get_throw_id)
			end
		end
	else
	end
end

function register_func()
	for i = 1, #G_cycle_table do
		if G_emulator == G_cycle_table[i].emulator then
			G_cycle_table[i].get_data_func()
			G_cycle_table[i].draw_func()
		end
	end
end

function get_hitbox_data(f, id, hb, throw_id)
	local addr
	local ident
	local domain
	local coordinate_x
	local coordinate_y
	local radius_x
	local radius_y
	local center_x
	local center_y
	local reverse
	for i = 1, #hb do
		if (f[id .. hb[i].addr_key] ~= nil) and (f[id .. hb[i].addr_key] ~= 0) then
			-- for saturn
			if w_unique() == "SAT" then
				domain = "Work Ram Low"
			else
				domain = nil
			end
			if throw_id ~= nil then
				ident = throw_id
			else
				if hb[i].hb == "wire" then
					ident = w_rshift(f[id .. hb[i].id_key], 1) + 0x3E
				else
					if hb[i].id_key ~= nil then
						ident = f[id .. hb[i].id_key]
					else
						ident = w_ru8(f[id .. hb[i].addr_alt_key] + m.addr_shift + hb[i].id_offset, domain)
					end
				end
			end
			addr = f[id .. hb[i].addr_key] + m.addr_shift + (ident * hb[i].hbsize)
			
			coordinate_x = w_rs16(addr + 0x00, domain)
			coordinate_y = w_rs16(addr + 0x02, domain)
			radius_x  = w_rs16(addr + 0x04, domain)
			radius_y  = w_rs16(addr + 0x06, domain)
			
			if f[id .. "direction"] == 1 then
				reverse = -1
			else
				reverse = 1
			end
			
			center_x = f[id .. "pos_x"] + (coordinate_x * reverse)
			center_y = f[id .. "pos_y"] - coordinate_y
			
			if hb[i].hb == "wire" then
				center_x = center_x + f[id .. "wire_x"]
			end
			f[id .. hb[i].hb .. "left"]   = center_x - radius_x
			f[id .. hb[i].hb .. "top"]    = center_y - radius_y
			f[id .. hb[i].hb .. "right"]  = center_x + radius_x
			f[id .. hb[i].hb .. "bottom"] = center_y + radius_y
			
			f[id .. hb[i].hb .. "addr"] = addr
			f[id .. hb[i].hb .. "center_x"] = center_x
			f[id .. hb[i].hb .. "center_y"] = center_y
			f[id .. hb[i].hb .. "boxdetail0"] = coordinate_x
			f[id .. hb[i].hb .. "boxdetail2"] = coordinate_y
			f[id .. hb[i].hb .. "boxdetail4"] = radius_x
			f[id .. hb[i].hb .. "boxdetail6"] = radius_y
			
			if hb[i].hbsize > 8 then
				for j = 9, hb[i].hbsize do
					f[id .. hb[i].hb .. "boxdetail" .. (j - 1)] = w_ru8(addr + (j - 1))
				end
			end
		end
	end
end

function get_object_data(f, base, id, proj)
	r(f, base, m.obj.element, id, "exist")
	if f[id .. "exist"] == 0x00 then return end
	
	for key,value in pairs(m.obj.element) do
		r(f, base, m.obj.element, id, key)
	end
	if proj == false then
		for key,value in pairs(m.obj.element_detail) do
			r(f, base, m.obj.element_detail, id, key)
		end
	end
	
	f[id .. "pos_x"] = f[id .. "x"] - f["cam_x"]
	f[id .. "pos_y"] = w_scr_height() - (f[id .. "y"]) + f["cam_y"]
end

function get_common(f)
	for key,value in pairs(m.cmm.element) do
		r(f, m.cmm.base, m.cmm.element, "", key)
	end
	if m.isgame(f["status00"], f["status01"], f["status02"], f["status03"]) then
		f.isfight = true
	end
end

function get_data()
	local temp, f
	-- mame callbacks even if paused
	if w_emu_paused() == true then return end
	G_frame[1] = {}
	f = G_frame[1]
	get_common(f)
	if f.isfight == true then
		for i = 1, m.conf.p_num do
			get_object_data(f, m.obj.p_base[i], "p" .. tostring(i), false)
			get_hitbox_data(f, "p" .. tostring(i), m.hb, nil)
			-- needs -debug option for mame
			if G_dbg ~= nil and c.debug_coop == true then
				-- throw
				if #RAM.throw_bp.throw > 0 then
					G_dbg:command("print temp" .. i + 1)
					temp = tonumber(G_dbg.consolelog[#G_dbg.consolelog], 16)
					if (temp ~= 0) then
						get_hitbox_data(f, "p" .. tostring(i), m.hbthrow, temp)
						G_dbg:command("temp" .. i + 1 .. "= 0")
					end
				end
			else
				-- throw
				if RAM.throw_temp[i] ~= nil then
					get_hitbox_data(f, "p" .. tostring(i), m.hbthrow, RAM.throw_temp[i])
					RAM.throw_temp[i] = nil
				else
					get_hitbox_data(f, "p" .. tostring(i), m.hbthrow, nil)
					if (c.clear_id == true) and (m.obj.element_detail.throw_id ~= nil) then
						w_wu8(m.obj.p_base[i] + m.obj.element_detail.throw_id.offset, 0x00)		-- bad code
					end
				end
			end
			-- wire
				if (f["p" .. tostring(i) .. "char_id"] == 0x0E) and
				   (f["p" .. tostring(i) .. "motion00"] == 0x02) and
				   (f["p" .. tostring(i) .. "motion01"] == 0x00) and
				   (f["p" .. tostring(i) .. "motion02"] == 0x10) and
				   (f["p" .. tostring(i) .. "motion03"] == 0x04) and
				   (f["p" .. tostring(i) .. "trick_id"] == 0x0C) and
				   (f["p" .. tostring(i) .. "wire_x"] ~= 0x00) then
					get_hitbox_data(f, "p" .. tostring(i), m.hbwire, nil)
			end
		end
		for i = 1, m.conf.proj_num do
			get_object_data(f, m.obj.proj_base[i], "proj" .. tostring(i), true)
			get_hitbox_data(f, "proj" .. tostring(i), m.hbproj, nil)
		end
	end
	for i = 1, G_delay do
		G_frame[G_delay + 1 + 1 - i] = deepcopy(G_frame[G_delay + 1 - i])
	end
end

function draw_hitbox_data1(f, id, hbdetail)
	if RAM.hitbox_data1 == "" then return end
	local LINE_LENGTH_X = 39
	local LINE_LENGTH_Y = 39
	local BOX_SHIFT_X = -92
	local BOX_SHIFT_X_ADV = -16
	local BOX_SHIFT_Y  = -8
	
	local center_x
	local center_y
	local line_end_x
	local line_end_y
	local disp_reverse_x
	local disp_reverse_y
	local dir_reverse
	local shift_x
	local line_length_x
	local line_length_y
	local detail = ""
	local tmp
	
	center_x = f[id .. hbdetail.hb .. "center_x"] + m.scr_shift_x()
	center_y = f[id .. hbdetail.hb .. "center_y"] + m.scr_shift_y()
	
	if f[id .. "direction"] == 1 then
		-- right
		dir_reverse = -1
	else
		dir_reverse = 1
	end
	
	if hbdetail.hb == "attack" or 
	   hbdetail.hb == "projattack" or 
	   hbdetail.hb == "throw" or 
	   hbdetail.hb == "wire" then
		disp_reverse_x = -1
	else
		disp_reverse_x = 1
	end
	if hbdetail.hb == "oshi" or 
	   hbdetail.hb == "projoshi" then
		disp_reverse_y = 1
		line_length_x = LINE_LENGTH_X*1/2
		line_length_y = LINE_LENGTH_Y*1/2
	else
		disp_reverse_y = -1
		line_length_x = LINE_LENGTH_X
		line_length_y = LINE_LENGTH_Y
	end
	
	if dir_reverse == -1 then
		if disp_reverse_x == -1 then
			shift_x = 0
		else
			shift_x = BOX_SHIFT_X
		end
	else
		if disp_reverse_x == -1 then
			shift_x = BOX_SHIFT_X
		else
			shift_x = 0
		end
	end
	
	line_end_x = center_x + (line_length_x * dir_reverse * disp_reverse_x)
	line_end_y = center_y + line_length_y * disp_reverse_y
	guiline(center_x, center_y, line_end_x, line_end_y, c.color[hbdetail.hb].color)
	
	if RAM.hitbox_data1 == "STANDARD" then
		tmp = "standard"
	elseif RAM.hitbox_data1 == "ADVANCED" then
		tmp = "advanced"
		if shift_x ~= 0 then
			if hbdetail.hb == "attack" or 
			   hbdetail.hb == "projattack" or 
			   hbdetail.hb == "throw" or 
			   hbdetail.hb == "wire" then
				shift_x = shift_x + BOX_SHIFT_X_ADV
			else
				shift_x = shift_x + BOX_SHIFT_X_ADV
			end
		else
		end
	end
	if hbdetail.hbsize > 8 then
		local location = ""
		local cnt = 0
		for i = 9, hbdetail.hbsize do
			if HITBOX[i][tmp] == true then
				if HITBOX[i].disp == "%3d" then
					detail = detail .. string.format("%s%3d ", HITBOX[i].short, f[id .. hbdetail.hb .. "boxdetail" .. (i - 1)])
				elseif HITBOX[i].disp == "%02X" then
					detail = detail .. string.format("%s %02X ", HITBOX[i].short, f[id .. hbdetail.hb .. "boxdetail" .. (i - 1)])
				else
				end
				cnt = cnt + 1
				if RAM.hitbox_data1 == "STANDARD" then
					if (cnt % 3) == 0 then
						detail = detail .. "\n"
					end
				end
				if RAM.hitbox_data1 == "ADVANCED" then
					if (cnt % 4) == 0 then
						detail = detail .. "\n"
					end
				end
			end
		end
		tmp = w_and(w_rshift(f[id .. hbdetail.hb .. "boxdetail" .. 0x19], 4), 0x0F)
		if tmp == 0 then
			location = "B-"
		elseif tmp == 1 then
			location = "-F"
		elseif tmp == 2 then
			location = "BF"
		end
		detail = detail .. string.format("LOC %s ", location)
		detail = detail .. string.format("PRI%3d ", w_and(f[id .. hbdetail.hb .. "boxdetail" .. 0x19], 0x0F))
	end
	if RAM.hitbox_data1 == "STANDARD" then
		guitext(line_end_x + shift_x, line_end_y, string.format("X%4d Y%4d W%4d H%4d\nL%4d T%4d R%4d B%4d\n%s",
																f[id .. hbdetail.hb .. "boxdetail0"] * dir_reverse,
																f[id .. hbdetail.hb .. "boxdetail2"],
																f[id .. hbdetail.hb .. "boxdetail4"] * 2,
																f[id .. hbdetail.hb .. "boxdetail6"] * 2,
																f[id .. hbdetail.hb .. "left"] - f[id .. "pos_x"],
																f[id .. "pos_y"] - f[id .. hbdetail.hb .. "top"],
																f[id .. hbdetail.hb .. "right"] - f[id .. "pos_x"],
																f[id .. "pos_y"] - f[id .. hbdetail.hb .. "bottom"],
																detail
																), c.color[hbdetail.hb].color)
	elseif RAM.hitbox_data1 == "ADVANCED" then
		guitext(line_end_x + shift_x, line_end_y + BOX_SHIFT_Y, string.format("0x%08X\nCX%4d CY%4d RX%4d RY%4d\n%s",
																f[id .. hbdetail.hb .. "addr"],
																f[id .. hbdetail.hb .. "boxdetail0"],
																f[id .. hbdetail.hb .. "boxdetail2"],
																f[id .. hbdetail.hb .. "boxdetail4"],
																f[id .. hbdetail.hb .. "boxdetail6"],
																detail
																), c.color[hbdetail.hb].color)
	end
end

function draw_hitbox_data2(f, id, hbdetail)
	if RAM.hitbox_data2 == "" then return end

	local BASE_X = 1
	local BASE_Y = 50
	local STEP_X = 10
	local STEP_Y = 6
	local DATA_X = 44
	local pos_x, pos_y
	local tmp
	local msg = ""
	
	guitext(BASE_X, BASE_Y - STEP_Y, "address", c.color.text.color)
	msg = ""
	for i = 1, #HITBOX do
		if HITBOX[i].size == 1 then
			msg = HITBOX[i].veryshort
			guitext(BASE_X + DATA_X + STEP_X * (i - 1), BASE_Y - STEP_Y, string.format("%s", msg), c.color.text.color)
		elseif HITBOX[i].size == 2  then
			msg = HITBOX[i].veryshort
			guitext(BASE_X + DATA_X + STEP_X * (i - 1), BASE_Y - STEP_Y, string.format("%s", msg), c.color.text.color)
		end
	end
	if RAM.hitbox_data2 == "PLAYER" then
		for i = 1, m.conf.p_num do
			if id == "p" .. tostring(i) then
				if hbdetail.hb == "attack" then
					pos_y = BASE_Y + (STEP_Y * 7) * (i - 1) + STEP_Y * 0
				elseif hbdetail.hb == "throw" then
					pos_y = BASE_Y + (STEP_Y * 7) * (i - 1) + STEP_Y * 1
				elseif hbdetail.hb == "wire" then
					pos_y = BASE_Y + (STEP_Y * 7) * (i - 1) + STEP_Y * 2
				elseif hbdetail.hb == "oshi" then
					pos_y = BASE_Y + (STEP_Y * 7) * (i - 1) + STEP_Y * 3
				elseif hbdetail.hb == "foot" then
					pos_y = BASE_Y + (STEP_Y * 7) * (i - 1) + STEP_Y * 4
				elseif hbdetail.hb == "body" then
					pos_y = BASE_Y + (STEP_Y * 7) * (i - 1) + STEP_Y * 5
				elseif hbdetail.hb == "head" then
					pos_y = BASE_Y + (STEP_Y * 7) * (i - 1) + STEP_Y * 6
				end
			end
		end
	else
		for i = 1, m.conf.proj_num do
			if id == "proj" .. tostring(i) then
				if RAM.hitbox_data2 == "PROJ ATTACK" and hbdetail.hb == "projattack" then
					pos_y = BASE_Y + STEP_Y * (i - 1)
				elseif RAM.hitbox_data2 == "PROJ OSHI" and hbdetail.hb == "projoshi" then
					pos_y = BASE_Y + STEP_Y * (i - 1)
				elseif RAM.hitbox_data2 == "PROJ HEAD" and hbdetail.hb == "projhead" then
					pos_y = BASE_Y + STEP_Y * (i - 1)
				end
			end
		end
	end
	if pos_y ~= nil then
		guitext(BASE_X         , pos_y, string.format("0x%08X", f[id .. hbdetail.hb .. "addr"]), c.color[hbdetail.hb].color)
		msg = ""
		for i = 1, hbdetail.hbsize do
			if HITBOX[i].size ==1  then
				tmp = w_and(f[id .. hbdetail.hb .. "boxdetail" .. tostring(i - 1)], 0xFF)
				msg = string.format("%02X", tmp)
				guitext(BASE_X + DATA_X + STEP_X * (i - 1), pos_y, string.format("%s", msg), c.color[hbdetail.hb].color)
			elseif HITBOX[i].size ==2  then
				tmp = w_and(f[id .. hbdetail.hb .. "boxdetail" .. tostring(i - 1)], 0xFFFF)
				msg = string.format("%04X", tmp)
				guitext(BASE_X + DATA_X + STEP_X * (i - 1), pos_y, string.format("%s", msg), c.color[hbdetail.hb].color)
			end
		end
	end
end

function draw_hitbox_detail(f, id, hb, proj)
	local pos_x, pos_y
	if (f[id .. "exist"] == nil) or (f[id .. "exist"] == 0x00) then return end
	if (proj == true) and ((f[id .. "draw"] == 0x00) or ((w_lshift(f[id .. "motion00"], 24) + w_lshift(f[id .. "motion01"], 16) + w_lshift(f[id .. "motion02"], 8) + w_lshift(f[id .. "motion03"], 0)) > m.proj_alive)) then return end
	
	pos_x = f[id .. "pos_x"]
	pos_y = f[id .. "pos_y"]
	
	for i = 1, #hb do
		if f[id .. hb[i].hb .. "left"] ~= nil then
			if ((RAM.draw_hb_oshi   == true) and (hb[i].hb == "oshi")  ) or
			   ((RAM.draw_hb_foot   == true) and (hb[i].hb == "foot")   ) or
			   ((RAM.draw_hb_body   == true) and (hb[i].hb == "body")  ) or
			   ((RAM.draw_hb_head   == true) and (hb[i].hb == "head")  ) or
			   ((RAM.draw_hb_attack == true) and (hb[i].hb == "attack")) or
			   ((RAM.draw_hb_throw  == true) and (hb[i].hb == "throw") ) or
			   ((RAM.draw_hb_wire   == true) and (hb[i].hb == "wire")  ) or
			   ((RAM.draw_hb_proj   == true) and ((hb[i].hb == "projoshi") or
			                                      (hb[i].hb == "projfoot") or
			                                      (hb[i].hb == "projbody") or
			                                      (hb[i].hb == "projhead") or
			                                      (hb[i].hb == "projattack")
			                                      )) then
				if (f[id .. hb[i].hb .. "boxdetail0"] ~= 0) or (f[id .. hb[i].hb .. "boxdetail2"] ~= 0) or (f[id .. hb[i].hb .. "boxdetail4"] ~= 0) or (f[id .. hb[i].hb .. "boxdetail6"] ~= 0) then
					guibox(
						f[id .. hb[i].hb .. "left"] * m.scale_x + m.scr_shift_x(),
						f[id .. hb[i].hb .. "top"] * m.scale_y + m.scr_shift_y(),
						f[id .. hb[i].hb .. "right"] * m.scale_x + m.scr_shift_x(),
						f[id .. hb[i].hb .. "bottom"] * m.scale_y + m.scr_shift_y(),
						c.color[hb[i].hb].color,
						c.color[hb[i].hb].fill,
						c.color[hb[i].hb].outline
					)
					draw_hitbox_data1(f, id, hb[i])
					draw_hitbox_data2(f, id, hb[i])
				end
			end
		end
	end
	if RAM.draw_hb_axis == true then
		guiline(
			(pos_x - c.axis_len) * m.scale_x + m.scr_shift_x(),
			(pos_y) * m.scale_y + m.scr_shift_y(),
			(pos_x + c.axis_len) * m.scale_x + m.scr_shift_x(),
			(pos_y) * m.scale_y + m.scr_shift_y(),
			c.color.axis.color,
			c.color.axis.outline
		)
		guiline(
			(pos_x) * m.scale_x + m.scr_shift_x(),
			(pos_y - c.axis_len) * m.scale_y + m.scr_shift_y(),
			(pos_x) * m.scale_x + m.scr_shift_x(),
			(pos_y + c.axis_len) * m.scale_y + m.scr_shift_y(),
			c.color.axis.color,
			c.color.axis.outline
		)
	end
end

function draw_hitbox(f)
	if f == nil then return end
	if f.isfight ~= true then return end
	for i = m.conf.proj_num, 1, -1 do
		draw_hitbox_detail(f, "proj" .. i, m.hbproj, true)
	end
	for i = m.conf.p_num, 1, -1 do
		draw_hitbox_detail(f, "p" .. i, m.hb, false)
		draw_hitbox_detail(f, "p" .. i, m.hbthrow, false)
		draw_hitbox_detail(f, "p" .. i, m.hbwire, false)
	end
end

function draw_common_data(f)
	local target00, target01
	local msg
	
	target00   = "timer"
	target01 = "timer_frame"
	if RAM.draw_data1 == true then
		guitext(disp[target00].x, disp[target00].y, string.format("%02d.%02d", f[target00], f[target01]))
		
		target00 = "turbo_speed"
		if f[target00] == 0 then
			msg = f[target00] .. ":NORMAL"
		elseif f[target00] == 6 then
			msg = f[target00] .. ":TURBO1"
		elseif f[target00] == 8 then
			msg = f[target00] .. ":TURBO2"
		else
			msg = f[target00] .. ":TURBO?"
		end
		guitext(disp[target00].x, disp[target00].y, string.format("%s", msg))
	end
end

function draw_player_data(f, id, proj)
	local target00, target01, target02, target03, target04, target05
	local color00, color01, color02, color03
	local msg
	local flg
	local temp00, temp01, temp02
	local STEP_Y = 7
	
	if (f[id .. "exist"] == nil) or (f[id .. "exist"] == 0x00) then return end
	if (proj == true) and (w_lshift(f[id .. "motion00"], 24) + w_lshift(f[id .. "motion01"], 16) + w_lshift(f[id .. "motion02"], 8) + w_lshift(f[id .. "motion03"], 0) > m.proj_alive) then return end
	if f[id .. "vital"] == nil then return end -- 3p and 4p is not supported
	
	color00 = nil
	target00 = id .. "motion00"
	target01 = id .. "motion01"
	target02 = id .. "motion02"
	target03 = id .. "motion03"
	flg = false
	
	if RAM.draw_data1 == true then
		for i = 1, #m.motion_table do
			if (m.motion_table[i][1] == f[target00]) and
			   (m.motion_table[i][2] == f[target01]) and
			   (m.motion_table[i][3] == f[target02]) and
			   (m.motion_table[i][4] == f[target03]) then
			    if disp[target00] == nil then return end
				guitext(disp[target00].x, disp[target00].y, string.format("%s", m.motion_table[i][5]))
				flg = true
				break
			end
		end
		if flg == false then
			color00 = 0xFF0000
			guitext(disp[target00].x, disp[target00].y, string.format("%02X%02X%02X%02X", f[target00], f[target01], f[target02], f[target03]), color00)
			if c.lua_debug == true then
				gd.createFromGdStr(gui.gdscreenshot()):png(string.format("%02X%02X%02X%02X", f[target00], f[target01], f[target02], f[target03]) ..".png")
				-- w_emu_pause()					-- bad code
			end
		end
		
		target00 = id .. "char_state"
		if f[target00] == 0 then
			msg = "Ground"
		elseif f[target00] == 1 then
			msg = "Mid Air"
		elseif f[target00] == 0xFF then
			msg = "Blown"
		end
		guitext(disp[target00].x, disp[target00].y, string.format("%s", msg))
		
		target00 = id .. "x"
		target01 = id .. "x_sub"
		target02 = id .. "y"
		target03 = id .. "y_sub"
		guitext(disp[target00].x, disp[target00].y, string.format("%6d.%04X,%6d.%04X", f[target00], w_and(f[target01], 0xFFFF), f[target02], w_and(f[target03], 0xFFFF)))
		
		target00 = id .. "direction"
		if f[target00] == 0 then
			msg = "Left"
		elseif f[target00] == 1 then
			msg = "Right"
		else
		end
		guitext(disp[target00].x, disp[target00].y, string.format("%s", msg))
		
		target00 = id .. "block_num"
		if (f[target00] > 0) then color00 = 0xFF0000 else color00 = nil end
		guitext(disp[target00].x, disp[target00].y, string.format("Block:%2d", f[target00]), color00)
		
		target00 = id .. "cc_left"
		if (f[target00] > 0) then color00 = 0xFF0000 else color00 = nil end
		guitext(disp[target00].x, disp[target00].y, string.format("CC:%3d", f[target00]), color00)
		
		target00 = id .. "vital"
		guitext(disp[target00].x, disp[target00].y, string.format("%3d/144", f[target00]))
		
		target00 = id .. "power"
		guitext(disp[target00].x, disp[target00].y, string.format("%3d/144", f[target00]))
		
		target00 = id .. "freeze"
		if (f[target00] > 0) then color00 = 0xFF0000 else color00 = nil end
		guitext(disp[target00].x, disp[target00].y, string.format("Freeze:%2d", f[target00]), color00)
		
		target00 = id .. "close"
		if (f[target00] > 0) then color00 = 0xFF0000 else color00 = nil end
		guitext(disp[target00].x, disp[target00].y, string.format("Close"), color00)
		
		color00 = nil
		target00 = id .. "corner_pos"
		if f[target00] == 0 then
			msg = "-"
		elseif f[target00] == 1 then
			msg = "<"
			color00 = 0xFF0000
		elseif f[target00] == 2 then
			msg = ">"
			color00 = 0xFF0000
		else
		end
		guitext(disp[target00].x, disp[target00].y, string.format("%s", msg), color00)
		
		target00 = id .. "anim_left"
		target01 = id .. "anim_ptr"
		guitext(disp[target00].x, disp[target00].y, string.format("Left:%3d/%3d", f[target00], w_ru8(f[target01])))
		
		target00 = id .. "guard"
		target01 = id .. "guard_max"
		target02 = id .. "guard_recov"
		target03 = id .. "guard_crushing"
		guitext(disp[target00].x, disp[target00].y, string.format("%3d->%2d/%2d->%2d", f[target02], f[target00], f[target01], f[target03]))
		
		target00 = id .. "stun"
		target01 = id .. "stun_max"
		target02 = id .. "stun_recov"
		target03 = id .. "stun_flag"
		
		target04 = id .. "stun_inv"
		target05 = id .. "multipurpose"
		if (f[target03] > 0) then color00 = 0xFF0000 else color00 = nil end
		if (f[target03] > 0) and (f[target04] == 0) then msg = f[target05] else msg = "---" end
		guitext(disp[target00].x, disp[target00].y, string.format("Stun:%3d->%3d/%3d->%3s", f[target02], f[target00], f[target01], msg), color00)
		
		target00 = id .. "combo"
		guitext(disp[target00].x, disp[target00].y, string.format("Combo:%2d/", f[target00]))
		target00 = id .. "combo_max"
		guitext(disp[target00].x, disp[target00].y, string.format("%2d", f[target00]))
		
		target00 = id .. "title_inv"
		target01 = id .. "time_inv"
		target02 = id .. "flag_inv"
		target03 = id .. "throw_inv"
		target04 = id .. "stun_inv"
		if (f[target01] > 0) then color00 = 0xFF0000 else color00 = nil end
		if (f[target02] > 0) then color01 = 0xFF0000 else color01 = nil end
		if (f[target03] == 2) then color02 = 0xFF0000 elseif (f[target03] == 0xFF) then color02 = 0xFFFF00 else color02 = nil end
		if (f[target04] > 0) then color03 = 0xFF0000 else color03 = nil end
		guitext(disp[target00].x, disp[target00].y, string.format("Invincible["))
		guitext(disp[target00].x+108, disp[target00].y, string.format("]"))
		guitext(disp[target01].x, disp[target01].y, string.format("%3d", f[target01]), color00)
		guitext(disp[target02].x, disp[target02].y, string.format("Flg"), color01)
		guitext(disp[target03].x, disp[target03].y, string.format("Throw"), color02)
		guitext(disp[target04].x, disp[target04].y, string.format("Stun"), color03)
		
		target00 = id .. "throw_inv_f"
		if (f[target00] > 0) then color00 = 0xFF0000 else color00 = nil end
		guitext(disp[target00].x, disp[target00].y, string.format("NoThrow:%2d", f[target00]), color00)

		target00 = id .. "anim_ptr"
		guitext(disp[target00].x, disp[target00].y, string.format("Anim:0x%08X", f[target00]))
	end
	if RAM.animation == true then
		temp00 = 0
		temp01 = 0
		target00 = id .. "anim_ptr"
		target01 = id .. "animation"
		if c.lua_debug == true and id == "p1" then
			temp02 = ""
			temp02 = temp02 .. string.format("%08X,", f[target00])
		end
		for i = 1, #ANIMATION do
			if ANIMATION[i].size == 1 then
				temp00 = w_ru8(f[target00] + ANIMATION[i].offset)
			elseif ANIMATION[i].size == 2 then
				temp00 = w_ru16(f[target00] + ANIMATION[i].offset)
			elseif ANIMATION[i].size == 4 then
				temp00 = w_ru32(f[target00] + ANIMATION[i].offset)
			end
			guitext(disp[target01].x, disp[target01].y + temp01, string.format("%s0x" .. ANIMATION[i].disp, ANIMATION[i].desc, temp00))
			temp01 = temp01 + STEP_Y
			if c.lua_debug == true and id == "p1" then
				temp02 = temp02 .. string.format(ANIMATION[i].disp .. ",", temp00)
			end
		end
		if c.lua_debug == true and id == "p1" then
			-- print(temp02)
		end
	end
end

function draw_input(f)
	if RAM.draw_input ~= true then return end
	if f == nil then return end
	if f["P1_org_lever"] == nil then return end

	temp_left = 2
	temp_x = temp_left
	temp_y = 40
	shift = 5
	button_shift = 10
	target00 = "P1_org_lever"
	for i = 1, #INPUT do
		if (INPUT[i].kind == "lever") and w_and(f[target00], INPUT[i].value) == INPUT[i].value then
			guitext(temp_x, temp_y, string.format("%s", INPUT[i].display), INPUT[i].color)
			temp_x = temp_x + shift
		end
	end
	temp_x = temp_left + button_shift
	target00 = "P1_org_button"
	for i = 1, #INPUT do
		if (INPUT[i].kind == "button") and w_and(f[target00], INPUT[i].value) == INPUT[i].value then
			guitext(temp_x, temp_y, string.format("%s", INPUT[i].display), INPUT[i].color)
			temp_x = temp_x + shift
		end
	end
	target00 = "start_coin_org"
	for i = 1, #INPUT do
		if (INPUT[i].kind == "1pstart_coin") and w_and(f[target00], INPUT[i].value) == INPUT[i].value then
			guitext(temp_x, temp_y, string.format("%s", INPUT[i].display), INPUT[i].color)
			temp_x = temp_x + shift
		end
	end
	
	temp_left = 340
	temp_x = temp_left
	target00 = "P2_org_lever"
	for i = 1, #INPUT do
		if (INPUT[i].kind == "lever") and w_and(f[target00], INPUT[i].value) == INPUT[i].value then
			guitext(temp_x, temp_y, string.format("%s", INPUT[i].display), INPUT[i].color)
			temp_x = temp_x + shift
		end
	end
	temp_x = temp_left + button_shift
	target00 = "P2_org_button"
	for i = 1, #INPUT do
		if (INPUT[i].kind == "button") and w_and(f[target00], INPUT[i].value) == INPUT[i].value then
			guitext(temp_x, temp_y, string.format("%s", INPUT[i].display), INPUT[i].color)
			temp_x = temp_x + shift
		end
	end
	target00 = "start_coin_org"
	for i = 1, #INPUT do
		if (INPUT[i].kind == "2pstart_coin") and w_and(f[target00], INPUT[i].value) == INPUT[i].value then
			guitext(temp_x, temp_y, string.format("%s", INPUT[i].display), INPUT[i].color)
			temp_x = temp_x + shift
		end
	end

	temp_left = 188
	temp_x = temp_left
	temp_y = 209
	target00 = "service_org"
	for i = 1, #INPUT do
		if (INPUT[i].kind == "service") and w_and(f[target00], INPUT[i].value) == INPUT[i].value then
			guitext(temp_x, temp_y, string.format("%s", INPUT[i].display), INPUT[i].color)
			temp_x = temp_x + shift
		end
	end
end

function draw_data(f)
	if f == nil then return end
	if f.isfight ~= true then return end
	
	draw_common_data(f)
	
	for i = 1, m.conf.p_num do
		draw_player_data(f, "p" .. i, false)
	end
end

function draw_common_other(f)
	local WORLD_WIDTH
	local BOX_LEFT
	local BOX_RIGHT
	local BOX_TOP
	local BOX_BOTTOM
	
	WORLD_WIDTH = 13
	if RAM.radar == "TYPE:X" then
		BOX_LEFT = -1
		BOX_RIGHT = w_scr_width()
		BOX_TOP = 40
		BOX_BOTTOM  = BOX_TOP + 18
		guibox(BOX_LEFT, BOX_TOP, BOX_RIGHT, BOX_BOTTOM, c.color.a_dimension.color, c.color.a_dimension.fill, c.color.a_dimension.outline)

		BOX_LEFT = w_scr_width() - WORLD_WIDTH
		BOX_RIGHT = w_scr_width()
		BOX_TOP = 40
		BOX_BOTTOM  = BOX_TOP + 18
		guibox(BOX_LEFT, BOX_TOP, BOX_RIGHT, BOX_BOTTOM, c.color.realworld.color, c.color.realworld.fill, c.color.realworld.outline)
	elseif RAM.radar == "TYPE:Y" then
		BOX_LEFT = w_scr_width() - WORLD_WIDTH
		BOX_RIGHT = w_scr_width()
		BOX_TOP = -1
		BOX_BOTTOM  = w_scr_height()
		
		guibox(BOX_LEFT, BOX_TOP, BOX_RIGHT, BOX_BOTTOM, c.color.a_dimension.color, c.color.a_dimension.fill, c.color.a_dimension.outline)
		
		BOX_LEFT = w_scr_width() - WORLD_WIDTH
		BOX_RIGHT = w_scr_width()
		BOX_TOP = w_scr_height() - 5
		BOX_BOTTOM  = w_scr_height()
		guibox(BOX_LEFT, BOX_TOP, BOX_RIGHT, BOX_BOTTOM, c.color.realworld.color, c.color.realworld.fill, c.color.realworld.outline)
	elseif RAM.radar == "TYPE:XY" then
		BOX_LEFT = -1
		BOX_RIGHT = w_scr_width()
		BOX_TOP = -1
		BOX_BOTTOM  = w_scr_height()
		guibox(BOX_LEFT, BOX_TOP, BOX_RIGHT, BOX_BOTTOM, c.color.a_dimension.color, c.color.a_dimension.fill, c.color.a_dimension.outline)
		
		BOX_LEFT = w_scr_width() - WORLD_WIDTH
		BOX_RIGHT = w_scr_width()
		BOX_TOP = w_scr_height() - 5
		BOX_BOTTOM  = w_scr_height()
		guibox(BOX_LEFT, BOX_TOP, BOX_RIGHT, BOX_BOTTOM, c.color.realworld.color, c.color.realworld.fill, c.color.realworld.outline)
	end
end

function draw_player_other(f, id, proj)
	local target00, target01
	local color00
	local pos_x, pos_y
	
	if (f[id .. "exist"] == nil) or (f[id .. "exist"] == 0x00) then return end
	if (proj == true) and (w_lshift(f[id .. "motion00"], 24) + w_lshift(f[id .. "motion01"], 16) + w_lshift(f[id .. "motion02"], 8) + w_lshift(f[id .. "motion03"], 0) > m.proj_alive) then return end
	if f[id .. "vital"] == nil then return end -- 3p and 4p is not supported
	
	if id == "p1" then
		color00 = 0xFF0000
	elseif id == "p2" then
		color00 = 0x0000FF
	elseif id == "p3" then
		color00 = 0x00FF00
	elseif id == "p4" then
		color00 = 0xFF00FF
	end
	target00 = id .. "x"
	target01 = id .. "y"
	if RAM.radar == "TYPE:X" then
		pos_x = f[target00]/0x56 + 369
		pos_y = (w_scr_height() - f[target01])/0x0B + 37
		guibox(pos_x, pos_y, pos_x + 2, pos_y + 2, color00, 0xFF, 0xFF)
	elseif RAM.radar == "TYPE:Y" or RAM.radar == "TYPE:XY" then
		pos_x = f[target00]/0x56 + 369
		pos_y = (w_scr_height() - f[target01])/0x129 + 220
		guibox(pos_x, pos_y, pos_x + 2, pos_y + 2, color00, 0xFF, 0xFF)
	end
end

function draw_other(f)
	if f == nil then return end
	if f.isfight ~= true then return end
	
	draw_common_other(f)
	
	for i = 1, m.conf.p_num do
		draw_player_other(f, "p" .. i, false)
	end
end

function cheat()
	if RAM.cheatchanged == true then
		if RAM.cheat == true then
			print("[STATIC CHEAT ON]")
			for i = 1, #m.cheat do
				if m.cheat[i].enable == true then
					print(m.cheat[i].desc .. ":" .. m.cheat[i].data)
				end
			end
		else
			print("[STATIC CHEAT OFF]")
		end
		RAM.cheatchanged = false
	end
	if RAM.cheat ~= true then return end
	for i = 1, #m.cheat do
		if m.cheat[i].enable == true then
			if m.cheat[i].size == 1 then
				w_wu8(m.cheat[i].addr, m.cheat[i].data, nil)
			elseif m.cheat[i].size == 2 then
				w_wu16(m.cheat[i].addr, m.cheat[i].data, nil)
			elseif m.cheat[i].size == 4 then
				w_wu32(m.cheat[i].addr, m.cheat[i].data, nil)
			end
		end
	end
end

function check_iput_key()
	local now
	for i,v in pairs(KEYBOARD) do
		now = w_input_pressed(KEYBOARD[i][G_emulator])
		if now == true then
			if KEYBOARD[i].prev == false then
				KEYBOARD[i].toggle = not KEYBOARD[i].toggle
			end
			KEYBOARD[i].prev = true
		else
			KEYBOARD[i].prev = false
		end
	end
end

function chg_menu_status()
	for i = 1, #MENUTRIGGER do
		if KEYBOARD[MENUTRIGGER[i]].prev ~= true then
			RAM.menu_prev = false
			return
		end
	end
	if RAM.menu_prev == false then
		RAM.menu_toggle = not RAM.menu_toggle
	end
	RAM.menu_prev = true
end

function toggle_status_off()
	for i,v in pairs(KEYBOARD) do
		KEYBOARD[i].toggle = false
	end
end

function update_menu()
	local vertical, horizontal
	vertical = 0
	horizontal = 0
	
	if KEYBOARD["UP"].toggle == true then
		vertical = -1 + vertical
	end
	if KEYBOARD["DOWN"].toggle == true then
		vertical = 1 + vertical
	end
	if KEYBOARD["RIGHT"].toggle == true then
		horizontal = 1 + horizontal
	end
	if KEYBOARD["LEFT"].toggle == true then
		horizontal = -1 + horizontal
	end

	MENU.v = MENU.v + vertical
	if MENU.v > #MENU then
		MENU.v = 1
	elseif MENU.v < 1 then
		MENU.v = #MENU
	end
	MENU[MENU.v].h = MENU[MENU.v].h + horizontal

	if MENU[MENU.v].h > #MENU[MENU.v].desc then
		MENU[MENU.v].h = 1
	elseif MENU[MENU.v].h < 1 then
		MENU[MENU.v].h = #MENU[MENU.v].desc
	end
end

function display_menu()
	local STEP_X = 130
	local STEP_Y = 8
	local COL_NUM = 2
	local BOX_WIDTH = w_scr_width() - 120
	local BOX_HEIGHT = (math.ceil(#MENU / COL_NUM) - 1) * STEP_Y + 22
	local BOX_LEFT = (w_scr_width()/2)  - (BOX_WIDTH/2)
	local BOX_TOP  = (w_scr_height()/2) - (BOX_HEIGHT/2)
	local CONFIG_SHIFT = 72
	local BASE_X = 8
	local BASE_Y = 8
	local pos_x, pos_y, default_x, default_y
	local color = ""
	
	guibox(BOX_LEFT, BOX_TOP, BOX_LEFT + BOX_WIDTH, BOX_TOP + BOX_HEIGHT, c.color.menu.color, c.color.menu.fill, c.color.menu.outline)
	
	default_x = BOX_LEFT + BASE_X
	default_y = BOX_TOP + BASE_Y
	
	for i = 1, #MENU do
		pos_x = default_x + math.floor((i - 1) / math.ceil(#MENU/COL_NUM)) * STEP_X
		pos_y = default_y + math.floor((i - 1) % math.ceil(#MENU/COL_NUM)) * STEP_Y
		guitext(pos_x, pos_y, MENU[i].kind, c.color.text.color, c.color.text.alpha)
		if i == MENU.v then
			color = 0xFF0000
		else
			color = c.color.text.color
		end
		guitext(pos_x + CONFIG_SHIFT, pos_y, MENU[i].desc[MENU[i].h], color, c.color.text.alpha)
	end
end

function exe_menu()
	for i = 1, #MENU do 
		if MENU[i].kind == "RESTART" and ismenu() ~= true then
			if MENU[i].desc[MENU[i].h] == "RESTART" then
				w_wu16(m.cmm.base + m.cmm.element.status01.offset, 0x04)
				w_wu16(m.cmm.base + m.cmm.element.status02.offset, 0x00)
				w_wu16(m.cmm.base + m.cmm.element.status03.offset, 0x00)
				MENU[i].h = 1
			end
		end
		if MENU[i].kind == "CHANGE CHAR" and ismenu() ~= true then
			if MENU[i].desc[MENU[i].h] == "CHANGE CHAR" then
				w_wu16(m.cmm.base + m.cmm.element.status00.offset, 0x00)
				w_wu16(m.cmm.base + m.cmm.element.status01.offset, 0x00)
				w_wu16(m.cmm.base + m.cmm.element.status02.offset, 0x00)
				w_wu16(m.cmm.base + m.cmm.element.status03.offset, 0x00)
				MENU[i].h = 1
			end
		end
		if MENU[i].kind == "TIMER" then
			if MENU[i].desc[MENU[i].h] == "STOP" then
				w_wu8(m.cmm.base + m.cmm.element.timer.offset, 0x63)
				w_wu8(m.cmm.base + m.cmm.element.timer_frame.offset, 0x3B)
			end
		end
		if MENU[i].kind == "SPEED" then
			if MENU[i].desc[MENU[i].h] == "NORMAL" then
				w_wu8(m.cmm.base + m.cmm.element.turbo_speed.offset, 0x00)
			elseif MENU[i].desc[MENU[i].h] == "TURBO1" then
				w_wu8(m.cmm.base + m.cmm.element.turbo_speed.offset, 0x06)
			elseif MENU[i].desc[MENU[i].h] == "TURBO2" then
				w_wu8(m.cmm.base + m.cmm.element.turbo_speed.offset, 0x08)
			elseif MENU[i].desc[MENU[i].h] == "RAPID" then
				w_wu8(m.cmm.base + m.cmm.element.turbo_speed.offset, 0x0F)
			end
		end
		if MENU[i].kind == "1P EXISTENCE" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				if RAM.draw_p1 == false then
					w_wu8(m.obj.p_base[1] + m.obj.element.draw.offset, 0x01)
				end
				if RAM.exist_p1 == false then
					w_wu8(m.obj.p_base[1] + m.obj.element.exist.offset, 0x01)
				end
			elseif MENU[i].desc[MENU[i].h] == "NOT DRAW" then
				w_wu8(m.obj.p_base[1] + m.obj.element.draw.offset, 0x00)
				RAM.draw_p1 = false
			elseif MENU[i].desc[MENU[i].h] == "NONE" then
				w_wu8(m.obj.p_base[1] + m.obj.element.draw.offset, 0x00)
				w_wu8(m.obj.p_base[1] + m.obj.element.exist.offset, 0x00)
				RAM.draw_p1 = false
				RAM.exist_p1 = false
			end
		end
		if MENU[i].kind == "2P EXISTENCE" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				if RAM.draw_p2 == false then
					w_wu8(m.obj.p_base[2] + m.obj.element.draw.offset, 0x01)
				end
				if RAM.exist_p2 == false then
					w_wu8(m.obj.p_base[2] + m.obj.element.exist.offset, 0x01)
				end
			elseif MENU[i].desc[MENU[i].h] == "NOT DRAW" then
				w_wu8(m.obj.p_base[2] + m.obj.element.draw.offset, 0x00)
				RAM.draw_p2 = false
			elseif MENU[i].desc[MENU[i].h] == "NONE" then
				w_wu8(m.obj.p_base[2] + m.obj.element.draw.offset, 0x00)
				w_wu8(m.obj.p_base[2] + m.obj.element.exist.offset, 0x00)
				RAM.draw_p2 = false
				RAM.exist_p2 = false
			end
		end
		if MENU[i].kind == "1P VITAL" then
			if MENU[i].desc[MENU[i].h] == "MAX" then
				w_wu16(m.obj.p_base[1] + m.obj.element.vital.offset, 0x90)
			elseif MENU[i].desc[MENU[i].h] == "REFILL" and ismenu() ~= true then
				if w_ru8(m.obj.p_base[1] + m.obj.element.combo.offset) == 0x00 then
					w_wu16(m.obj.p_base[1] + m.obj.element.vital.offset, 0x90)
				end
			end
		end
		if MENU[i].kind == "2P VITAL" then
			if MENU[i].desc[MENU[i].h] == "MAX" then
				w_wu16(m.obj.p_base[2] + m.obj.element.vital.offset, 0x90)
			elseif MENU[i].desc[MENU[i].h] == "REFILL" and ismenu() ~= true then
				if w_ru8(m.obj.p_base[2] + m.obj.element.combo.offset) == 0x00 then
					w_wu16(m.obj.p_base[2] + m.obj.element.vital.offset, 0x90)
				end
			end
		end
		if MENU[i].kind == "1P GAUGE" then
			if w_ru8(m.obj.p_base[1] + m.obj.element.cc_flg.offset) ~= 0x01 then
				if MENU[i].desc[MENU[i].h] == "0" then
					w_wu16(m.obj.p_base[1] + m.obj.element_detail.power.offset, 0x00)
				elseif MENU[i].desc[MENU[i].h] == "1/3" then
					w_wu16(m.obj.p_base[1] + m.obj.element_detail.power.offset, 0x30)
				elseif MENU[i].desc[MENU[i].h] == "1/2" then
					w_wu16(m.obj.p_base[1] + m.obj.element_detail.power.offset, 0x48)
				elseif MENU[i].desc[MENU[i].h] == "2/3" then
					w_wu16(m.obj.p_base[1] + m.obj.element_detail.power.offset, 0x60)
				elseif MENU[i].desc[MENU[i].h] == "MAX" then
					w_wu16(m.obj.p_base[1] + m.obj.element_detail.power.offset, 0x90)
				end
			end
		end
		if MENU[i].kind == "2P GAUGE" then
			if w_ru8(m.obj.p_base[2] + m.obj.element.cc_flg.offset) ~= 0x01 then
				if MENU[i].desc[MENU[i].h] == "0" then
					w_wu16(m.obj.p_base[2] + m.obj.element_detail.power.offset, 0x00)
				elseif MENU[i].desc[MENU[i].h] == "1/3" then
					w_wu16(m.obj.p_base[2] + m.obj.element_detail.power.offset, 0x30)
				elseif MENU[i].desc[MENU[i].h] == "1/2" then
					w_wu16(m.obj.p_base[2] + m.obj.element_detail.power.offset, 0x48)
				elseif MENU[i].desc[MENU[i].h] == "2/3" then
					w_wu16(m.obj.p_base[2] + m.obj.element_detail.power.offset, 0x60)
				elseif MENU[i].desc[MENU[i].h] == "MAX" then
					w_wu16(m.obj.p_base[2] + m.obj.element_detail.power.offset, 0x90)
				end
			end
		end
		if MENU[i].kind == "1P STUN" then
			if MENU[i].desc[MENU[i].h] == "ALWAYS" then
				if w_ru8(m.obj.p_base[1] + m.obj.element.combo.offset) == 0x00 then
					local value
					value = w_ru8(m.obj.p_base[1] + m.obj.element_detail.stun_max.offset)
					w_wu8(m.obj.p_base[1] + m.obj.element_detail.stun.offset, value)
				end
			elseif MENU[i].desc[MENU[i].h] == "NONE" then
				w_wu8(m.obj.p_base[1] + m.obj.element_detail.stun.offset, 0x00)
			end
		end
		if MENU[i].kind == "2P STUN" then
			if MENU[i].desc[MENU[i].h] == "ALWAYS" then
				if w_ru8(m.obj.p_base[2] + m.obj.element.combo.offset) == 0x00 then
					local value
					value = w_ru8(m.obj.p_base[2] + m.obj.element_detail.stun_max.offset)
					w_wu8(m.obj.p_base[2] + m.obj.element_detail.stun.offset, value)
				end
			elseif MENU[i].desc[MENU[i].h] == "NONE" then
				w_wu8(m.obj.p_base[2] + m.obj.element_detail.stun.offset, 0x00)
			end
		end
		if MENU[i].kind == "HITBOX AXIS" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_axis = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_axis = true
			end
		end
		if MENU[i].kind == "HITBOX HEAD" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_head = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_head = true
			end
		end
		if MENU[i].kind == "HITBOX BODY" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_body = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_body = true
			end
		end
		if MENU[i].kind == "HITBOX FOOT" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_foot = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_foot = true
			end
		end
		if MENU[i].kind == "HITBOX OSHI" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_oshi = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_oshi = true
			end
		end
		if MENU[i].kind == "HITBOX ATTACK" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_attack = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_attack = true
			end
		end
		if MENU[i].kind == "HITBOX THROW" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_throw = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_throw = true
			end
		end
		if MENU[i].kind == "HITBOX WIRE" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_wire = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_wire = true
			end
		end
		if MENU[i].kind == "HITBOX PROJECTILE" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_hb_proj = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_hb_proj = true
			end
		end
		if MENU[i].kind == "HITBOX DATA1" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.hitbox_data1 = ""
			elseif MENU[i].desc[MENU[i].h] == "STANDARD" then
				RAM.hitbox_data1 = "STANDARD"
			elseif MENU[i].desc[MENU[i].h] == "ADVANCED" then
				RAM.hitbox_data1 = "ADVANCED"
			end
		end
		if MENU[i].kind == "HITBOX DATA2" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.hitbox_data2 = ""
			elseif MENU[i].desc[MENU[i].h] == "PLAYER" then
				RAM.hitbox_data2 = "PLAYER"
			elseif MENU[i].desc[MENU[i].h] == "PROJ ATTACK" then
				RAM.hitbox_data2 = "PROJ ATTACK"
			elseif MENU[i].desc[MENU[i].h] == "PROJ HEAD" then
				RAM.hitbox_data2 = "PROJ HEAD"
			elseif MENU[i].desc[MENU[i].h] == "PROJ OSHI" then
				RAM.hitbox_data2 = "PROJ OSHI"
			end
		end
		if MENU[i].kind == "ANIMATION DATA" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.animation = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.animation = true
			end
		end
		if MENU[i].kind == "VARIOUS DATA1" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_data1 = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_data1 = true
			end
		end
		if MENU[i].kind == "STATIC CHEAT" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				if RAM.cheat == true then RAM.cheatchanged = true end
				RAM.cheat = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				if RAM.cheat == false then RAM.cheatchanged = true end
				RAM.cheat = true
			end
		end
		if MENU[i].kind == "INPUT DISPLAY" then
			if MENU[i].desc[MENU[i].h] == "OFF" then
				RAM.draw_input = false
			elseif MENU[i].desc[MENU[i].h] == "ON" then
				RAM.draw_input = true
			end
		end
		if MENU[i].kind == "RADAR" then
			if MENU[i].desc[MENU[i].h] == "TYPE:X" then
				RAM.radar = "TYPE:X"
			elseif MENU[i].desc[MENU[i].h] == "TYPE:Y" then
				RAM.radar = "TYPE:Y"
			elseif MENU[i].desc[MENU[i].h] == "TYPE:XY" then
				RAM.radar = "TYPE:XY"
			else
				RAM.radar = nil
			end
		end
		if MENU[i].kind == "GRID" then
			if MENU[i].desc[MENU[i].h] == "TYPE:1" then
				for j = 0, w_scr_width() - 1, 32 do
					guiline(j, 0, j, w_scr_height() - 1, c.color.grid.color, c.color.grid.alpha)
				end
				for j = 0, w_scr_height() - 1, 32 do
					guiline(0, j, w_scr_width() - 1, j, c.color.grid.color, c.color.grid.alpha)
				end
			elseif MENU[i].desc[MENU[i].h] == "TYPE:2" then
				for j = 0, w_scr_width() - 1, 16 do
					guiline(j, 0, j, w_scr_height() - 1, c.color.grid.color, c.color.grid.alpha)
				end
				for j = 0, w_scr_height() - 1, 16 do
					guiline(0, j, w_scr_width() - 1, j, c.color.grid.color, c.color.grid.alpha)
				end
			elseif MENU[i].desc[MENU[i].h] == "TYPE:3" then
				for j = 0, w_scr_width() - 1, 8 do
					guiline(j, 0, j, w_scr_height() - 1, c.color.grid.color, c.color.grid.alpha)
				end
				for j = 0, w_scr_height() - 1, 8 do
					guiline(0, j, w_scr_width() - 1, j, c.color.grid.color, c.color.grid.alpha)
				end
			end
		end
		if MENU[i].kind == "BGM" and ismenu() ~= true then
			if MENU[i].desc[MENU[i].h] == "DISABLE" then
				if RAM.bgm == nil then
					if (G_emulator == "mame" or G_emulator == "mame_old") then
						RAM.bgm = manager.machine.devices[":audiocpu"].spaces["program"]:read_i8(0xF027)
					end
				end
				if (G_emulator == "mame" or G_emulator == "mame_old") then
					manager.machine.devices[":audiocpu"].spaces["program"]:write_i8(0xF027, 0x00)
				elseif G_emulator == "mamerr" then
					print("BGM:Execute below command in the debug window(Cannot be restored)(Recommend:Official MAME and [-debug])")
					print(string.format("audiocpu.pb@0xF027=0"))
				elseif G_emulator == "fbarr" or G_emulator == "fcfbneo" then		-- opcodeは変更不能？なため完全には対応出来ないっぽい？
					print("Not supported(Recommend:Official MAME and [-debug])")
				else
					print("Not supported(Recommend:Official MAME and [-debug])")
				end
			elseif MENU[i].desc[MENU[i].h] == "RESTORE" then
				if RAM.bgm ~= nil then
					if G_emulator == "mame" or G_emulator == "mame_old" then
						manager.machine.devices[":audiocpu"].spaces["program"]:write_i8(0xF027, RAM.bgm)
					else
					end
				else
					print("Not supported(Recommend:Official MAME and [-debug])")
				end
			end
			MENU[i].h = 1
		end
		if MENU[i].kind == "HUD" and ismenu() ~= true then
			if MENU[i].desc[MENU[i].h] == "DISABLE" then
				if RAM.hud == nil then
					RAM.hud = {}
					for j = 1, #BLSCR[RAM.version] do
						if BLSCR[RAM.version][j].bg == false then
							RAM.hud[j] = w_ru16(BLSCR[RAM.version][j].addr)
						end
					end
				end
				for j = 1, #BLSCR[RAM.version] do
					if BLSCR[RAM.version][j].bg == false then
						w_wu16(BLSCR[RAM.version][j].addr, BLSCR[RAM.version][j].data)
					end
				end
			elseif MENU[i].desc[MENU[i].h] == "RESTORE" then
				if RAM.hud ~= nil then
					for j = 1, #BLSCR[RAM.version] do
						if BLSCR[RAM.version][j].bg == false then
							w_wu16(BLSCR[RAM.version][j].addr, RAM.hud[j])
						end
					end
				end
			end
			MENU[i].h = 1
		end
		if MENU[i].kind == "BACK GROUND" and ismenu() ~= true then
			if MENU[i].desc[MENU[i].h] == "DISABLE" then
				if RAM.blackscr == nil then
					if (G_emulator == "mame" or G_emulator == "mame_old") and G_dbg ~= nil then
						RAM.blackscr = {}
						for j = 1, #BLSCR[RAM.version] do
							if BLSCR[RAM.version][j].bg == true then
								G_dbg:command(string.format("temp0=%s0x%02X", BLSCR[RAM.version][j].cmd, BLSCR[RAM.version][j].addr))
								G_dbg:command("print temp0")
								RAM.blackscr[j] = tonumber(G_dbg.consolelog[#G_dbg.consolelog], 16)
							end
						end
					end
				end
				if (G_emulator == "mame" or G_emulator == "mame_old") and G_dbg ~= nil then
					for j = 1, #BLSCR[RAM.version] do
						if BLSCR[RAM.version][j].bg == true then
							G_dbg:command(string.format("%s0x%X=0x%02X", BLSCR[RAM.version][j].cmd, BLSCR[RAM.version][j].addr, BLSCR[RAM.version][j].data))
						end
					end
				elseif G_emulator == "mamerr" then
					print("BACK GROUND:Execute below command in the debug window(Cannot be restored)(Recommend:Official MAME and [-debug])")
					for j = 1, #BLSCR[RAM.version] do
						if BLSCR[RAM.version][j].bg == true then
							print(string.format("%s0x%X=0x%02X", BLSCR[RAM.version][j].cmd, BLSCR[RAM.version][j].addr, BLSCR[RAM.version][j].data))
						end
					end
				elseif G_emulator == "fbarr" or G_emulator == "fcfbneo" then
					print("Not supported(Recommend:Official MAME and [-debug])")
					for j = 1, #BLSCR[RAM.version] do
						if BLSCR[RAM.version][j].bg == true then
							if BLSCR[RAM.version][j].size == 1 then
								w_wu8(BLSCR[RAM.version][j].addr, BLSCR[RAM.version][j].data)
							elseif BLSCR[RAM.version][j].size == 2 then
								w_wu16(BLSCR[RAM.version][j].addr, BLSCR[RAM.version][j].data)
							elseif BLSCR[RAM.version][j].size == 4 then
								w_wu32(BLSCR[RAM.version][j].addr, BLSCR[RAM.version][j].data)
							else
							end
						end
					end
				else
					print("Not supported(Recommend:Official MAME and [-debug])")
				end
			elseif MENU[i].desc[MENU[i].h] == "RESTORE" then
				if RAM.blackscr ~= nil then
					if G_emulator == "mame" or G_emulator == "mame_old" then
						for j = 1, #BLSCR[RAM.version] do
							if BLSCR[RAM.version][j].bg == true then
								G_dbg:command(string.format("%s0x%X=0x%02X", BLSCR[RAM.version][j].cmd, BLSCR[RAM.version][j].addr, RAM.blackscr[j]))
							end
						end
					else
					end
				else
					print("Not supported(Recommend:Official MAME and [-debug])")
				end
			end
			MENU[i].h = 1
		end
	end
end

function ismenu()
	return RAM.menu_toggle
end

function menu(f)
	if RAM.menu_enabled ~= true then return end
	if f == nil then return end
	if f.isfight ~= true then return end
	check_iput_key()
	chg_menu_status()
	if ismenu() == true then
		update_menu()
		display_menu()
	end
	toggle_status_off()
	exe_menu()
end

function draw()
	if gui ~= nil and gui.clearuncommitted ~= nil then gui.clearuncommitted() end
	-- draw input
	draw_input(G_frame[G_delay + 1])
	-- draw final frame
	draw_hitbox(G_frame[G_delay + 1])
	draw_data(G_frame[G_delay + 1])
	draw_other(G_frame[G_delay + 1])
	menu(G_frame[G_delay + 1])
	cheat()
end

function one_cycle()
	get_data()
	draw()
end

function main()
	init_game()
	register_bp()
	
	for i = 1, #G_cycle_table do
		if G_emulator == G_cycle_table[i].emulator then
			if G_cycle_table[i].cycle_type == "frameadvance" then
				while(true) do
					one_cycle()
					emu.frameadvance()
				end
			else
				register_func()
				break
			end
		end
	end
end

main()
