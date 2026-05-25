local function ActBossCharT_DragonBody(npc)
	local deg
	local rcLeft = {
		{left =   0, top =   0, right =  40, bottom =  40},
		{left =  40, top =   0, right =  80, bottom =  40},
		{left =  80, top =   0, right = 120, bottom =  40},
	}
	local rcRight = {
		{left =   0, top =  40, right =  40, bottom =  80},
		{left =  40, top =  40, right =  80, bottom =  80},
		{left =  80, top =  40, right = 120, bottom =  80},
	}

	if npc.act_no == 0 or npc.act_no == 10 then
		if npc.act_no == 0 then
			deg = cs.mod(cs.div(npc.pNpc.count1, 4) + npc.count1, 256)
			npc.act_no = 10
			npc.x = npc.x + (npc.pNpc.x + cs.GetCos(deg) * npc.pNpc.tgt_x)
			npc.y = npc.y + (npc.pNpc.y + cs.GetSin(deg) * npc.pNpc.tgt_y)
			cs.NpCharSetNearestXTargetMC(npc)
		end

		if npc.x > cs.gMC[1 + npc.tgt_mc].x then
			npc.direct = cs.DIR_LEFT
		else
			npc.direct = cs.DIR_RIGHT
		end
	elseif npc.act_no == 100 then
		deg = cs.mod(cs.div(npc.pNpc.count1, 4) + npc.count1, 256)
		npc.tgt_x = npc.pNpc.x + cs.GetCos(deg) * npc.pNpc.tgt_x
		npc.tgt_y = npc.pNpc.y + cs.GetSin(deg) * npc.pNpc.tgt_y
		npc.x = npc.x + cs.div((npc.tgt_x - npc.x) * 1, 8)
		npc.y = npc.y + cs.div((npc.tgt_y - npc.y) * 1, 8)
		if npc.x > cs.gMC[1 + npc.tgt_mc].x then
			npc.direct = cs.DIR_LEFT
		else
			npc.direct = cs.DIR_RIGHT
		end
	elseif npc.act_no == 401 then
		
	elseif npc.act_no == 1000 or npc.act_no == 1001 then
		--やられ
		if npc.act_no == 1000 then
			npc.act_no = 1001
			npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
		end

		deg = cs.mod(cs.div(npc.pNpc.count1, 4) + npc.count1, 256)
		npc.tgt_x = npc.pNpc.x + cs.GetCos(deg) * npc.pNpc.tgt_x
		npc.tgt_y = npc.pNpc.y + cs.GetSin(deg) * npc.pNpc.tgt_y
		npc.x = npc.x + cs.div((npc.tgt_x - npc.x) * 1, 8)
		npc.y = npc.y + cs.div((npc.tgt_y - npc.y) * 1, 8)
		if npc.x > npc.pNpc.x then
			npc.direct = cs.DIR_LEFT
		else
			npc.direct = cs.DIR_RIGHT
		end
	end

	npc.ani_wait = npc.ani_wait + 1
	if npc.ani_wait > 2 then
		npc.ani_wait = 0
		npc.ani_no = npc.ani_no + 1
	end
	if npc.ani_no > 2 then
		npc.ani_no = 0
	end

	if npc.direct == cs.DIR_LEFT then
		npc.rect = rcLeft[ 1 + npc.ani_no]
	else
		npc.rect = rcRight[1 + npc.ani_no]
	end
end

