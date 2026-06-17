local function _ActBossCharA_Head(npc)
	local rect = {
		{left =   0, top =   0, right =  72, bottom = 112},
		{left =   0, top = 112, right =  72, bottom = 224}, -- ダメージ
		{left = 160, top =   0, right = 232, bottom = 112}, -- 閉じ
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

		npc.x = cs.gBoss[1].x - cs.VS * 36
		npc.y = cs.gBoss[1].y

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
	elseif npc.act_no == 100 then
		npc.ani_no = 3
	end

	npc.rect       = rect[1 + npc.ani_no]

	if npc.act_no == 51 then
		npc.rect.bottom = npc.rect.top + npc.act_wait
	end
end

-- 尻
local function _ActBossCharA_Tail(npc)
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
	elseif npc.act_no == 100 then
		npc.ani_no = 2
	end

	npc.rect       = rect[1 + npc.ani_no]
	if npc.act_no == 51 then
		npc.rect.bottom = npc.rect.top + npc.act_wait
	end
end

--顔
local function _ActBossCharA_Face(npc)
	local rect = {
		{left =   0, top =   0, right =   0, bottom =   0},
		{left = 160, top = 112, right = 232, bottom = 152},
		{left = 160, top = 152, right = 232, bottom = 192},
		{left = 160, top = 192, right = 232, bottom = 232},
		{left = 248, top = 160, right = 320, bottom = 200},
	}

	if npc.act_no == 0 then
		npc.ani_no = 0
	elseif npc.act_no == 10 then
		-- 顔
		npc.ani_no = 1
	elseif npc.act_no == 20 then
		-- 歯
		npc.ani_no = 2
	elseif npc.act_no == 30 or npc.act_no == 31 then
		-- 唇
		if npc.act_no == 30 then
			npc.act_no = 31
			npc.ani_no = 3
			npc.act_wait = 50 * 2
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 * 6 then
			npc.act_wait = 0
		end
		if npc.act_wait > 50 * 5 and cs.mod(npc.act_wait, 16) == 1 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		end
		if npc.act_wait > 50 * 5 and cs.mod(npc.act_wait, 16) == 7 then
			cs.SetNpChar(293, npc.x, npc.y, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 4))
			cs.PlaySoundObject(cs.WAVE_THUNDER, 1)
		end
		if npc.act_wait == 50 * 4 then
			cs.PlaySoundObject(cs.WAVE_COREPOW, 1)
		end
		if npc.act_wait > 50 * 4 and cs.mod(npc.act_wait, 2) ~= 0 then
			npc.ani_no = 4
		else
			npc.ani_no = 3
		end
	end

	npc.view.back  = 36 * cs.VS
	npc.view.front = 36 * cs.VS
	npc.view.top   = 20 * cs.VS

	npc.x = cs.gBoss[1].x - 36 * cs.VS
	npc.y = cs.gBoss[1].y +  4 * cs.VS
	npc.bits       = cs.BITS_THROW_BLOCK

	npc.rect = rect[1 + npc.ani_no]
end

-- サブ
local function _ActBossCharA_Mini(npc)
	local rect = {
		{left = 256, top =   0, right = 320, bottom =  40},
		{left = 256, top =  40, right = 320, bottom =  80},
		{left = 256, top =  80, right = 320, bottom = 120}, --閉じ
	}

	if npc.cond == 0 then
		return
	end

