local function ActBossChar03_01(npc)
	local rcUp = {
		{left =   0, top =   0, right =  72, bottom =  32},
		{left =   0, top =  32, right =  72, bottom =  64},
		{left =  72, top =   0, right = 144, bottom =  32},
		{left = 144, top =   0, right = 216, bottom =  32},
		{left =  72, top =  32, right = 144, bottom =  64},
		{left = 144, top =  32, right = 216, bottom =  64},
	}
	local rcDown = {
		{left =   0, top =  64, right =  72, bottom =  96},
		{left =   0, top =  96, right =  72, bottom = 128},
		{left =  72, top =  64, right = 144, bottom =  96},
		{left = 144, top =  64, right = 216, bottom =  96},
		{left =  72, top =  96, right = 144, bottom = 128},
		{left = 144, top =  96, right = 216, bottom = 128},
	}

	if npc.act_no == 10 then
		npc.ani_no = 0
		npc.bits   = npc.bits & ~cs.BITS_BOUND_MYCHAR
	elseif npc.act_no == 100 or npc.act_no == 101 then
		if npc.act_no == 100 then
			npc.bits = npc.bits | cs.BITS_BOUND_MYCHAR
			npc.act_no   = 101
			npc.act_wait =   0
			npc.ani_no   =   2
			npc.ani_wait =   0
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 30 then
			npc.act_no = 102
		end
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 0 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 3 then
			npc.ani_no = 2
		end

		npc.xm = npc.xm - cs.div(cs.VS, 16)
	elseif npc.act_no == 102 or npc.act_no == 103 then
		if npc.act_no == 102 then
			npc.bits = npc.bits & ~cs.BITS_BOUND_MYCHAR
			npc.act_no   = 103
			npc.ani_no   =   0
			npc.ani_wait =   0
		end

		npc.act_wait = npc.act_wait + 1
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 1 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 1 then
			npc.ani_no = 0
		end
		npc.xm = npc.xm - cs.div(cs.VS, 16)
	elseif npc.act_no == 200 or npc.act_no == 201 then
		if npc.act_no == 200 then
			npc.bits = npc.bits | cs.BITS_BOUND_MYCHAR
			npc.bits = npc.bits | cs.BITS_DAMAGE_SIDE
			npc.act_no   = 201
			npc.act_wait =   0
			npc.ani_no   =   4
			npc.ani_wait =   0
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 30 then
			npc.act_no = 202
		end
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 0 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 5 then
			npc.ani_no = 4
		end
		npc.xm = npc.xm + cs.div(cs.VS, 16)
	elseif npc.act_no == 202 or npc.act_no == 203 then
		if npc.act_no == 202 then
			npc.bits = npc.bits & ~cs.BITS_BOUND_MYCHAR
			npc.act_no   = 203
			npc.ani_no   =   0
			npc.ani_wait =   0
		end

		npc.act_wait = npc.act_wait + 1
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 1 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 1 then
			npc.ani_no = 0
		end
		npc.xm = npc.xm + cs.div(cs.VS, 16)
	elseif npc.act_no == 300 or npc.act_no == 301 then
		if npc.act_no == 300 then
			npc.act_no   = 301
			npc.ani_no   =   4
			npc.ani_wait =   0
			npc.bits = npc.bits | cs.BITS_BOUND_MYCHAR
		end
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 0 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 5 then
			npc.ani_no = 4
		end
		npc.xm = npc.xm + cs.div(cs.VS, 16)
		if npc.xm > 0 then
			npc.xm = 0
			npc.act_no = 10
		end
	elseif npc.act_no == 400 or npc.act_no == 401 then
		if npc.act_no == 400 then
			npc.act_no = 401
			npc.ani_no = 2
			npc.ani_wait = 0
			npc.bits = npc.bits | cs.BITS_BOUND_MYCHAR
		end
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 0 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 3 then
			npc.ani_no = 2
		end

		npc.xm = npc.xm - cs.div(cs.VS, 16)
		if npc.xm < 0 then
			npc.xm     = 0
			npc.act_no = 10
		end
	end

	if npc.act_no == 101 or npc.act_no == 201 or npc.act_no == 301 or npc.act_no == 401 then
		if cs.mod(npc.act_wait, 2) == 1 then
			cs.PlaySoundObject(cs.WAVE_CATA2, 1)
		end
	end
	if npc.act_no == 103 or npc.act_no == 203 then
		if cs.mod(npc.act_wait, 4) == 1 then
			cs.PlaySoundObject(cs.WAVE_CATA, 1)
		end
	end

	npc.damage = 0
	npc.bits = npc.bits & ~cs.BITS_DAMAGE_SIDE
	for mc_no = 0, cs.gNumMyChar - 1 do
		npc.damage_mc[1 + mc_no] = 0
		npc.bits_mc[1 + mc_no] = npc.bits_mc[1 + mc_no] & ~cs.BITS_DAMAGE_SIDE
		if npc.act_no >= 100 and cs.gMC[1 + mc_no].y < npc.y + 4 * cs.VS and cs.gMC[1 + mc_no].y > npc.y - 4 * cs.VS then
			npc.damage_mc[1 + mc_no] = 10
			npc.bits_mc[1 + mc_no] = npc.bits_mc[1 + mc_no] | cs.BITS_DAMAGE_SIDE
		end
	end

	if npc.xm > cs.VS * 2 then
		npc.xm = cs.VS * 2
	end
	if npc.xm < -cs.VS * 2 then
		npc.xm = -cs.VS * 2
	end

	npc.x = npc.x + npc.xm

	if npc.direct == cs.DIR_UP then
		npc.rect = rcUp[  1 + npc.ani_no]
	else
		npc.rect = rcDown[1 + npc.ani_no]
	end