-- head
local function ActBossCharT_DragonHead(npc)
	local deg
	local xm
	local ym
	local rcLeft = {
		{left =   0, top =  80, right =  40, bottom = 112},
		{left =  40, top =  80, right =  80, bottom = 112},
		{left =  80, top =  80, right = 120, bottom = 112},
		{left = 120, top =  80, right = 160, bottom = 112},
	}
	local rcRight = {
		{left =   0, top = 112, right =  40, bottom = 144},
		{left =  40, top = 112, right =  80, bottom = 144},
		{left =  80, top = 112, right = 120, bottom = 144},
		{left = 120, top = 112, right = 160, bottom = 144},
	}

	if npc.act_no == 0 or npc.act_no == 1 then
		if npc.act_no == 0 then
			npc.act_no = 1
		end
		
	elseif npc.act_no == 100 or npc.act_no == 200 or npc.act_no == 201 then
		if npc.act_no == 100 or npc.act_no == 200 then
			if npc.act_no == 100 then
				npc.act_no = 200
			end

			-- 素顔待機
			npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
			npc.ani_no = 0
			npc.hit.front = 16 * cs.VS
			npc.act_no = 201
			npc.count1 = cs.Random(100, 200)
		end

		if npc.count1 ~= 0 then
			npc.count1 = npc.count1 - 1
		else
			npc.act_no   = 210
			npc.act_wait = 0
			npc.count2   = 0
		end
	elseif npc.act_no == 210 then
		--口を開く
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait == 3 then
			npc.ani_no = 1
		end
		if npc.act_wait == 6 then
			npc.ani_no = 2
			npc.hit.front = 8 * cs.VS
			npc.bits = npc.bits | cs.BITS_BANISH_DAMAGE
			npc.count2   = 0
		end
		if npc.act_wait > 150 then
			npc.act_no = 220
			npc.act_wait = 0
			cs.NpCharSetNearestXTargetMC(npc)
		end
		if npc.shock ~= 0 then
			npc.count2 = npc.count2 + 1
		end
		if npc.count2 > 10 then
			-- ギャフン
			cs.PlaySoundObject(cs.WAVE_NPC_MIDDLE, 1)
			cs.SetDestroyNpChar(npc.x, npc.y, npc.view.back, 4)
			npc.act_no   = 300
			npc.act_wait = 0
			npc.ani_no   = 3
			npc.hit.front = 16 * cs.VS
		end
	elseif npc.act_no == 220 then
		-- ファイア
		npc.act_wait = npc.act_wait + 1
		if cs.mod(npc.act_wait, 8) == 1 then
			deg = cs.GetArktan(npc.x - cs.gMC[1 + npc.tgt_mc].x, npc.y - cs.gMC[1 + npc.tgt_mc].y)
			deg = deg + cs.Random(-6, 6) & 0xFF

			ym = cs.GetSin(deg) * 1
			xm = cs.GetCos(deg) * 1
			if npc.direct == cs.DIR_LEFT then
				cs.SetNpChar(202, npc.x - cs.VS * 8, npc.y, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			else
				cs.SetNpChar(202, npc.x + cs.VS * 8, npc.y, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
			cs.PlaySoundObject(cs.WAVE_FRONTIA, 1)
		end

		if npc.act_wait > 50 then
			npc.act_no   = 200
		end
	elseif npc.act_no == 300 then
		-- sleep
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 100 then
			npc.act_no = 200
		end
	elseif npc.act_no == 400 or npc.act_no == 401 then
		-- 突進
		if npc.act_no == 400 then
			npc.act_no = 401
			npc.act_wait = 0
			npc.ani_no = 0
			npc.hit.front = 16 * cs.VS
			npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
			cs.NpCharSetNearestXTargetMC(npc)
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait == 3 then
			npc.ani_no = 1
		end
		if npc.act_wait == 6 then
			npc.ani_no = 2
			npc.hit.front = 8 * cs.VS
			npc.bits = npc.bits | cs.BITS_BANISH_DAMAGE
			npc.count2   = 0
		end
		if npc.act_wait > 20 and cs.mod(npc.act_wait, 32) == 1 then
			deg = cs.GetArktan(npc.x - cs.gMC[1 + npc.tgt_mc].x, npc.y - cs.gMC[1 + npc.tgt_mc].y)
			deg = deg + cs.Random(-6, 6) & 0xFF

			ym = cs.GetSin(deg) * 1
			xm = cs.GetCos(deg) * 1
			if npc.direct == cs.DIR_LEFT then
				cs.SetNpChar(202, npc.x - cs.VS * 8, npc.y, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			else
				cs.SetNpChar(202, npc.x + cs.VS * 8, npc.y, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
			cs.PlaySoundObject(cs.WAVE_FRONTIA, 1)
		end
	elseif npc.act_no == 1000 then
		--やられ
		npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
		npc.ani_no = 3
	end

	npc.direct = npc.pNpc.direct
	if npc.direct == cs.DIR_LEFT then
		npc.x = npc.pNpc.x - 4 * cs.VS
	else
		npc.x = npc.pNpc.x + 4 * cs.VS
	end
	npc.y = npc.pNpc.y - 8 * cs.VS

	if npc.direct == cs.DIR_LEFT then
		npc.rect = rcLeft[ 1 + npc.ani_no]
	else
		npc.rect = rcRight[1 + npc.ani_no]
	end
end

--local _flash = 0

local function ActBossChar_Twin()
	local npc

	npc = cs.gBoss[1]

	if npc.act_no == 0 or npc.act_no == 10 then
		-- 初期設定
		if npc.act_no == 0 then
			npc.cond                = cs.COND_ALIVE
			npc.direct              = cs.DIR_LEFT
			npc.act_no              = 10
			npc.exp                 = 0
			npc.x                   = cs.VS * cs.PARTSSIZE * 10
			npc.y                   = cs.div(cs.VS * cs.PARTSSIZE * 16, 2)
			npc.view.front          = 8 * cs.VS
			npc.view.top            = 8 * cs.VS
			npc.view.back           = 128 * cs.VS
			npc.view.bottom         = 8 * cs.VS
			npc.hit_voice           = cs.WAVE_NPC_GOHST
			npc.hit.front           = 8 * cs.VS
			npc.hit.top             = 8 * cs.VS
			npc.hit.back            = 8 * cs.VS
			npc.hit.bottom          = 8 * cs.VS
			npc.bits                = cs.BITS_THROW_BLOCK
			npc.bits                = npc.bits | cs.BITS_EVENT_BREAK
			npc.size                = cs.NPCSIZE_LARGE
			npc.damage              = 0

			npc.code_event          = 1000
			npc.life                = 500
			npc.count2              = cs.Random(700, 1200)
			npc.tgt_x               = 180
			npc.tgt_y               = 61

			-- head
			cs.gBoss[3].cond        = cs.COND_ALIVE
			cs.gBoss[3].view.back   = 20 * cs.VS
			cs.gBoss[3].view.front  = 20 * cs.VS
			cs.gBoss[3].view.top    = 16 * cs.VS
			cs.gBoss[3].view.bottom = 16 * cs.VS
			cs.gBoss[3].hit.back    = 12 * cs.VS
			cs.gBoss[3].hit.front   = 12 * cs.VS
			cs.gBoss[3].hit.top     = 10 * cs.VS
			cs.gBoss[3].hit.bottom  = 10 * cs.VS
			cs.gBoss[3].bits        = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_BULLET
			cs.gBoss[3].pNpc        = cs.gBoss[4]
			cs.gBoss[3].cond        = cs.gBoss[3].cond | cs.COND_ZEROINDEXDAMAGE
			cs.gBoss[3].damage      = 10

			-- body
			cs.gBoss[4].cond        = cs.COND_ALIVE
			cs.gBoss[4].view.back   = 20 * cs.VS
			cs.gBoss[4].view.front  = 20 * cs.VS
			cs.gBoss[4].view.top    = 20 * cs.VS
			cs.gBoss[4].view.bottom = 20 * cs.VS
			cs.gBoss[4].hit.back    = 12 * cs.VS
			cs.gBoss[4].hit.front   = 12 * cs.VS
			cs.gBoss[4].hit.top     = 2 * cs.VS
			cs.gBoss[4].hit.bottom  = 16 * cs.VS
			cs.gBoss[4].bits        = cs.BITS_THROW_BLOCK -- | cs.BITS_BLOCK_BULLET
			cs.gBoss[4].pNpc        = npc
			cs.gBoss[4].damage      = 10

			cs.gBoss[5]             = cs.gBoss[3]
			cs.gBoss[5].pNpc        = cs.gBoss[6]
			cs.gBoss[6]             = cs.gBoss[4]
			cs.gBoss[6].count1      = 128
		end

		-- 待機
	elseif npc.act_no == 20 then
		-- 出現
		npc.tgt_x = npc.tgt_x - 1
		if npc.tgt_x <= 112 then
			npc.act_no   = 100
			npc.act_wait = 0
			cs.gBoss[3].act_no = 100
			cs.gBoss[5].act_no = 100
			cs.gBoss[4].act_no = 100
			cs.gBoss[6].act_no = 100
			cs.NpCharSetNearestXTargetMC(cs.gBoss[4])
			cs.NpCharSetNearestXTargetMC(cs.gBoss[6])
		end
	elseif npc.act_no == 100 then
		npc.act_wait = npc.act_wait + 1
		if     npc.act_wait < 100 then
			npc.count1 = npc.count1 + 1
		elseif npc.act_wait < 120 then
			npc.count1 = npc.count1 + 2
		elseif npc.act_wait < npc.count2 then
			npc.count1 = npc.count1 + 4
		elseif npc.act_wait < npc.count2 + 40 then
			npc.count1 = npc.count1 + 2
		elseif npc.act_wait < npc.count2 + 60 then
			npc.count1 = npc.count1 + 1
		else
			npc.act_wait = 0
			npc.act_no = 110
			npc.count2 = cs.Random(400, 700)
		end
		if npc.act_no == 100 and npc.count1 > 1023 then
			npc.count1 = npc.count1 - 1024
		end
	elseif npc.act_no == 110 then
		npc.act_wait = npc.act_wait + 1
		if     npc.act_wait < 20 then
			npc.count1 = npc.count1 - 1
		elseif npc.act_wait < 60 then
			npc.count1 = npc.count1 - 2
		elseif npc.act_wait < npc.count2 then
			npc.count1 = npc.count1 - 4
		elseif npc.act_wait < npc.count2 + 40 then
			npc.count1 = npc.count1 - 2
		elseif npc.act_wait < npc.count2 + 60 then
			npc.count1 = npc.count1 - 1
		else
			if npc.life < cs.bossHPMultiply(300) then
				npc.act_wait       = 0
				npc.act_no         = 400
				cs.gBoss[3].act_no = 400
				cs.gBoss[5].act_no = 400
			else
				npc.act_wait = 0
				npc.act_no = 100
				npc.count2 = cs.Random(400, 700)
			end
		end
		if npc.act_no == 110 and npc.count1 <= 0 then
			npc.count1 = npc.count1 + 1024
		end
	elseif npc.act_no == 400 then
		-- スクリュー
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 100 then
			npc.act_wait = 0
			npc.act_no = 401
		end
	elseif npc.act_no == 401 then
		npc.act_wait = npc.act_wait + 1
		if     npc.act_wait < 100 then
			npc.count1 = npc.count1 + 1
		elseif npc.act_wait < 120 then
			npc.count1 = npc.count1 + 2
		elseif npc.act_wait < 500 then
			npc.count1 = npc.count1 + 4
		elseif npc.act_wait < 500 + 40 then
			npc.count1 = npc.count1 + 2
		elseif npc.act_wait < 500 + 60 then
			npc.count1 = npc.count1 + 1
		else
			npc.act_no   = 100
			npc.act_wait = 0
			cs.gBoss[3].act_no = 100
			cs.gBoss[5].act_no = 100
		end
		if npc.act_no == 401 and npc.count1 > 1023 then
			npc.count1 = npc.count1 - 1024
		end
	elseif npc.act_no == 1000 or npc.act_no == 1001 then
		-- やられ
		if npc.act_no == 1000 then
			npc.act_no   = 1001
			npc.act_wait =    0
			cs.gBoss[3].act_no      = 1000
			cs.gBoss[4].act_no      = 1000
			cs.gBoss[5].act_no      = 1000
			cs.gBoss[6].act_no      = 1000
			cs.SetDestroyNpChar(npc.x, npc.y, npc.view.back, 40)
		end

		-- 停止
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 100 then
			npc.act_no = 1010
		end
		cs.SetNpChar(4, npc.x + cs.Random(-128, 128) * cs.VS,
		                npc.y + cs.Random( -70,  70) * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
	elseif npc.act_no == 1010 then
		-- 接近
		npc.count1 = npc.count1 + 4
		if npc.count1 > 1023 then
			npc.count1 = npc.count1 - 1024
		end
		if npc.tgt_x >  8 then
			npc.tgt_x = npc.tgt_x - 1
		end
		if npc.tgt_y >  0 then
			npc.tgt_y = npc.tgt_y - 1
		end
		if npc.tgt_x < -8 then
			npc.tgt_x = npc.tgt_x + 1
		end
		if npc.tgt_y <  0 then
			npc.tgt_y = npc.tgt_y + 1
		end
		if npc.tgt_y == 0 then
			npc.act_no = 1020
			npc.act_wait = 0
			cs.SetFlash(cs.gBoss[1].x, cs.gBoss[1].y, cs.FLASHMODE_EXPLOSION)
			cs.PlaySoundObject(cs.WAVE_EXPLOSION, 1)
		end
	elseif npc.act_no == 1020 then
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait > 50 then
			cs.DeleteNpCharCode(211, true)
			cs.gBoss[1].cond = 0
			cs.gBoss[2].cond = 0
			cs.gBoss[3].cond = 0
			cs.gBoss[4].cond = 0
			cs.gBoss[5].cond = 0
			cs.gBoss[6].cond = 0
			cs.gBoss[1].act_no = 0
		end
	elseif npc.act_no == 1030 then
		
	end

	ActBossCharT_DragonHead(cs.gBoss[3])
	ActBossCharT_DragonBody(cs.gBoss[4])
	ActBossCharT_DragonHead(cs.gBoss[5])
	ActBossCharT_DragonBody(cs.gBoss[6])

	local rc = {left =   0, top =   0, right =   0, bottom =   0}
	npc.rect = rc
end

return ActBossChar_Twin