--	local xm, ym
--	local deg
	local deg

	npc.life = 1000

	if npc.act_no == 0 then
		npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
	elseif npc.act_no == 5 then
		-- 閉じ(スロー回転)
		npc.ani_no = 0
		npc.bits   = npc.bits & ~cs.BITS_BANISH_DAMAGE
		npc.count2 = npc.count2 + 1
		npc.count2 = cs.mod(npc.count2, 256)
	elseif npc.act_no == 10 then
		-- 閉じ
		npc.ani_no = 0
		npc.bits   = npc.bits & ~cs.BITS_BANISH_DAMAGE
		npc.count2 = npc.count2 + 2
		npc.count2 = cs.mod(npc.count2, 256)
	elseif npc.act_no == 20 then
		-- 開き
		npc.ani_no = 1
		npc.bits   = npc.bits & ~cs.BITS_BANISH_DAMAGE
		npc.count2 = npc.count2 + 2
		npc.count2 = cs.mod(npc.count2, 256)
	elseif npc.act_no == 30 then
		-- 閉じ(高速)
		npc.ani_no = 0
		npc.bits   = npc.bits & ~cs.BITS_BANISH_DAMAGE
		npc.count2 = npc.count2 + 4
		npc.count2 = cs.mod(npc.count2, 256)
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

	if npc.act_no < 50 then
		if npc.count1 ~= 0 then
			deg = 128 + npc.count2
		else
			deg = 384 + npc.count2
		end
		npc.x = npc.pNpc.x - 8 * cs.VS + cs.GetCos(cs.div(deg, 2) & 0xFF) * 48
		npc.y = npc.pNpc.y             + cs.GetSin(cs.div(deg, 2) & 0xFF) * 80
	end

	npc.rect = rect[1 + npc.ani_no]
end

-- 当たり判定
local function _ActBossCharA_Hit(npc)
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
local _life = 0

local function ActBossChar_Undead()
	local npc
	npc = cs.gBoss[1]
	local bShock
	local x
	local y

	bShock = false

	if npc.act_no == 0 then
		
	elseif npc.act_no == 1 or npc.act_no == 10 then
		if npc.act_no == 1 then
			npc.act_no              = 10
			npc.exp                 = 1
			npc.cond                = cs.COND_ALIVE
			npc.bits                = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_BULLET | cs.BITS_VIEWDAMAGE
--			npc.life                = 10
			npc.life                = 1000
			npc.hit_voice           = cs.WAVE_ALMONDDMG

			npc.x                   = cs.VS * cs.PARTSSIZE * 37
			npc.y                   = cs.VS * cs.PARTSSIZE *  7 + cs.div(cs.VS * cs.PARTSSIZE, 2)
			npc.xm                  = 0
			npc.ym                  = 0

			npc.code_event          = 1000
			npc.bits                = npc.bits | cs.BITS_EVENT_BREAK

			-- 顔と尻
			cs.gBoss[ 4].cond        = cs.COND_ALIVE
			cs.gBoss[ 4].act_no      =  0
			cs.gBoss[ 5].cond        = cs.COND_ALIVE
			cs.gBoss[ 5].act_no      = 10
			cs.gBoss[ 6].cond        = cs.COND_ALIVE
			cs.gBoss[ 6].act_no      = 10

			-- HIT
			cs.gBoss[ 9].cond        = cs.COND_ALIVE
			cs.gBoss[ 9].bits        = cs.BITS_THROW_BLOCK
			cs.gBoss[ 9].view.front  =  0 * cs.VS
			cs.gBoss[ 9].view.top    =  0 * cs.VS
			cs.gBoss[ 9].hit.back    = 40 * cs.VS
			cs.gBoss[ 9].hit.top     = 16 * cs.VS
			cs.gBoss[ 9].hit.bottom  = 16 * cs.VS
			cs.gBoss[ 9].count1      =  0

			cs.gBoss[10]            = cs.gBoss[9]
			cs.gBoss[10].hit.back   = 36 * cs.VS
			cs.gBoss[10].hit.top    = 24 * cs.VS
			cs.gBoss[10].hit.bottom = 24 * cs.VS
			cs.gBoss[10].count1     =  1

			cs.gBoss[11]            = cs.gBoss[9]
			cs.gBoss[11].hit.back   = 44 * cs.VS
			cs.gBoss[11].hit.top    =  8 * cs.VS
			cs.gBoss[11].hit.bottom =  8 * cs.VS
			cs.gBoss[11].count1     =  2

			cs.gBoss[12]            = cs.gBoss[9]
			cs.gBoss[12].cond       = cs.gBoss[12].cond | cs.COND_ZEROINDEXDAMAGE
			cs.gBoss[12].hit.back   = 20 * cs.VS
			cs.gBoss[12].hit.top    = 20 * cs.VS
			cs.gBoss[12].hit.bottom = 20 * cs.VS
			cs.gBoss[12].count1     =  3

			-- Mini
			cs.gBoss[2].cond        = cs.COND_ALIVE
			cs.gBoss[2].act_no      = 0
			cs.gBoss[2].bits        = cs.BITS_THROW_BLOCK | cs.BITS_BANISH_DAMAGE -- | BITS_BLOCK_BULLET
			cs.gBoss[2].life        = 1000
			cs.gBoss[2].hit_voice   = cs.WAVE_NPC_GOHST
			cs.gBoss[2].hit.back    = 24 * cs.VS
			cs.gBoss[2].hit.top     = 16 * cs.VS
			cs.gBoss[2].hit.bottom  = 16 * cs.VS
			cs.gBoss[2].view.front  = 32 * cs.VS
			cs.gBoss[2].view.top    = 20 * cs.VS
			cs.gBoss[2].pNpc        = npc

			cs.gBoss[3]             = cs.gBoss[2]
			cs.gBoss[3].count2      = 128

			cs.gBoss[7]             = cs.gBoss[2]
			cs.gBoss[7].count1      =   1

			cs.gBoss[8]             = cs.gBoss[2]
			cs.gBoss[8].count1      =   1
			cs.gBoss[8].count2      = 128

			_life = npc.life
		end
		
	elseif npc.act_no == 15 or npc.act_no == 16 then
		-- イベント開き
		if npc.act_no == 15 then
			npc.act_no = 16