end

local function ActBossChar03_02(npc)
	local rect = {
		{left =   0, top = 128, right =  72, bottom = 160},
		{left =  72, top = 128, right = 144, bottom = 160},
		{left =   0, top = 160, right =  72, bottom = 192},
		{left =  72, top = 160, right = 144, bottom = 192},
	}
	local direct
	local x
	local y

	if npc.act_no == 0 then
		
	elseif npc.act_no == 10 or npc.act_no == 11 then
		if npc.act_no == 10 then
			npc.act_no   = 11
			npc.act_wait = 30 + npc.ani_no * 30
		end
		if npc.act_wait ~= 0 then
			npc.act_wait = npc.act_wait - 1
		else
			if npc.ani_no == 0 then
				direct = 3
				x = -30 * cs.VS
				y =   6 * cs.VS
			elseif npc.ani_no == 1 then
				direct = 2
				x =  30 * cs.VS
				y =   6 * cs.VS
			elseif npc.ani_no == 2 then
				direct = 0
				x = -30 * cs.VS
				y =  -6 * cs.VS
			elseif npc.ani_no == 3 then
				direct = 1
				x =  30 * cs.VS
				y =  -6 * cs.VS
			end
			cs.SetNpChar(158, npc.x + x, npc.y + y, 0, 0, direct, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_POP, 1)
			npc.act_wait = 120
		end
	end

	npc.x = cs.div(cs.gBoss[1].x + cs.gBoss[1 + npc.count1].x, 2)
	npc.y = cs.div(cs.gBoss[1].y + cs.gBoss[1 + npc.count1].y, 2)

	npc.rect = rect[1 + npc.ani_no]
end

