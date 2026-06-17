local function ActBossChar_Core_Face(npc)
	local rect = {
		{left =   0, top =   0, right =  72, bottom = 112},
		{left =   0, top = 112, right =  72, bottom = 224},
		{left = 160, top =   0, right = 232, bottom = 112},
		{left =   0, top =   0, right =   0, bottom =   0},
	}

	if npc.act_no == 10 or npc.act_no == 11 then
		if npc.act_no == 10 then
			npc.act_no     = 11
			npc.ani_no     =  2
			npc.bits       = cs.BITS_THROW_BLOCK
			npc.view.front = 36 * cs.VS
			npc.view.top   = 56 * cs.VS
		end

		npc.x          = cs.gBoss[1].x - cs.VS * 36
		npc.y          = cs.gBoss[1].y

	-- フェードアウト
	elseif npc.act_no == 50 or npc.act_no == 51 then
		if npc.act_no == 50 then
			npc.act_no   =  51
			npc.act_wait = 112
		end

		npc.act_wait = npc.act_wait - 1
		if npc.act_wait == 0 then
			npc.act_no = 100
			npc.ani_no = 3
		end
		npc.x          = cs.gBoss[1].x - cs.VS * 36
		npc.y          = cs.gBoss[1].y
	elseif npc.act_no == 100 then
		npc.ani_no = 3
	end

	npc.rect       = rect[1 + npc.ani_no]

	if npc.act_no == 51 then
		npc.rect.bottom = npc.rect.top + npc.act_wait
	end
end

local function ActBossChar_Core_Tail(npc)
	local rect = {
		{left =  72, top =   0, right = 160, bottom = 112},
		{left =  72, top = 112, right = 160, bottom = 224},
		{left =   0, top =   0, right =   0, bottom =   0},
	}

	if npc.act_no == 10 or npc.act_no == 11 then
		if npc.act_no == 10 then
			npc.act_no     = 11
			npc.ani_no     =  0
			npc.bits       = cs.BITS_THROW_BLOCK

			npc.view.front = 44 * cs.VS
			npc.view.top   = 56 * cs.VS
		end

		npc.x          = cs.gBoss[1].x + cs.VS * 44
		npc.y          = cs.gBoss[1].y

	-- フェードアウト
	elseif npc.act_no == 50 or npc.act_no == 51 then
		if npc.act_no == 50 then
			npc.act_no   =  51
			npc.act_wait = 112
		end

		npc.act_wait = npc.act_wait - 1
		if npc.act_wait == 0 then
			npc.act_no = 100
			npc.ani_no = 2
		end
		npc.x          = cs.gBoss[1].x + cs.VS * 44
		npc.y          = cs.gBoss[1].y
	elseif npc.act_no == 100 then
		npc.ani_no = 2
	end

	npc.rect       = rect[1 + npc.ani_no]
	if npc.act_no == 51 then
		npc.rect.bottom = npc.rect.top + npc.act_wait
	end
end