--			npc.act_no        = 210
			bShock            = true
			npc.direct        = cs.DIR_LEFT
			cs.gBoss[4].act_no =  10
			cs.gBoss[5].ani_no =   0
		end
	elseif npc.act_no == 20 then
		npc.act_no         = 210
		bShock             = true
		npc.direct         = cs.DIR_LEFT
		cs.gBoss[2].act_no = 5
		cs.gBoss[3].act_no = 5
		cs.gBoss[7].act_no = 5
		cs.gBoss[8].act_no = 5
	elseif npc.act_no == 200 or npc.act_no == 201 then
		-- 閉じている ----------
		if npc.act_no == 200 then
			npc.act_no          = 201
			npc.act_wait        =   0
			cs.gBoss[ 4].act_no =   0
			cs.gBoss[ 5].ani_no =   2
			cs.gBoss[ 6].ani_no =   0
			cs.gBoss[ 9].bits = cs.gBoss[ 9].bits & ~cs.BITS_BLOCK_BULLET
			cs.gBoss[10].bits = cs.gBoss[10].bits & ~cs.BITS_BLOCK_BULLET
			cs.gBoss[11].bits = cs.gBoss[11].bits & ~cs.BITS_BLOCK_BULLET
			cs.gBoss[12].bits = cs.gBoss[12].bits & ~cs.BITS_BANISH_DAMAGE
			cs.gSuperYpos     = 0
				bShock    = true
		end