local function ActBossChar03_03(npc)
	if npc.act_no == 0 then
		
	elseif npc.act_no == 10 then
		npc.tgt_x = npc.tgt_x + cs.VS
		if npc.tgt_x > 32 * cs.VS then
			npc.tgt_x  = 32 * cs.VS
			npc.act_no = 0

			cs.gBoss[4].act_no = 10
			cs.gBoss[5].act_no = 10
			cs.gBoss[6].act_no = 10
			cs.gBoss[7].act_no = 10
		end
	elseif npc.act_no == 20 then
		npc.tgt_x = npc.tgt_x - cs.VS
		if npc.tgt_x < 0 then
			npc.tgt_x  = 0
			npc.act_no = 0

			cs.gBoss[4].act_no = 0
			cs.gBoss[5].act_no = 0
			cs.gBoss[6].act_no = 0
			cs.gBoss[7].act_no = 0
		end
	elseif npc.act_no == 30 then
		npc.tgt_x = npc.tgt_x + cs.VS
		if npc.tgt_x > 20 * cs.VS then
			npc.tgt_x  = 20 * cs.VS
			npc.act_no = 0

			cs.gBoss[ 8].act_no = 10
			cs.gBoss[14].act_no = 10
			cs.gBoss[15].act_no = 10
			cs.gBoss[16].act_no = 10
			cs.gBoss[17].act_no = 10
		end
	elseif npc.act_no == 40 then
		npc.tgt_x = npc.tgt_x - cs.VS
		if npc.tgt_x < 0 then
			npc.tgt_x  = 0
			npc.act_no = 0

			cs.gBoss[ 8].act_no = 0
			cs.gBoss[14].act_no = 0
			cs.gBoss[15].act_no = 0
			cs.gBoss[16].act_no = 0
			cs.gBoss[17].act_no = 0
		end
	end

	local rcLeft = {left = 216, top =  96, right = 264, bottom = 144}
	local rcRight = {left = 264, top =  96, right = 312, bottom = 144}

	if npc.direct == cs.DIR_LEFT then
		npc.rect = rcLeft
		npc.x = cs.gBoss[1].x - 24 * cs.VS - npc.tgt_x
		npc.y = cs.gBoss[1].y
	else
		npc.rect = rcRight
		npc.x = cs.gBoss[1].x + 24 * cs.VS + npc.tgt_x
		npc.y = cs.gBoss[1].y
	end
end

local function ActBossChar03_04(npc)
	local xm
	local ym
	local deg

	local rect = {
		{left =   0, top = 192, right =  16, bottom = 208},
		{left =  16, top = 192, right =  32, bottom = 208},
		{left =  32, top = 192, right =  48, bottom = 208},
		{left =  48, top = 192, right =  64, bottom = 208},

		{left =   0, top = 208, right =  16, bottom = 224},
		{left =  16, top = 208, right =  32, bottom = 224},
		{left =  32, top = 208, right =  48, bottom = 224},
		{left =  48, top = 208, right =  64, bottom = 224},
	}

	if npc.act_no == 0 then
		npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
		npc.ani_no = 0
	elseif npc.act_no == 10 or npc.act_no == 11 then
		if npc.act_no == 10 then
			npc.act_no = 11
			npc.act_wait = 40 + npc.tgt_x * 10
			npc.bits = npc.bits | cs.BITS_BANISH_DAMAGE
		end

		if npc.act_wait < 16 and cs.mod(cs.div(npc.act_wait, 2), 2) ~= 0 then
			npc.ani_no = 1
		else
			npc.ani_no = 0
		end

		if npc.act_wait ~= 0 then
			npc.act_wait = npc.act_wait - 1
		else
			local mc_no = cs.Random(0, cs.gNumMyChar - 1)
			deg = cs.GetArktan(npc.x - cs.gMC[1 + mc_no].x, npc.y - cs.gMC[1 + mc_no].y)
			deg = deg + cs.Random(-2, 2) & 0xFF

			ym = cs.GetSin(deg) * 3
			xm = cs.GetCos(deg) * 3
			cs.SetNpChar(156, npc.x, npc.y, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_POP, 1)
			npc.act_wait = 40
		end
	end

	if npc.tgt_x == 0 then
		npc.x = cs.gBoss[1].x - cs.VS * 22
		npc.y = cs.gBoss[1].y - cs.VS * 16
	elseif npc.tgt_x == 1 then
		npc.x = cs.gBoss[1].x + cs.VS * 28
		npc.y = cs.gBoss[1].y - cs.VS * 16
	elseif npc.tgt_x == 2 then
		npc.x = cs.gBoss[1].x - cs.VS * 15
		npc.y = cs.gBoss[1].y + cs.VS * 14
	elseif npc.tgt_x == 3 then
		npc.x = cs.gBoss[1].x + cs.VS * 17
		npc.y = cs.gBoss[1].y + cs.VS * 14
	end

	npc.rect = rect[1 + (npc.tgt_x + 4 * npc.ani_no)]