local function ActBossChar_Core_Mini(npc)
	local rect = {
		{left = 256, top =   0, right = 320, bottom =  40},
		{left = 256, top =  40, right = 320, bottom =  80},
		{left = 256, top =  80, right = 320, bottom = 120},
	}

	local xm
	local ym
	local deg

	npc.life = 1000

	if npc.act_no == 0 then
		
	elseif npc.act_no == 10 then
		-- 閉じ待機
		npc.ani_no = 2
		npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
	elseif npc.act_no == 100 or npc.act_no == 101 then
		-- ショック閉じ
		if npc.act_no == 100 then
			npc.act_no   = 101
			npc.ani_no   = 2
			npc.act_wait = 0
			npc.tgt_x  = cs.gBoss[1].x + cs.Random(-128, 32) * cs.VS
			npc.tgt_y  = cs.gBoss[1].y + cs.Random( -64, 64) * cs.VS
			npc.bits = npc.bits | cs.BITS_BANISH_DAMAGE
		end

		npc.x = npc.x + cs.div(npc.tgt_x - npc.x, 16)
		npc.y = npc.y + cs.div(npc.tgt_y - npc.y, 16)
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 then
			npc.ani_no = 0
		end
	elseif npc.act_no == 120 or npc.act_no == 121 then
		-- 点滅
		if npc.act_no == 120 then
			npc.act_no   = 121
			npc.act_wait =   0
		end

		npc.act_wait = npc.act_wait + 1
		if cs.mod(cs.div(npc.act_wait, 2), 2) ~= 0 then
			npc.ani_no = 0
		else
			npc.ani_no = 1
		end
		if npc.act_wait > 20 then
			npc.act_no = 130
		end
	elseif npc.act_no == 130 or npc.act_no == 131 then
		-- 閉じダッシュ
		if npc.act_no == 130 then
			npc.act_no   = 131
			npc.ani_no   =   2
			npc.act_wait =   0
			npc.tgt_x  = npc.x + cs.Random(24, 48) * cs.VS
			npc.tgt_y  = npc.y + cs.Random(-4,  4) * cs.VS
		end

		npc.x = npc.x + cs.div(npc.tgt_x - npc.x, 16)
		npc.y = npc.y + cs.div(npc.tgt_y - npc.y, 16)
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 then
			npc.act_no = 140
			npc.ani_no = 0
		end

		if npc.act_wait == 1 or npc.act_wait == 3 then
			local mc_no = cs.mod(npc.act_wait > 1 and 0 or 1, cs.gNumMyChar)
			deg = cs.GetArktan(npc.x - cs.gMC[1 + mc_no].x, npc.y - cs.gMC[1 + mc_no].y)
			deg = deg + cs.Random(-2, 2) & 0xFF

			ym = cs.GetSin(deg) * 2
			xm = cs.GetCos(deg) * 2
			cs.SetNpChar(178, npc.x, npc.y, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_POP, 1)
		end
	elseif npc.act_no == 140 then
		-- 開き…
		npc.x = npc.x + cs.div(npc.tgt_x - npc.x, 16)
		npc.y = npc.y + cs.div(npc.tgt_y - npc.y, 16)
	elseif npc.act_no == 200 or npc.act_no == 201 then
		-- 撤退
		if npc.act_no == 200 then
			npc.act_no = 201
			npc.ani_no = 2
			npc.xm     = 0
			npc.ym     = 0
		end

		npc.xm = npc.xm + cs.div(cs.VS, 16)
		npc.x = npc.x + npc.xm
		if npc.x > cs.GetMapWidth() * cs.VS * cs.PARTSSIZE + 32 * cs.VS then
			npc.cond = 0
		end
	end

	if npc.shock ~= 0 then
		npc.tgt_x = npc.tgt_x + cs.VS * 2
	end

	npc.rect = rect[1 + npc.ani_no]
end

local function ActBossChar_Core_Hit(npc)
	if npc.count1 == 0 then
		npc.x = cs.gBoss[1].x +  0 * cs.VS
		npc.y = cs.gBoss[1].y - 32 * cs.VS
	elseif npc.count1 == 1 then
		npc.x = cs.gBoss[1].x + 28 * cs.VS
		npc.y = cs.gBoss[1].y +  0 * cs.VS
	elseif npc.count1 == 2 then
		npc.x = cs.gBoss[1].x +  4 * cs.VS
		npc.y = cs.gBoss[1].y + 32 * cs.VS
	elseif npc.count1 == 3 then
		npc.x = cs.gBoss[1].x - 28 * cs.VS
		npc.y = cs.gBoss[1].y +  4 * cs.VS
	end
end

local _flash = 0

local function ActBossChar_Core()
	local npc
	npc = cs.gBoss[1]
	local bShock
	local deg
	local xm
	local ym

	bShock = false

	if npc.act_no == 0 or npc.act_no == 10 then
		if npc.act_no == 0 then
			npc.act_no    = 10
			npc.exp       = 1
			npc.cond      = cs.COND_ALIVE
			npc.bits      = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_BULLET | cs.BITS_VIEWDAMAGE
			npc.life      = 800