--		npc.tgt_x = cs.gMC[1].x
--		npc.tgt_y = cs.gMC[1].y
		npc.act_wait = npc.act_wait + 1

		local lowHPCheck = cs.bossHPMultiply(200)
		if npc.direct == cs.DIR_RIGHT or npc.ani_no > 0 or npc.life < lowHPCheck then
			if npc.act_wait > 50 * 4 then
				npc.count1 = npc.count1 + 1
				cs.PlaySoundObject(cs.WAVE_COREOPEN, 1)
				if npc.life < lowHPCheck then
					npc.act_no = 230
				elseif npc.count1 > 2 then
					npc.act_no = 220
				else
					npc.act_no = 210
				end
			end
		end
	elseif npc.act_no == 210 or npc.act_no == 211 then
		-- 開いている 普通----------
		if npc.act_no == 210 then
			npc.act_no          = 211
			npc.act_wait        =   0
			cs.gBoss[ 4].act_no =  10
			cs.gBoss[ 9].bits   = cs.gBoss[ 9].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[10].bits   = cs.gBoss[10].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[11].bits   = cs.gBoss[11].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[12].bits   = cs.gBoss[12].bits | cs.BITS_BANISH_DAMAGE
			_life = npc.life
			bShock = true
		end

		_flash = _flash + 1
		if npc.shock ~= 0 and cs.mod(cs.div(_flash, 2), 2) ~= 0 then
			cs.gBoss[5].ani_no = 1
			cs.gBoss[6].ani_no = 1
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

		-- スモークボール
		if npc.act_wait < 50 * 6 then
			if cs.mod(npc.act_wait, 120) == 1 then
				cs.SetNpChar(288, npc.x - 32 * cs.VS, npc.y - 16 * cs.VS, 0, 0, cs.DIR_UP,   nil, 32)
			end
			if cs.mod(npc.act_wait, 120) == 61 then
				cs.SetNpChar(288, npc.x - 32 * cs.VS, npc.y + 16 * cs.VS, 0, 0, cs.DIR_DOWN, nil, 32)
			end
		end
		-- 閉じる
		if npc.life < _life - cs.bossHPMultiply(50) or npc.act_wait > 50 * 8 then
			npc.act_no = 200
		end
	elseif npc.act_no == 220 or npc.act_no == 221 then
		-- 歯 ----------
		if npc.act_no == 220 then
			npc.act_no          = 221
			npc.act_wait        =   0
			npc.count1          =   0
			cs.gSuperYpos       =   1
			cs.gBoss[ 4].act_no =  20
			cs.gBoss[ 9].bits   = cs.gBoss[ 9].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[10].bits   = cs.gBoss[10].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[11].bits   = cs.gBoss[11].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[12].bits   = cs.gBoss[12].bits | cs.BITS_BANISH_DAMAGE
			cs.SetQuake(50 * 2)
			_life = npc.life