end

local flash = 0

local function ActBossChar03_face(npc)
	local rect = {
		{left = 216, top =   0, right = 320, bottom =  48},
		{left = 216, top =  48, right = 320, bottom =  96},
		{left = 216, top = 144, right = 320, bottom = 192},
	}

	if npc.act_no == 0 then
		cs.gBoss[1].bits = cs.gBoss[1].bits & ~cs.BITS_BANISH_DAMAGE
		npc.ani_no = 0
	elseif npc.act_no == 10 or npc.act_no == 11 then
		if npc.act_no == 10 then
			npc.act_no = 11
			npc.act_wait = 40 + npc.tgt_x * 10
			cs.gBoss[1].bits = cs.gBoss[1].bits | cs.BITS_BANISH_DAMAGE
		end
		if cs.gBoss[1].shock ~= 0 then
			if cs.mod(cs.div(flash, 2), 2) ~= 0 then
				npc.ani_no = 1
			else
				npc.ani_no = 0
			end
			flash = flash + 1
		else
			npc.ani_no = 0
		end
	end
	cs.gBoss[8].x = cs.gBoss[1].x
	cs.gBoss[8].y = cs.gBoss[1].y
	if cs.gBoss[1].act_no <= 10 then
		npc.ani_no = 2
	end
	npc.rect = rect[1 + npc.ani_no]
end

