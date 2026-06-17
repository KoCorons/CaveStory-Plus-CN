local _flash = 0

local function ActBossChar_Ironhead()
	local npc

	npc = cs.gBoss[1]

	if npc.act_no == 0 or npc.act_no == 1 then
		-- ・ｽ・ｽ・ｽ・ｽ・ｽﾝ抵ｿｽ
		if npc.act_no == 0 then
			npc.cond        = cs.COND_ALIVE
			npc.exp         = 1
			npc.direct      = cs.DIR_RIGHT
			npc.act_no      = 100
			npc.x           = 10 * cs.VS * cs.PARTSSIZE
			npc.y           =  8 * cs.VS * cs.PARTSSIZE
			npc.view.front  = 40 * cs.VS
			npc.view.top    = 12 * cs.VS
			npc.view.back   = 24 * cs.VS
			npc.view.bottom = 12 * cs.VS
			npc.hit_voice   = cs.WAVE_NPC_GOHST
			npc.hit.front   = 16 * cs.VS
			npc.hit.top     = 10 * cs.VS
			npc.hit.back    = 16 * cs.VS
			npc.hit.bottom  = 10 * cs.VS
			npc.bits = cs.BITS_THROW_BLOCK | cs.BITS_EVENT_BREAK | cs.BITS_BANISH_DAMAGE | cs.BITS_VIEWDAMAGE
			npc.size = cs.NPCSIZE_LARGE
			npc.damage      = 10

			npc.code_event  = 1000
			npc.life        =  500
		end

		-- ・ｽﾒ機
	elseif npc.act_no == 100 or npc.act_no == 101 then
		-- ・ｽ・ｽ・ｽﾊ外・ｽﾒ機
		if npc.act_no == 100 then
			npc.act_no   = 101
			npc.bits     = npc.bits & ~cs.BITS_BANISH_DAMAGE
			npc.act_wait = 0
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 1 * 50 then
			npc.act_no = 250
			npc.act_wait = 0
		end
		if cs.mod(npc.act_wait, 4) == 0 then
			cs.SetNpChar(197, cs.VS * cs.PARTSSIZE * cs.Random(12, 15),
			                  cs.VS * cs.PARTSSIZE * cs.Random( 2, 13), 0, 0, 0, nil, cs.div(cs.MAX_NPC, 2))
		end
	elseif npc.act_no == 250 or npc.act_no == 251 then
		-- ・ｽﾋ進
		if npc.act_no == 250 then
			npc.act_no = 251
			npc.tgt_mc = cs.Random(0, cs.gNumMyChar - 1)
			if npc.direct == cs.DIR_RIGHT then
				npc.x = cs.VS * cs.PARTSSIZE * 14
				npc.y = cs.gMC[1 + npc.tgt_mc].y
			else
				npc.x = cs.VS * cs.PARTSSIZE * 46
				npc.y = cs.VS * cs.PARTSSIZE * cs.Random(2, 13)
			end
			npc.tgt_x  = npc.x
			npc.tgt_y  = npc.y
			npc.ym = cs.Random(-cs.VS, cs.VS)
			npc.xm = cs.Random(-cs.VS, cs.VS)
			npc.bits = npc.bits | cs.BITS_BANISH_DAMAGE
		end

		if npc.direct == cs.DIR_RIGHT then
			npc.tgt_x = npc.tgt_x + 2 * cs.VS
		else
			npc.tgt_x = npc.tgt_x - 1 * cs.VS
			if npc.tgt_y < cs.gMC[1 + npc.tgt_mc].y then
				npc.tgt_y = npc.tgt_y + cs.VS
			else
				npc.tgt_y = npc.tgt_y - cs.VS
			end
		end

		if npc.x < npc.tgt_x then
			npc.xm = npc.xm + cs.div(cs.VS, 64)
		else
			npc.xm = npc.xm - cs.div(cs.VS, 64)
		end
		if npc.y < npc.tgt_y then
			npc.ym = npc.ym + cs.div(cs.VS, 64)
		else
			npc.ym = npc.ym - cs.div(cs.VS, 64)
		end

		if npc.ym >  cs.VS then
			npc.ym =  cs.VS
		end
		if npc.ym < -cs.VS then
			npc.ym = -cs.VS
		end

		npc.x = npc.x + npc.xm
		npc.y = npc.y + npc.ym

		if npc.direct == cs.DIR_RIGHT then
			if npc.x > cs.VS * cs.PARTSSIZE * 46 then
				npc.direct = cs.DIR_LEFT
				npc.act_no = 100
			end
		else
			if npc.x < cs.VS * cs.PARTSSIZE * 14 then
				npc.direct = cs.DIR_RIGHT
				npc.act_no = 100
			end
		end
		-- ・ｽ・ｽ・ｽ[・ｽU・ｽ[
		if npc.direct == cs.DIR_LEFT then
			npc.act_wait = npc.act_wait + 1
			if npc.act_wait == 50 * 6 or npc.act_wait == 50 * 6 + 10 or npc.act_wait == 50 * 6 + 20 then
				cs.PlaySoundObject(cs.WAVE_POP, 1)
				cs.SetNpChar(198, npc.x + 10 * cs.VS, npc.y + cs.VS, cs.Random(-3, 0) * cs.VS, cs.Random(-3, 3) * cs.VS, cs.DIR_RIGHT, nil, cs.div(cs.MAX_NPC, 2))
			end
		end

		-- ・ｽA・ｽj・ｽ・ｽ・ｽ[・ｽV・ｽ・ｽ・ｽ・ｽ
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 7 then
			npc.ani_no = 0
		end
	elseif npc.act_no == 1000 or npc.act_no == 1001 then
		-- ・ｽﾞ具ｿｽ
		if npc.act_no == 1000 then
			npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
			npc.ani_no = 8
			npc.damage = 0
			npc.act_no = 1001
			npc.tgt_x = npc.x
			npc.tgt_y = npc.y
			cs.SetQuake(20)
			for i = 0, 31 do
				cs.SetNpChar(4,
					npc.x + cs.Random(-128, 128) * cs.VS,
					npc.y + cs.Random( -64,  64) * cs.VS,
					cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
					cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
					cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
			cs.DeleteNpCharCode(197, true)
			cs.DeleteNpCharCode(271, true)
			cs.DeleteNpCharCode(272, true)
		end

		npc.tgt_x = npc.tgt_x - cs.VS
		npc.x = npc.tgt_x + cs.Random(-1, 1) * cs.VS
		npc.y = npc.tgt_y + cs.Random(-1, 1) * cs.VS
		npc.act_wait = npc.act_wait + 1
		if cs.mod(npc.act_wait, 4) == 0 then
			cs.SetNpChar(4,
				npc.x + cs.Random(-128, 128) * cs.VS,
				npc.y + cs.Random( -64,  64) * cs.VS,
				cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
				cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
				cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end
	end

	local rc = {
		{left =   0, top =   0, right =  64, bottom =  24},
		{left =  64, top =   0, right = 128, bottom =  24},
		{left = 128, top =   0, right = 192, bottom =  24},
		{left =  64, top =   0, right = 128, bottom =  24},

		{left =   0, top =   0, right =  64, bottom =  24},
		{left = 192, top =   0, right = 256, bottom =  24},
		{left = 256, top =   0, right = 320, bottom =  24},
		{left = 192, top =   0, right = 256, bottom =  24},

		{left = 256, top =  48, right = 320, bottom =  72},
	}
	local rcDamage = {
		{left =   0, top =  24, right =  64, bottom =  48},
		{left =  64, top =  24, right = 128, bottom =  48},
		{left = 128, top =  24, right = 192, bottom =  48},
		{left =  64, top =  24, right = 128, bottom =  48},

		{left =   0, top =  24, right =  64, bottom =  48},
		{left = 192, top =  24, right = 256, bottom =  48},
		{left = 256, top =  24, right = 320, bottom =  48},
		{left = 192, top =  24, right = 256, bottom =  48},

		{left = 256, top =  48, right = 320, bottom =  72},
	}
	if npc.shock ~= 0 then
		_flash = _flash + 1
		if cs.mod(cs.div(_flash, 2), 2) ~= 0 then
			npc.rect = rc[      1 + npc.ani_no]
		else
			npc.rect = rcDamage[1 + npc.ani_no]
		end
	else
		npc.rect = rc[1 + npc.ani_no]
	end
end

return ActBossChar_Ironhead
