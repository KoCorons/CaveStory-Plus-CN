local _flash = 0

local function ActBossChar_Press()
	local npc
	local x

	local initX = 13 * cs.VS * cs.PARTSSIZE

	npc = cs.gBoss[1]

	if npc.act_no == 0 or npc.act_no == 1 then
		if npc.act_no == 0 then
			npc.act_no      = 10
			npc.cond        = cs.COND_ALIVE
			npc.exp         = 1
			npc.direct      = cs.DIR_RIGHT
			npc.x           = 0 * cs.VS * cs.PARTSSIZE
			npc.y           = 0 * cs.VS * cs.PARTSSIZE
			npc.view.front  = 40 * cs.VS
			npc.view.top    = 60 * cs.VS
			npc.view.back   = 40 * cs.VS
			npc.view.bottom = 60 * cs.VS
			npc.hit_voice   = cs.WAVE_NPC_GOHST
			npc.hit.front   = 49 * cs.VS
			npc.hit.top     = 60 * cs.VS
			npc.hit.back    = 40 * cs.VS
			npc.hit.bottom  = 48 * cs.VS
			npc.bits        = cs.BITS_BLOCK_MYCHAR2 | cs.BITS_THROW_BLOCK | cs.BITS_EVENT_BREAK | cs.BITS_VIEWDAMAGE -- | BITS_BANISH_DAMAGE
			npc.size        = cs.NPCSIZE_LARGE
			npc.damage      = 10

			npc.code_event  = 1000
			npc.life        = 666
		end
	elseif npc.act_no == 5 or npc.act_no == 6 then
		if npc.act_no == 5 then
			npc.act_no       = 6
			npc.x            = 0
			npc.y            = 0
			cs.gBoss[2].cond = 0
			cs.gBoss[3].cond = 0
		end
	elseif npc.act_no == 10 or npc.act_no == 11 then
		if npc.act_no == 10 then
			npc.act_no = 11
			npc.x      = initX
			npc.y      = 74 * cs.VS
		end
	elseif npc.act_no == 20 or npc.act_no == 21 then
		if npc.act_no == 20 then
			npc.damage = 0
			npc.act_no = 21
			npc.x      = initX
			npc.y      = 25 * cs.VS * cs.PARTSSIZE + 13 * cs.VS
			npc.bits = npc.bits & ~cs.BITS_BLOCK_MYCHAR2
			cs.gBoss[2].cond = 0
			cs.gBoss[3].cond = 0
		end

		npc.act_wait = npc.act_wait + 1
		if cs.mod(npc.act_wait, 16) == 0 then
			cs.SetDestroyNpChar(npc.x + cs.Random(-40, 40) * cs.VS,
			                    npc.y + cs.Random(-60, 60) * cs.VS, 1, 1)
		end
	elseif npc.act_no == 30 or npc.act_no == 31 then
		if npc.act_no == 30 then
			npc.act_no = 31
			npc.ani_no =  2
			npc.x      = initX
			npc.y      =  4 * cs.VS * cs.PARTSSIZE
		end

		npc.y = npc.y + cs.VS * 4
		if npc.y >= 25 * cs.VS * cs.PARTSSIZE + 13 * cs.VS then
			npc.y      = 25 * cs.VS * cs.PARTSSIZE + 13 * cs.VS
			npc.ani_no =  0
			npc.act_no = 20
			cs.PlaySoundObject(cs.WAVE_BOM, 1)
			for i = 0, 4 do
				x = npc.x + cs.Random(-40, 40) * cs.VS
				cs.SetNpChar(4, x, npc.y + 60 * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
		end
	elseif npc.act_no == 100 or npc.act_no == 101 then
		if npc.act_no == 100 then
			npc.act_no             = 101
			npc.count2             =  9
			npc.act_wait           = -100
			cs.gBoss[2].cond       = cs.COND_ALIVE
			cs.gBoss[2].hit.front  = 14 * cs.VS
			cs.gBoss[2].hit.back   = 14 * cs.VS
			cs.gBoss[2].hit.top    =  8 * cs.VS
			cs.gBoss[2].hit.bottom =  8 * cs.VS
			cs.gBoss[2].bits       = cs.BITS_BLOCK_BULLET | cs.BITS_THROW_BLOCK
			cs.gBoss[3]            = cs.gBoss[2]
			cs.gBoss[4].cond       = cs.COND_ALIVE | cs.COND_ZEROINDEXDAMAGE
			cs.gBoss[4].bits       = cs.gBoss[4].bits | cs.BITS_BANISH_DAMAGE
			cs.gBoss[4].hit.front  =  6 * cs.VS
			cs.gBoss[4].hit.back   =  6 * cs.VS
			cs.gBoss[4].hit.top    =  8 * cs.VS
			cs.gBoss[4].hit.bottom =  8 * cs.VS
			cs.SetNpChar(325, npc.x, npc.y + 60 * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end

		if npc.count2 > 1 and npc.life < npc.count2 * cs.bossHPMultiply(70) then
			npc.count2 = npc.count2 - 1
			for i = 0, 4 do
				cs.ChangeMapParts(11 + i, npc.count2, 0)
				cs.SetDestroyNpChar((11 + i) * cs.VS * cs.PARTSSIZE, npc.count2 * cs.VS * cs.PARTSSIZE, 0, 4)
				cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			end
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait == 81 or npc.act_wait == 241 then
			cs.SetNpChar(323,  6 * cs.PARTSSIZE * cs.VS, 15 * cs.PARTSSIZE * cs.VS, 0, 0, cs.DIR_UP, nil, cs.div(cs.MAX_NPC, 2))
		end
		if npc.act_wait == 1 or npc.act_wait == 161 then
			cs.SetNpChar(323, 20 * cs.PARTSSIZE * cs.VS, 15 * cs.PARTSSIZE * cs.VS, 0, 0, cs.DIR_UP, nil, cs.div(cs.MAX_NPC, 2))
		end
		if npc.act_wait >= 300 then
			npc.act_wait = 0
			cs.SetNpChar(325, npc.x, npc.y + 60 * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end
	elseif npc.act_no == 500 or npc.act_no == 501 then
		if npc.act_no == 500 then
			cs.gBoss[4].bits = cs.gBoss[4].bits & ~cs.BITS_BANISH_DAMAGE
			npc.act_no       = 501
			npc.act_wait     =   0
			npc.count1       =   0
			cs.DeleteNpCharCode(325, true)
			cs.DeleteNpCharCode(330, true)
		end
		npc.act_wait = npc.act_wait + 1
		if cs.mod(npc.act_wait, 16) == 0 then
			cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			cs.SetDestroyNpChar(npc.x + cs.Random(-40, 40) * cs.VS,
			                    npc.y + cs.Random(-60, 60) * cs.VS, 1, 1)
		end
		if npc.act_wait == 95 then
			npc.ani_no = 1
		end
		if npc.act_wait == 98 then
			npc.ani_no = 2
		end
		if npc.act_wait > 100 then
			npc.act_no = 510
		end
	elseif npc.act_no == 510 then
		npc.ym     = npc.ym + cs.div(cs.VS, 8)
		npc.damage = 127
		npc.y      = npc.y + npc.ym
		if npc.count1 == 0 and npc.y > 10 * cs.VS * cs.PARTSSIZE then
			npc.count1 =      1
			npc.ym     = -cs.VS
			npc.damage =      0
			for i = 0, 6 do
				cs.ChangeMapParts(10 + i, 14, 0)
				cs.SetDestroyNpChar((10 + i) * cs.VS * cs.PARTSSIZE, 14 * cs.VS * cs.PARTSSIZE, 0, 0)
				cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			end
		end
		if npc.y > 30 * cs.VS * cs.PARTSSIZE then
			npc.act_no = 520
		end
	elseif npc.act_no == 520 then
		
	end

	cs.gBoss[2].x = npc.x - 24 * cs.VS
	cs.gBoss[2].y = npc.y + 52 * cs.VS
	cs.gBoss[3].x = npc.x + 24 * cs.VS
	cs.gBoss[3].y = npc.y + 52 * cs.VS
	cs.gBoss[4].x = npc.x
	cs.gBoss[4].y = npc.y + 40 * cs.VS

	local rc = {
		{left =   0, top =   0, right =  80, bottom = 120},
		{left =  80, top =   0, right = 160, bottom = 120},
		{left = 160, top =   0, right = 240, bottom = 120},
	}

	local rcDamage = {
		{left =   0, top = 120, right =  80, bottom = 240},
		{left =  80, top = 120, right = 160, bottom = 240},
		{left = 160, top = 120, right = 240, bottom = 240},
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

return ActBossChar_Press