--			cs.SetNoise(500)
					bShock = true
		end
		npc.act_wait = npc.act_wait + 1

		-- レッドトルネード
		if cs.mod(npc.act_wait, 40) == 1 then
			local random = cs.Random(0, 3)
			if random == 0 then
				x = cs.gBoss[2].x
				y = cs.gBoss[2].y
			elseif random == 1 then
				x = cs.gBoss[3].x
				y = cs.gBoss[3].y
			elseif random == 2 then
				x = cs.gBoss[7].x
				y = cs.gBoss[7].y
			elseif random == 3 then
				x = cs.gBoss[8].x
				y = cs.gBoss[8].y
			end
			cs.PlaySoundObject(cs.WAVE_BUNRET, 1)
			cs.SetNpChar(285, x - 16 * cs.VS, y, 0, 0,   0 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.SetNpChar(285, x - 16 * cs.VS, y, 0, 0, 128 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end

		-- ダメージ点滅
		_flash = _flash + 1
		if npc.shock ~= 0 and cs.mod(cs.div(_flash, 2), 2) ~= 0 then
			cs.gBoss[5].ani_no = 1
			cs.gBoss[6].ani_no = 1
		else
			cs.gBoss[5].ani_no = 0
			cs.gBoss[6].ani_no = 0
		end

		-- 閉じる
		if npc.life < _life - cs.bossHPMultiply(150) or npc.act_wait > 50 * 8 or npc.life < 200 then
			npc.act_no = 200
		end
	elseif npc.act_no == 230 or npc.act_no == 231 then
		-- 波動砲----------
		if npc.act_no == 230 then
			npc.act_no          = 231
			npc.act_wait        =   0
			cs.gBoss[ 4].act_no =  30
			cs.gBoss[ 9].bits   = cs.gBoss[ 9].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[10].bits   = cs.gBoss[10].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[11].bits   = cs.gBoss[11].bits | cs.BITS_BLOCK_BULLET
			cs.gBoss[12].bits   = cs.gBoss[12].bits | cs.BITS_BANISH_DAMAGE
			cs.PlaySoundObject(cs.WAVE_BUNRET, 1)
			cs.SetNpChar(285, cs.gBoss[4].x - 16 * cs.VS, cs.gBoss[4].y, 0, 0,   0 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.SetNpChar(285, cs.gBoss[4].x - 16 * cs.VS, cs.gBoss[4].y, 0, 0, 128 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.SetNpChar(285, cs.gBoss[4].x, cs.gBoss[4].y - 16 * cs.VS, 0, 0,   0 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.SetNpChar(285, cs.gBoss[4].x, cs.gBoss[4].y - 16 * cs.VS, 0, 0, 128 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.SetNpChar(285, cs.gBoss[4].x, cs.gBoss[4].y + 16 * cs.VS, 0, 0,   0 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.SetNpChar(285, cs.gBoss[4].x, cs.gBoss[4].y + 16 * cs.VS, 0, 0, 128 * 8 + cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			_life = npc.life
			bShock = true
		end

		_flash = _flash + 1
		if npc.shock ~= 0 and cs.mod(cs.div(_flash, 2), 2) ~= 0 then
			cs.gBoss[5].ani_no = 1
			cs.gBoss[6].ani_no = 1
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

		-- スモークボール
--		if npc.act_wait < 50 * 6  then
			if cs.mod(npc.act_wait, 120) == 1 then
				cs.SetNpChar(288, npc.x - 32 * cs.VS, npc.y - 16 * cs.VS, 0, 0, cs.DIR_UP,   nil, 32)
			end
			if cs.mod(npc.act_wait, 120) == 61 then
				cs.SetNpChar(288, npc.x - 32 * cs.VS, npc.y + 16 * cs.VS, 0, 0, cs.DIR_DOWN, nil, 32)
			end
--		end
		-- 閉じる
--		if npc.life < _life - 50 or npc.act_wait > 50*8 then
--			npc.act_no = 200
--		end
	elseif npc.act_no == 500 or npc.act_no == 501 then
		-- 煙を吹く
		if npc.act_no == 500 then
			npc.act_no         = 501
			npc.act_wait       =   0
			npc.xm             =   0
			npc.ym             =   0
			cs.gBoss[4].act_no =   0
			cs.gBoss[5].ani_no =   2
			cs.gBoss[6].ani_no =   0
			cs.gBoss[2].act_no =   5
			cs.gBoss[3].act_no =   5
			cs.gBoss[7].act_no =   5
			cs.gBoss[8].act_no =   5

			cs.SetQuake(20)
			for i = 0, 99 do
				cs.SetNpChar(4,
					npc.x + cs.Random(-128, 128) * cs.VS,
					npc.y + cs.Random( -64,  64) * cs.VS,
					cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
					cs.Random(cs.div(-cs.VS, 4), cs.div(cs.VS, 4)) * cs.VS,
					cs.DIR_LEFT, nil, 0)
			end
			cs.DeleteNpCharCode(282, true)

			cs.gBoss[12].bits = cs.gBoss[12].bits & ~cs.BITS_BANISH_DAMAGE
			for i = 0, 11 do
				cs.gBoss[1 + i].bits = cs.gBoss[1 + i].bits & ~cs.BITS_BLOCK_BULLET
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

		npc.x = npc.x + cs.div(cs.VS, 8)
		npc.y = npc.y + cs.div(cs.VS, 4)

		if npc.act_wait > 200 then
			npc.act_wait =    0
			npc.act_no   = 1000
		end
	elseif npc.act_no == 1000 then
		-- やられ-------
		cs.SetQuake(100)
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.mod(cs.gBoss[1].act_wait, 8) == 0 then
			cs.PlaySoundObject(cs.WAVE_BOM, 1)
		end
		cs.SetDestroyNpChar(cs.gBoss[1].x + cs.Random(-72, 72) * cs.VS,
		                    cs.gBoss[1].y + cs.Random(-64, 64) * cs.VS, 1, 1)
		if cs.gBoss[1].act_wait > 50 * 2 then
			cs.gBoss[1].act_wait =    0
			cs.gBoss[1].act_no   = 1001
			cs.SetFlash(cs.gBoss[1].x, cs.gBoss[1].y, cs.FLASHMODE_EXPLOSION)
			cs.PlaySoundObject(cs.WAVE_EXPLOSION, 1)
		end
	elseif npc.act_no == 1001 then
		cs.SetQuake(40)
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait > 50 then
			for i = 0, cs.MAX_BOSS_PARTS - 1 do
				cs.gBoss[1 + i].cond = 0
			end
			cs.DeleteNpCharCode(158, true)
			cs.DeleteNpCharCode(301, true)
		end
	end

	if bShock then
		cs.SetQuake(20)
		if npc.act_no == 201 then
			cs.gBoss[2].act_no = 10
			cs.gBoss[3].act_no = 10
			cs.gBoss[7].act_no = 10
			cs.gBoss[8].act_no = 10
		end
		if npc.act_no == 221 then
			cs.gBoss[2].act_no = 20
			cs.gBoss[3].act_no = 20
			cs.gBoss[7].act_no = 20
			cs.gBoss[8].act_no = 20
		end
		if npc.act_no == 231 then
			cs.gBoss[2].act_no = 30
			cs.gBoss[3].act_no = 30
			cs.gBoss[7].act_no = 30
			cs.gBoss[8].act_no = 30
		end
		cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		for i = 0, 7 do
			cs.SetNpChar(4, cs.gBoss[5].x + cs.Random(-32, 16) * cs.VS, cs.gBoss[5].y,
				cs.Random(-cs.VS, cs.VS), cs.Random(cs.div(-cs.VS, 2), cs.div(cs.VS, 2)), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end
	end

	-- 移動
	if npc.act_no >= 200 and npc.act_no < 300 then
		if npc.x < cs.VS * cs.PARTSSIZE * 12 then
			npc.direct = cs.DIR_RIGHT
		end
		if npc.x > cs.VS * cs.PARTSSIZE * (cs.GetMapWidth() - 4) then
			npc.direct = cs.DIR_LEFT
		end
		if npc.direct == cs.DIR_LEFT then
			npc.xm = npc.xm - cs.div(cs.VS, 128)
		else
			npc.xm = npc.xm + cs.div(cs.VS, 128)
		end
	end

	-- コアリフト配置
	if npc.act_no == 201 or npc.act_no == 211 or npc.act_no == 221 or npc.act_no == 231 then
		npc.count2 = npc.count2 + 1
		if npc.count2 == 150 then
			npc.count2 = 0
			cs.SetNpChar(282, cs.GetMapWidth() * cs.VS * cs.PARTSSIZE + 64, cs.VS * cs.PARTSSIZE * (10 + cs.Random(-1, 3)), 0, 0, cs.DIR_LEFT, nil, 48)
		elseif npc.count2 == 75 then
			cs.SetNpChar(282, cs.GetMapWidth() * cs.VS * cs.PARTSSIZE + 64, cs.VS * cs.PARTSSIZE * ( 3 + cs.Random(-3, 0)), 0, 0, cs.DIR_LEFT, nil, 48)
		end
	end

	if npc.xm > cs.div( cs.VS, 4) then
		npc.xm = cs.div( cs.VS, 4)
	end
	if npc.xm < cs.div(-cs.VS, 4) then
		npc.xm = cs.div(-cs.VS, 4)
	end
	if npc.ym > cs.div( cs.VS, 4) then
		npc.ym = cs.div( cs.VS, 4)
	end
	if npc.ym < cs.div(-cs.VS, 4) then
		npc.ym = cs.div(-cs.VS, 4)
	end

	npc.x = npc.x + npc.xm
	npc.y = npc.y + npc.ym

	_ActBossCharA_Face(cs.gBoss[ 4])
	_ActBossCharA_Head(cs.gBoss[ 5])
	_ActBossCharA_Tail(cs.gBoss[ 6])
	_ActBossCharA_Mini(cs.gBoss[ 2])
	_ActBossCharA_Mini(cs.gBoss[ 3])
	_ActBossCharA_Mini(cs.gBoss[ 7])
	_ActBossCharA_Mini(cs.gBoss[ 8])
	_ActBossCharA_Hit( cs.gBoss[ 9])
	_ActBossCharA_Hit( cs.gBoss[10])
	_ActBossCharA_Hit( cs.gBoss[11])
	_ActBossCharA_Hit( cs.gBoss[12])
end

return ActBossChar_Undead