--			npc.life      = 1
			npc.hit_voice = cs.WAVE_ALMONDDMG

			npc.x         = cs.VS * cs.PARTSSIZE * 77
			npc.y         = cs.VS * cs.PARTSSIZE * 14
			npc.xm        = 0
			npc.ym        = 0

			npc.code_event          = 1000
			npc.bits                = npc.bits | cs.BITS_EVENT_BREAK

			-- 顔と尻
			cs.gBoss[ 5].cond       = cs.COND_ALIVE
			cs.gBoss[ 5].act_no     = 10
			cs.gBoss[ 6].cond       = cs.COND_ALIVE
			cs.gBoss[ 6].act_no     = 10

			-- HIT
			cs.gBoss[ 9].cond       = cs.COND_ALIVE
			cs.gBoss[ 9].bits       = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_BULLET
			cs.gBoss[ 9].view.front =  0 * cs.VS
			cs.gBoss[ 9].view.top   =  0 * cs.VS
			cs.gBoss[ 9].hit.back   = 40 * cs.VS
			cs.gBoss[ 9].hit.top    = 16 * cs.VS
			cs.gBoss[ 9].hit.bottom = 16 * cs.VS
			cs.gBoss[ 9].count1     = 0

			cs.gBoss[10]            = cs.gBoss[9]
			cs.gBoss[10].hit.back   = 36 * cs.VS
			cs.gBoss[10].hit.top    = 24 * cs.VS
			cs.gBoss[10].hit.bottom = 24 * cs.VS
			cs.gBoss[10].count1     = 1

			cs.gBoss[11]            = cs.gBoss[9]
			cs.gBoss[11].hit.back   = 44 * cs.VS
			cs.gBoss[11].hit.top    = 8 * cs.VS
			cs.gBoss[11].hit.bottom = 8 * cs.VS
			cs.gBoss[11].count1     = 2

			cs.gBoss[12]            = cs.gBoss[9]
			cs.gBoss[12].cond       = cs.gBoss[12].cond | cs.COND_ZEROINDEXDAMAGE
			cs.gBoss[12].hit.back   = 20 * cs.VS
			cs.gBoss[12].hit.top    = 20 * cs.VS
			cs.gBoss[12].hit.bottom = 20 * cs.VS
			cs.gBoss[12].count1     = 3

			-- Mini
			cs.gBoss[2].cond        = cs.COND_ALIVE
			cs.gBoss[2].act_no      = 10
			cs.gBoss[2].bits        = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_BULLET | cs.BITS_BANISH_DAMAGE
			cs.gBoss[2].life        = 1000
			cs.gBoss[2].hit_voice   = cs.WAVE_NPC_GOHST
			cs.gBoss[2].hit.back    = 24 * cs.VS
			cs.gBoss[2].hit.top     = 16 * cs.VS
			cs.gBoss[2].hit.bottom  = 16 * cs.VS
			cs.gBoss[2].view.front  = 32 * cs.VS
			cs.gBoss[2].view.top    = 20 * cs.VS
			cs.gBoss[2].x           = npc.x -  8 * cs.VS
			cs.gBoss[2].y           = npc.y - 64 * cs.VS

			cs.gBoss[3]        = cs.gBoss[2]
			cs.gBoss[3].x      = npc.x + 16 * cs.VS
			cs.gBoss[3].y      = npc.y -  0 * cs.VS
			cs.gBoss[4]        = cs.gBoss[2]
			cs.gBoss[4].x      = npc.x -  8 * cs.VS
			cs.gBoss[4].y      = npc.y + 64 * cs.VS
			cs.gBoss[7]        = cs.gBoss[2]
			cs.gBoss[7].x      = npc.x - 48 * cs.VS
			cs.gBoss[7].y      = npc.y - 32 * cs.VS
			cs.gBoss[8]        = cs.gBoss[2]
			cs.gBoss[8].x      = npc.x - 48 * cs.VS
			cs.gBoss[8].y      = npc.y + 32 * cs.VS
		end
	elseif npc.act_no == 200 or npc.act_no == 201 then
		-- 閉じている ----------
		if npc.act_no == 200 then
			npc.act_no    = 201
			npc.act_wait  = 0
			cs.gBoss[12].bits = cs.gBoss[12].bits & ~cs.BITS_BANISH_DAMAGE
			cs.gSuperYpos = 0
			cs.CutNoise()
			cs.NpCharSetNearestXTargetMC(npc)
		end

		npc.tgt_x = cs.gMC[1 + npc.tgt_mc].x
		npc.tgt_y = cs.gMC[1 + npc.tgt_mc].y
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 * 8 then
			npc.count1 = npc.count1 + 1
			cs.PlaySoundObject(cs.WAVE_COREOPEN, 1)
			if npc.count1 > 3 then
				npc.count1 = 0
				-- 閉じる
				npc.act_no = 220
				cs.gBoss[5].ani_no = 0
				cs.gBoss[6].ani_no = 0
				bShock = true
			else
				-- 開く
				npc.act_no = 210
				cs.gBoss[5].ani_no = 0
				cs.gBoss[6].ani_no = 0
				bShock = true
			end
		end
	elseif npc.act_no == 210 or npc.act_no == 211 then
		-- 開いている ----------
		if npc.act_no == 210 then
			npc.act_no   = 211
			npc.act_wait =   0
			npc.count2   = npc.life
			cs.gBoss[12].bits = cs.gBoss[12].bits | cs.BITS_BANISH_DAMAGE
			cs.NpCharSetNearestXTargetMC(npc)
		end

		npc.tgt_x = cs.gMC[1 + npc.tgt_mc].x
		npc.tgt_y = cs.gMC[1 + npc.tgt_mc].y
		if npc.shock ~= 0 then
			_flash = _flash + 1
			if cs.mod(cs.div(_flash, 2), 2) ~= 0 then
				cs.gBoss[5].ani_no = 0
				cs.gBoss[6].ani_no = 0
			else
				cs.gBoss[5].ani_no = 1
				cs.gBoss[6].ani_no = 1
			end
		else
			cs.gBoss[5].ani_no = 0
			cs.gBoss[6].ani_no = 0
		end
		npc.act_wait = npc.act_wait + 1

		if cs.mod(npc.act_wait, 100) == 1 then
			cs.gCurlyShoot_wait = cs.Random(80, 100)
			cs.gCurlyShoot_x    = cs.gBoss[12].x
			cs.gCurlyShoot_y    = cs.gBoss[12].y
		end

		if npc.act_wait < 50 * 4 and cs.mod(npc.act_wait, 20) == 1 then
			cs.SetNpChar(179, npc.x + cs.Random(-48, -16) * cs.VS, npc.y + cs.Random(-64, 64) * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end
		if npc.act_wait > 50 * 8 or npc.life < npc.count2 - cs.bossHPMultiply(200) then
			-- 閉じる
			npc.act_no = 200
			cs.gBoss[5].ani_no = 2
			cs.gBoss[6].ani_no = 0
			bShock = true
		end
	elseif npc.act_no == 220 or npc.act_no == 221 then
		-- 水流  開いている ----------
		if npc.act_no == 220 then
			npc.act_no    = 221
			npc.act_wait  =   0
			cs.gSuperYpos = 1
			cs.gBoss[12].bits = cs.gBoss[12].bits | cs.BITS_BANISH_DAMAGE
			cs.SetQuake(50 * 2)
			cs.SetNoise(cs.NOISE_RIVER, 1000)
		end

		npc.act_wait = npc.act_wait + 1
		for mc_no = 0, cs.gNumMyChar - 1 do
			cs.SetNpChar(199, cs.gMC[1 + mc_no].x + cs.Random(-50, 150) * cs.VS * 2, cs.gMC[1 + mc_no].y + cs.Random(-160, 160) * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.gMC[1 + mc_no].xm = cs.gMC[1 + mc_no].xm - cs.div(cs.VS, 16)
			cs.gMC[1 + mc_no].cond = cs.gMC[1 + mc_no].cond | cs.COND_FLOW
		end

		if npc.shock ~= 0 then
			_flash = _flash + 1
			if cs.mod(cs.div(_flash, 2), 2) ~= 0 then
				cs.gBoss[5].ani_no = 0
				cs.gBoss[6].ani_no = 0
			else
				cs.gBoss[5].ani_no = 1
				cs.gBoss[6].ani_no = 1
			end
		else
			cs.gBoss[5].ani_no = 0
			cs.gBoss[6].ani_no = 0
		end

		if npc.act_wait == 50 * 6 or npc.act_wait == 50 * 7 or npc.act_wait == 50 * 8 then
			local mc_no = cs.Random(0, cs.gNumMyChar - 1)
			deg = cs.GetArktan(npc.x - cs.gMC[1 + mc_no].x, npc.y - cs.gMC[1 + mc_no].y)
			ym = cs.GetSin(deg) * 3
			xm = cs.GetCos(deg) * 3
			cs.SetNpChar(218, npc.x - 40 * cs.VS, npc.y, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_THUNDER, 1)
		end

		if npc.act_wait > 50 * 8 then
			-- 閉じる
			npc.act_no = 200
			cs.gBoss[5].ani_no = 2
			cs.gBoss[6].ani_no = 0
			bShock = true
		end
	elseif npc.act_no == 500 or npc.act_no == 501 then
		-- 煙を吹く
		if npc.act_no == 500 then
			cs.CutNoise()
			npc.act_no         = 501
			npc.act_wait       =   0
			npc.xm             =   0
			npc.ym             =   0
			cs.gBoss[5].ani_no =   2
			cs.gBoss[6].ani_no =   0
			cs.gBoss[2].act_no = 200
			cs.gBoss[3].act_no = 200
			cs.gBoss[4].act_no = 200
			cs.gBoss[7].act_no = 200
			cs.gBoss[8].act_no = 200
			cs.SetQuake(20)
			for i = 0, 31 do
				cs.SetNpChar(4,
					npc.x + cs.Random(-128, 128) * cs.VS,
					npc.y + cs.Random( -64,  64) * cs.VS,
					cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
					cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
					cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
			for i = 0, 11 do
				cs.gBoss[1 + i].bits = cs.gBoss[1 + i].bits & ~(cs.BITS_BLOCK_BULLET | cs.BITS_BANISH_DAMAGE)
			end
		end
		npc.act_wait = npc.act_wait + 1
		if cs.mod(npc.act_wait, 16) ~= 0 then
			cs.SetNpChar(4,
				npc.x + cs.Random(-64, 64) * cs.VS,
				npc.y + cs.Random(-32, 32) * cs.VS,
				cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
				cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
				cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end
		if cs.mod(cs.div(npc.act_wait, 2), 2) ~= 0 then
			npc.x = npc.x - cs.VS
		else
			npc.x = npc.x + cs.VS
		end

		if npc.x < 63 * cs.VS * cs.PARTSSIZE then
			npc.x = npc.x + cs.div(cs.VS, 4)
		else
			npc.x = npc.x - cs.div(cs.VS, 4)
		end
		if npc.y < 11 * cs.VS * cs.PARTSSIZE then
			npc.y = npc.y + cs.div(cs.VS, 4)
		else
			npc.y = npc.y - cs.div(cs.VS, 4)
		end
	elseif npc.act_no == 600 or npc.act_no == 601 then
		-- フェードアウト
		if npc.act_no == 600 then
			npc.act_no = 601
			cs.gBoss[5].act_no = 50
			cs.gBoss[6].act_no = 50

			cs.gBoss[ 9].bits = cs.gBoss[ 9].bits & ~cs.BITS_BLOCK_BULLET
			cs.gBoss[10].bits = cs.gBoss[10].bits & ~cs.BITS_BLOCK_BULLET
			cs.gBoss[11].bits = cs.gBoss[11].bits & ~cs.BITS_BLOCK_BULLET
			cs.gBoss[12].bits = cs.gBoss[12].bits & ~cs.BITS_BLOCK_BULLET
		end
		npc.act_wait = npc.act_wait + 1
		if cs.mod(cs.div(npc.act_wait, 2), 2) ~= 0 then
			npc.x = npc.x - cs.VS * 4
		else
			npc.x = npc.x + cs.VS * 4
		end
	end

	if bShock then
		cs.SetQuake(20)
		cs.gBoss[2].act_no = 100
		cs.gBoss[3].act_no = 100
		cs.gBoss[4].act_no = 100
		cs.gBoss[7].act_no = 100
		cs.gBoss[8].act_no = 100
		cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		for i = 0, 7 do
			cs.SetNpChar(4,
				cs.gBoss[5].x + cs.Random(-32, 16) * cs.VS, cs.gBoss[5].y,
				cs.Random(-cs.VS, cs.VS),
				cs.Random(cs.div(-cs.VS, 2), cs.div(cs.VS, 2)), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end
	end

	if npc.act_no >= 200 and npc.act_no < 300 then
		if npc.act_wait == 30 * 1 + 50 then
			cs.gBoss[2].act_no = 120
		elseif npc.act_wait == 30 * 2 + 50 then
			cs.gBoss[3].act_no = 120
		elseif npc.act_wait == 30 * 3 + 50 then
			cs.gBoss[4].act_no = 120
		elseif npc.act_wait == 30 * 4 + 50 then
			cs.gBoss[7].act_no = 120
		elseif npc.act_wait == 30 * 5 + 50 then
			cs.gBoss[8].act_no = 120
		end

		if npc.x < npc.tgt_x + cs.VS * cs.PARTSSIZE * 10 then
			npc.xm = npc.xm + cs.div(cs.VS, 128)
		end
		if npc.x > npc.tgt_x + cs.VS * cs.PARTSSIZE * 10 then
			npc.xm = npc.xm - cs.div(cs.VS, 128)
		end
		if npc.y < npc.tgt_y + cs.VS * cs.PARTSSIZE * 0 then
			npc.ym = npc.ym + cs.div(cs.VS, 128)
		end
		if npc.y > npc.tgt_y + cs.VS * cs.PARTSSIZE * 0 then
			npc.ym = npc.ym - cs.div(cs.VS, 128)
		end
	end

	if npc.xm > cs.div(cs.VS, 4) then
		npc.xm = cs.div(cs.VS, 4)
	end
	if npc.xm < cs.div(-cs.VS, 4) then
		npc.xm = cs.div(-cs.VS, 4)
	end
	if npc.ym > cs.div(cs.VS, 4) then
		npc.ym = cs.div(cs.VS, 4)
	end
	if npc.ym < cs.div(-cs.VS, 4) then
		npc.ym = cs.div(-cs.VS, 4)
	end
	npc.x = npc.x + npc.xm
	npc.y = npc.y + npc.ym

	ActBossChar_Core_Face(cs.gBoss[5])
	ActBossChar_Core_Tail(cs.gBoss[6])

	ActBossChar_Core_Mini(cs.gBoss[2])
	ActBossChar_Core_Mini(cs.gBoss[3])
	ActBossChar_Core_Mini(cs.gBoss[4])
	ActBossChar_Core_Mini(cs.gBoss[7])
	ActBossChar_Core_Mini(cs.gBoss[8])

	ActBossChar_Core_Hit(cs.gBoss[9])
	ActBossChar_Core_Hit(cs.gBoss[10])
	ActBossChar_Core_Hit(cs.gBoss[11])
	ActBossChar_Core_Hit(cs.gBoss[12])
end

return ActBossChar_Core