local function ActBossChar_MonstX()
	local npc

	npc = cs.gBoss[1]
	if npc.act_no == 0 then
		npc.life = 1
		npc.x           = -20 * cs.VS * cs.PARTSSIZE
	elseif npc.act_no == 1 or npc.act_no == 2 then
		if npc.act_no == 1 then
			npc.life        = 700
			npc.exp         = 1
			npc.act_no      = 1
			npc.x           = 128 * cs.VS * cs.PARTSSIZE
			npc.y           =  12 * cs.VS * cs.PARTSSIZE + 8 * cs.VS
			npc.hit_voice   = cs.WAVE_NPC_GOHST
			npc.hit.front   = 24 * cs.VS
			npc.hit.top     = 24 * cs.VS
			npc.hit.back    = 24 * cs.VS
			npc.hit.bottom  = 24 * cs.VS
			npc.bits = cs.BITS_THROW_BLOCK | cs.BITS_EVENT_BREAK | cs.BITS_VIEWDAMAGE
			npc.size = cs.NPCSIZE_LARGE

			npc.code_event = 1000
			npc.ani_no = 0

			cs.gBoss[2].cond = cs.COND_ALIVE
			cs.gBoss[2].size        = cs.NPCSIZE_LARGE
			cs.gBoss[2].direct      = cs.DIR_LEFT
			cs.gBoss[2].view.front  = 24 * cs.VS
			cs.gBoss[2].view.top    = 24 * cs.VS
			cs.gBoss[2].view.back   = 24 * cs.VS
			cs.gBoss[2].view.bottom = 24 * cs.VS
			cs.gBoss[2].bits = cs.BITS_THROW_BLOCK

			cs.gBoss[3] = cs.gBoss[2]
			cs.gBoss[3].direct = cs.DIR_RIGHT

			cs.gBoss[4].cond = cs.COND_ALIVE
			cs.gBoss[4].life = 60
			cs.gBoss[4].size          = cs.NPCSIZE_LARGE
			cs.gBoss[4].hit_voice     = cs.WAVE_NPC_GOHST
			cs.gBoss[4].destroy_voice = cs.WAVE_DESTROY_MIDDLE
			cs.gBoss[4].size          = cs.NPCSIZE_MIDDLE
			cs.gBoss[4].view.front  = 8 * cs.VS
			cs.gBoss[4].view.top    = 8 * cs.VS
			cs.gBoss[4].view.back   = 8 * cs.VS
			cs.gBoss[4].view.bottom = 8 * cs.VS
			cs.gBoss[4].hit.front   = cs.VS * 5
			cs.gBoss[4].hit.back    = cs.VS * 5
			cs.gBoss[4].hit.top     = cs.VS * 5
			cs.gBoss[4].hit.bottom  = cs.VS * 5
			cs.gBoss[4].bits = cs.BITS_THROW_BLOCK
			cs.gBoss[4].tgt_x       = 0

			cs.gBoss[5] = cs.gBoss[4]
			cs.gBoss[5].tgt_x       = 1
			cs.gBoss[6] = cs.gBoss[4]
			cs.gBoss[6].tgt_x       = 2
			cs.gBoss[6].life = 100
			cs.gBoss[7] = cs.gBoss[4]
			cs.gBoss[7].tgt_x       = 3
			cs.gBoss[7].life = 100

			cs.gBoss[8].cond = cs.COND_ALIVE
			cs.gBoss[8].x           = 128 * cs.VS * cs.PARTSSIZE
			cs.gBoss[8].y           =  12 * cs.VS * cs.PARTSSIZE + 8 * cs.VS
			cs.gBoss[8].view.front  = 52 * cs.VS
			cs.gBoss[8].view.top    = 24 * cs.VS
			cs.gBoss[8].view.back   = 52 * cs.VS
			cs.gBoss[8].view.bottom = 24 * cs.VS
			cs.gBoss[8].hit_voice   = cs.WAVE_NPC_LARGE
			cs.gBoss[8].hit.front   = 8 * cs.VS
			cs.gBoss[8].hit.top     = 24 * cs.VS
			cs.gBoss[8].hit.back    = 8 * cs.VS
			cs.gBoss[8].hit.bottom  = 16 * cs.VS
			cs.gBoss[8].bits = cs.BITS_THROW_BLOCK
			cs.gBoss[8].size = cs.NPCSIZE_LARGE

			cs.gBoss[8].ani_no = 0

			cs.gBoss[10].cond   = cs.COND_ALIVE
			cs.gBoss[10].act_no = 0
			cs.gBoss[10].direct = cs.DIR_UP
			cs.gBoss[10].x      = 124 * cs.VS * cs.PARTSSIZE
			cs.gBoss[10].y      =   9 * cs.VS * cs.PARTSSIZE
			cs.gBoss[10].view.front  = 36 * cs.VS
			cs.gBoss[10].view.top    =  8 * cs.VS
			cs.gBoss[10].view.back   = 36 * cs.VS
			cs.gBoss[10].view.bottom = 24 * cs.VS
			cs.gBoss[10].hit_voice = cs.WAVE_NPC_LARGE
			cs.gBoss[10].hit.front  = 28 * cs.VS
			cs.gBoss[10].hit.top    =  8 * cs.VS
			cs.gBoss[10].hit.back   = 28 * cs.VS
			cs.gBoss[10].hit.bottom = 16 * cs.VS
			cs.gBoss[10].bits = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_BULLET | cs.BITS_DAMAGE_SIDE
			cs.gBoss[10].size = cs.NPCSIZE_LARGE

			cs.gBoss[11] = cs.gBoss[10]
			cs.gBoss[11].x = 132 * cs.VS * cs.PARTSSIZE

			cs.gBoss[12] = cs.gBoss[10]
			cs.gBoss[12].direct = cs.DIR_DOWN
			cs.gBoss[12].x = 124 * cs.VS * cs.PARTSSIZE
			cs.gBoss[12].y =  16 * cs.VS * cs.PARTSSIZE
			cs.gBoss[12].view.top    = 24 * cs.VS
			cs.gBoss[12].view.bottom =  8 * cs.VS
			cs.gBoss[12].hit.top    = 16 * cs.VS
			cs.gBoss[12].hit.bottom =  8 * cs.VS

			cs.gBoss[13] = cs.gBoss[12]
			cs.gBoss[13].x = 132 * cs.VS * cs.PARTSSIZE

			cs.gBoss[14] = cs.gBoss[10]
			cs.gBoss[14].cond = cs.COND_ALIVE
			cs.gBoss[14].view.top    = 16 * cs.VS
			cs.gBoss[14].view.bottom = 16 * cs.VS
			cs.gBoss[14].view.front  = 30 * cs.VS
			cs.gBoss[14].view.back   = 42 * cs.VS
			cs.gBoss[14].count1 = 9
			cs.gBoss[14].ani_no = 0
			cs.gBoss[14].bits   = cs.BITS_THROW_BLOCK

			cs.gBoss[15] = cs.gBoss[14]
			cs.gBoss[15].view.front  = 42 * cs.VS
			cs.gBoss[15].view.back   = 30 * cs.VS
			cs.gBoss[15].count1 = 10
			cs.gBoss[15].ani_no = 1
			cs.gBoss[15].bits   = cs.BITS_THROW_BLOCK

			cs.gBoss[16] = cs.gBoss[14]
			cs.gBoss[16].view.top    = 16 * cs.VS
			cs.gBoss[16].view.bottom = 16 * cs.VS
			cs.gBoss[16].count1 = 11
			cs.gBoss[16].ani_no = 2
			cs.gBoss[16].bits   = cs.BITS_THROW_BLOCK

			cs.gBoss[17] = cs.gBoss[16]
			cs.gBoss[17].view.front  = 42 * cs.VS
			cs.gBoss[17].view.back   = 30 * cs.VS
			cs.gBoss[17].count1 = 12
			cs.gBoss[17].ani_no = 3
			cs.gBoss[17].bits   = cs.BITS_THROW_BLOCK

			npc.act_no = 2
		end
	elseif npc.act_no == 10 or npc.act_no == 11 then
		if npc.act_no == 10 then
			npc.act_no   = 11
			npc.act_wait =  0
			npc.count1   =  0
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 * 2 then
			npc.act_wait = 0
			if npc.x > cs.gMC[1].x then
				npc.act_no = 100
			else
				npc.act_no = 200
			end
		end
	elseif npc.act_no == 100 or npc.act_no == 101 then
		if npc.act_no == 100 then
			npc.act_wait = 0
			npc.act_no   = 101
			npc.count1   = npc.count1 + 1
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait ==  4 then
			cs.gBoss[10].act_no = 100
		end
		if npc.act_wait ==  8 then
			cs.gBoss[11].act_no = 100
		end
		if npc.act_wait == 10 then
			cs.gBoss[12].act_no = 100
		end
		if npc.act_wait == 12 then
			cs.gBoss[13].act_no = 100
		end

		if npc.act_wait > 120 and npc.count1 > 2 then
			npc.act_no = 300
		end
		if npc.act_wait > 121 then
			local mc_otherside = 0
			for mc_no = 0, cs.gNumMyChar - 1 do
				if cs.gMC[1 + mc_no].x > npc.x then
					mc_otherside = mc_otherside + 1
				end
			end
			if mc_otherside >= cs.gNumMyChar then
				npc.act_no = 200
			end
		end
	elseif npc.act_no == 200 or npc.act_no == 201 then
		if npc.act_no == 200 then
			npc.act_wait = 0
			npc.act_no   = 201
			npc.count1   = npc.count1 + 1
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait ==  4 then
			cs.gBoss[10].act_no = 200
		end
		if npc.act_wait ==  8 then
			cs.gBoss[11].act_no = 200
		end
		if npc.act_wait == 10 then
			cs.gBoss[12].act_no = 200
		end
		if npc.act_wait == 12 then
			cs.gBoss[13].act_no = 200
		end

		if npc.act_wait > 120 and npc.count1 > 2 then
			npc.act_no = 400
		end
		if npc.act_wait > 121 then
			local mc_otherside = 0
			for mc_no = 0, cs.gNumMyChar - 1 do
				if cs.gMC[1 + mc_no].x < npc.x then
					mc_otherside = mc_otherside + 1
				end
			end
			if mc_otherside >= cs.gNumMyChar then
				npc.act_no = 100
			end
		end
	elseif npc.act_no == 300 or npc.act_no == 301 then
		if npc.act_no == 300 then
			npc.act_wait = 0
			npc.act_no   = 301
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait ==  4 then
			cs.gBoss[10].act_no = 300
		end
		if npc.act_wait ==  8 then
			cs.gBoss[11].act_no = 300
		end
		if npc.act_wait == 10 then
			cs.gBoss[12].act_no = 300
		end
		if npc.act_wait == 12 then
			cs.gBoss[13].act_no = 300
		end

		if npc.act_wait > 50 then
			if cs.gBoss[4].cond == 0 and cs.gBoss[5].cond == 0 and cs.gBoss[6].cond == 0 and cs.gBoss[7].cond == 0 then
				npc.act_no = 600
			else
				npc.act_no = 500
			end
		end
	elseif npc.act_no == 400 or npc.act_no == 401 then
		if npc.act_no == 400 then
			npc.act_wait = 0
			npc.act_no   = 401
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait ==  4 then
			cs.gBoss[10].act_no = 400
		end
		if npc.act_wait ==  8 then
			cs.gBoss[11].act_no = 400
		end
		if npc.act_wait == 10 then
			cs.gBoss[12].act_no = 400
		end
		if npc.act_wait == 12 then
			cs.gBoss[13].act_no = 400
		end

		if npc.act_wait > 50 then
			if cs.gBoss[4].cond == 0 and cs.gBoss[5].cond == 0 and cs.gBoss[6].cond == 0 and cs.gBoss[7].cond == 0 then
				npc.act_no = 600
			else
				npc.act_no = 500
			end
		end
	elseif npc.act_no == 500 or npc.act_no == 501 then
		if npc.act_no == 500 then
			npc.act_no   = 501
			npc.act_wait =  0
			cs.gBoss[2].act_no = 10
			cs.gBoss[3].act_no = 10
		end

		npc.act_wait = npc.act_wait + 1

		if npc.act_wait > 300 then
			npc.act_no = 502
			npc.act_wait = 0
		end
		if cs.gBoss[4].cond == 0 and cs.gBoss[5].cond == 0 and cs.gBoss[6].cond == 0 and cs.gBoss[7].cond == 0 then
			npc.act_no = 502
			npc.act_wait = 0
		end
	elseif npc.act_no == 502 or npc.act_no == 503 then
		if npc.act_no == 502 then
			npc.act_no   = 503
			npc.act_wait =  0
			npc.count1   =  0
			cs.gBoss[2].act_no = 20
			cs.gBoss[3].act_no = 20
		end

		npc.act_wait = npc.act_wait + 1

		if npc.act_wait > 50 then
			if npc.x > cs.gMC[1 + npc.tgt_mc].x then
				npc.act_no = 100
			else
				npc.act_no = 200
			end
		end
	elseif npc.act_no == 600 or npc.act_no == 601 then
		if npc.act_no == 600 then
			npc.act_no   = 601
			npc.act_wait =  0
			npc.count2   = npc.life
			cs.gBoss[2].act_no  = 30
			cs.gBoss[3].act_no  = 30
		end

		npc.act_wait = npc.act_wait + 1

		if npc.life < npc.count2 - cs.bossHPMultiply(200) or npc.act_wait > 300 then
			npc.act_no = 602
			npc.act_wait = 0
		end
	elseif npc.act_no == 602 or npc.act_no == 603 then
		if npc.act_no == 602 then
			npc.act_no   = 603
			npc.act_wait =  0
			npc.count1   =  0
			cs.gBoss[2].act_no = 40
			cs.gBoss[3].act_no = 40
		end

		npc.act_wait = npc.act_wait + 1

		if npc.act_wait > 50 then
			if npc.x > cs.gMC[1 + npc.tgt_mc].x then
				npc.act_no = 100
			else
				npc.act_no = 200
			end
		end
	elseif npc.act_no == 1000 then
		cs.SetQuake(2)
		npc.act_wait = npc.act_wait + 1
		if cs.mod(npc.act_wait, 8) == 0 then
			cs.PlaySoundObject(cs.WAVE_NPC_LARGE, 1)
		end
		cs.SetDestroyNpChar(npc.x + cs.Random(-72, 72) * cs.VS, npc.y + cs.Random(-64, 64) * cs.VS, 1, 1)
		if npc.act_wait > 50 * 2 then
			npc.act_wait =  0
			npc.act_no   = 1001
			cs.SetFlash(npc.x, npc.y, cs.FLASHMODE_EXPLOSION)
			cs.PlaySoundObject(cs.WAVE_EXPLOSION, 1)
		end
	elseif npc.act_no == 1001 then
		cs.SetQuake(40)
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 then
			for i = 0, cs.MAX_BOSS_PARTS - 1 do
				cs.gBoss[1 + i].cond = 0
			end
			cs.DeleteNpCharCode(158, true)
			cs.SetNpChar(159, npc.x, npc.y - cs.VS * 24, 0, 0, cs.DIR_LEFT, nil, 0)
		end
	end

	ActBossChar03_01(cs.gBoss[10])
	ActBossChar03_01(cs.gBoss[11])
	ActBossChar03_01(cs.gBoss[12])
	ActBossChar03_01(cs.gBoss[13])

	npc.x = npc.x + cs.div(cs.div(cs.gBoss[10].x + cs.gBoss[11].x + cs.gBoss[12].x + cs.gBoss[13].x, 4) - npc.x, 16)
	ActBossChar03_face(cs.gBoss[8])

	ActBossChar03_02(cs.gBoss[14])
	ActBossChar03_02(cs.gBoss[15])
	ActBossChar03_02(cs.gBoss[16])
	ActBossChar03_02(cs.gBoss[17])

	ActBossChar03_03(cs.gBoss[2])
	ActBossChar03_03(cs.gBoss[3])

	if cs.gBoss[4].cond ~= 0 then
		ActBossChar03_04(cs.gBoss[4])
	end
	if cs.gBoss[5].cond ~= 0 then
		ActBossChar03_04(cs.gBoss[5])
	end
	if cs.gBoss[6].cond ~= 0 then
		ActBossChar03_04(cs.gBoss[6])
	end
	if cs.gBoss[7].cond ~= 0 then
		ActBossChar03_04(cs.gBoss[7])
	end

	if npc.life == 0 and npc.act_no < 1000 then
		npc.act_no = 1000
		npc.act_wait = 0
		npc.shock   = 50 * 3
		cs.gBoss[10].act_no = 300
		cs.gBoss[11].act_no = 300
		cs.gBoss[12].act_no = 300
		cs.gBoss[13].act_no = 300
	end
end

return ActBossChar_MonstX
