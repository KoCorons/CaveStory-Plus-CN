-- Fred: This function can be found, commented-out, among the bullet functions.
--[[
local function IsActiveEdgeBullet()
	for i = 0, cs.MAX_BULLET - 1 do
		if cs.gBul[1 + i].cond & cs.COND_ALIVE ~= 0 and cs.gBul[1 + i].code_bullet == cs.BULLET_EDGE then
			return true
		end
	end
	return false
end
--]]

-- 0 dum
-- 1 eye
-- 2 eye
-- 3 body
-- 4 額　-44
-- 5 腹  

local BOSSLIFE = 800

local function _ActBossChar_Eye(npc)
	local rcLeft = {
		{left = 272, top =   0, right = 296, bottom =  16},
		{left = 272, top =  16, right = 296, bottom =  32},
		{left = 272, top =  32, right = 296, bottom =  48},
		{left =   0, top =   0, right =   0, bottom =   0},
		{left = 240, top =  16, right = 264, bottom =  32}, --黒
	}
	local rcRight = {
		{left = 296, top =   0, right = 320, bottom =  16},
		{left = 296, top =  16, right = 320, bottom =  32},
		{left = 296, top =  32, right = 320, bottom =  48},
		{left =   0, top =   0, right =   0, bottom =   0},
		{left = 240, top =  32, right = 264, bottom =  48},
	}

	if npc.act_no == 0 then
		
	elseif npc.act_no == 100 or npc.act_no == 101 then
		-- 開眼
		if npc.act_no == 100 then
			npc.act_no   = 101
			npc.ani_no   =   0
			npc.ani_wait =   0
		end

		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 2 then
			npc.act_no = 102
		end
	elseif npc.act_no == 102 then
		npc.ani_no = 3
	elseif npc.act_no == 200 or npc.act_no == 201 then
		-- 閉
		if npc.act_no == 200 then
			npc.act_no   = 201
			npc.ani_no   =   3
			npc.ani_wait =   0
		end

		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no - 1
		end
		if npc.ani_no <= 0 then
			npc.act_no = 202
		end
	elseif npc.act_no == 202 then
		
	elseif npc.act_no == 300 or npc.act_no == 301 then
		if npc.act_no == 300 then
			npc.act_no = 301
			npc.ani_no =   4
			if npc.direct == cs.DIR_LEFT then
				cs.SetDestroyNpChar(npc.x - 4 * cs.VS, npc.y, 4 * cs.VS, 10)
			else
				cs.SetDestroyNpChar(npc.x + 4 * cs.VS, npc.y, 4 * cs.VS, 10)
			end
		end
		
	end

	if npc.direct == cs.DIR_LEFT then
		npc.x = cs.gBoss[1].x - 24 * cs.VS
	else
		npc.x = cs.gBoss[1].x + 24 * cs.VS
	end
	npc.y = cs.gBoss[1].y - 36 * cs.VS

	if npc.act_no >= 0 and npc.act_no < 300 then
		if 3 ~= npc.ani_no then
			npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
		else
--			if cs.IsActiveEdgeBullet() then
--				npc.bits = npc.bits & ~cs.BITS_BANISH_DAMAGE
--			else
				npc.bits = npc.bits |  cs.BITS_BANISH_DAMAGE
--			end
		end
	end

	if npc.direct == cs.DIR_LEFT then
		npc.rect = rcLeft[ 1 + npc.ani_no]
	else
		npc.rect = rcRight[1 + npc.ani_no]
	end
end

local function _ActBossChar_Body(npc)
	local rc = {
		{left =   0, top =   0, right = 120, bottom = 120},
		{left = 120, top =   0, right = 240, bottom = 120},
		{left =   0, top = 120, right = 120, bottom = 240},
		{left = 120, top = 120, right = 240, bottom = 240},
	}
	npc.x = cs.gBoss[1].x
	npc.y = cs.gBoss[1].y

	npc.rect = rc[1 + npc.ani_no]
end

local function _ActBossChar_HITAI(npc)
	npc.x = cs.gBoss[1].x
	npc.y = cs.gBoss[1].y - 44 * cs.VS
end

local function _ActBossChar_HARA(npc)
	npc.x = cs.gBoss[1].x
	npc.y = cs.gBoss[1].y
end

local _flash = 0

--
local function ActBossChar_Ballos()
	local npc
	local x
	local y

	npc = cs.gBoss[1]

	if npc.act_no == 0 or npc.act_no == 1 then
		-- 初期設定
		if npc.act_no == 0 then
			npc.act_no              = 1
			npc.cond                = cs.COND_ALIVE
			npc.exp                 = 1
			npc.direct              = cs.DIR_LEFT
			npc.x                   = 20 * cs.VS * cs.PARTSSIZE
			npc.y                   = -4 * cs.VS * cs.PARTSSIZE
			npc.hit_voice           = cs.WAVE_NPC_GOHST
			npc.hit.front           = 32 * cs.VS
			npc.hit.top             = 48 * cs.VS
			npc.hit.back            = 32 * cs.VS
			npc.hit.bottom          = 48 * cs.VS
			npc.bits                = cs.BITS_THROW_BLOCK | cs.BITS_EVENT_BREAK | cs.BITS_BLOCK_MYCHAR2 | cs.BITS_VIEWDAMAGE
			npc.size                = cs.NPCSIZE_LARGE
			npc.damage              =    0
			npc.code_event          = 1000
			npc.life                =  BOSSLIFE -- 800

			-- 目
			cs.gBoss[2].cond        = cs.COND_ALIVE | cs.COND_ZEROINDEXDAMAGE
			cs.gBoss[2].direct      = cs.DIR_LEFT
			cs.gBoss[2].bits        = cs.BITS_THROW_BLOCK
			cs.gBoss[2].life        = 10000
			cs.gBoss[2].view.front  = 12 * cs.VS
			cs.gBoss[2].view.top    =  0 * cs.VS
			cs.gBoss[2].view.back   = 12 * cs.VS
			cs.gBoss[2].view.bottom = 16 * cs.VS
			cs.gBoss[2].hit.front   = 12 * cs.VS
			cs.gBoss[2].hit.top     =  0 * cs.VS
			cs.gBoss[2].hit.back    = 12 * cs.VS
			cs.gBoss[2].hit.bottom  = 16 * cs.VS

			cs.gBoss[3]             = cs.gBoss[2]
			cs.gBoss[3].direct      = cs.DIR_RIGHT

			-- 体
			cs.gBoss[4].cond        = cs.COND_ALIVE | cs.COND_ZEROINDEXDAMAGE
			cs.gBoss[4].bits        = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_BULLET
			cs.gBoss[4].view.front  = 60 * cs.VS
			cs.gBoss[4].view.top    = 60 * cs.VS
			cs.gBoss[4].view.back   = 60 * cs.VS
			cs.gBoss[4].view.bottom = 60 * cs.VS
			cs.gBoss[4].hit.front   = 48 * cs.VS
			cs.gBoss[4].hit.top     = 24 * cs.VS
			cs.gBoss[4].hit.back    = 48 * cs.VS
			cs.gBoss[4].hit.bottom  = 32 * cs.VS

			cs.gBoss[5].cond        = cs.COND_ALIVE | cs.COND_ZEROINDEXDAMAGE			
			cs.gBoss[5].bits        = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_BULLET
			cs.gBoss[5].hit.front   = 32 * cs.VS
			cs.gBoss[5].hit.top     =  8 * cs.VS
			cs.gBoss[5].hit.back    = 32 * cs.VS
			cs.gBoss[5].hit.bottom  =  8 * cs.VS

			cs.gBoss[6].cond        = cs.COND_ALIVE | cs.COND_ZEROINDEXDAMAGE			
			cs.gBoss[6].bits        = cs.BITS_THROW_BLOCK | cs.BITS_BLOCK_MYCHAR2 | cs.BITS_BLOCK_BULLET
			cs.gBoss[6].hit.front   = 32 * cs.VS
			cs.gBoss[6].hit.top     =  0 * cs.VS
			cs.gBoss[6].hit.back    = 32 * cs.VS
			cs.gBoss[6].hit.bottom  = 48 * cs.VS
		end

		-- 待機
	elseif npc.act_no == 100 or npc.act_no == 101 then
		-- 落下登場 --------------------------------
		if npc.act_no == 100 then
			npc.act_no   = 101
			npc.ani_no   =   0
			npc.x        = cs.gMC[1].x
			cs.SetNpChar(333, cs.gMC[1].x, 19 * cs.VS * cs.PARTSSIZE, 0, 0, cs.DIR_RIGHT, nil, cs.div(cs.MAX_NPC, 2))
			npc.act_wait =   0
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 30 then
			npc.act_no = 102
		end
	elseif npc.act_no == 102 then
		npc.ym = npc.ym + cs.div(cs.VS, 8)
		if npc.ym > 6 * cs.VS then
			npc.ym = 6 * cs.VS
		end
		npc.y = npc.y + npc.ym
		if npc.y > 19 * cs.VS * cs.PARTSSIZE - npc.hit.bottom then
			npc.y = 19 * cs.VS * cs.PARTSSIZE - npc.hit.bottom
			npc.ym       =   0
			npc.act_no   = 103
			npc.act_wait =   0
			cs.SetQuake2(30)
			cs.PlaySoundObject(cs.WAVE_BOM, 1)
			-- 踏み潰しダメージ
			for mc_no = 0, cs.gNumMyChar - 1 do
				if cs.gMC[1 + mc_no].y > npc.y + 48 * cs.VS and
				   cs.gMC[1 + mc_no].x < npc.x + 24 * cs.VS and
				   cs.gMC[1 + mc_no].x > npc.x - 24 * cs.VS then
					cs.DamageMyChar(mc_no, 16)
				end
				if cs.gMC[1 + mc_no].flag & cs.FLAG_HIT_BOTTOM ~= 0 then
					cs.gMC[1 + mc_no].ym = -cs.VS
				end
			end
			for i = 0, 15 do
				x = npc.x + cs.Random(-40, 40) * cs.VS
				cs.SetNpChar(4, x, npc.y + 40 * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
		end
	elseif npc.act_no == 103 then
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait == 50 then
			npc.act_no         = 104
			cs.gBoss[2].act_no = 100
			cs.gBoss[3].act_no = 100
		end
	elseif npc.act_no == 104 then
		
	elseif npc.act_no == 200 or npc.act_no == 201 or npc.act_no == 203 then
		-- 連続踏み潰し ------------------------
		if npc.act_no == 200 or npc.act_no == 201 then
			if npc.act_no == 200 then
				npc.act_no = 201
				npc.count1 =   0
			end

			npc.act_no     = 203
			npc.xm         =   0
			npc.count1     = npc.count1 + 1
			npc.hit.bottom = 48 * cs.VS
			npc.damage     =  0
			if cs.mod(npc.count1, 3) == 0 then
				npc.act_wait = 150
			else
				npc.act_wait =  50
			end
		end
		npc.act_wait = npc.act_wait - 1
		if npc.act_wait <= 0 then
			npc.act_no = 204
			npc.ym     = -cs.VS * 6
			cs.NpCharSetNearestXTargetMC(npc)
			if npc.x < cs.gMC[1 + npc.tgt_mc].x then
				npc.xm = cs.VS *  1
			else
				npc.xm = cs.VS * -1
			end
		end
	elseif npc.act_no == 204 then
		if npc.x <  2 * cs.VS * cs.PARTSSIZE + 48 * cs.VS then
			npc.xm =  1 * cs.VS
		end
		if npc.x > 37 * cs.VS * cs.PARTSSIZE - 48 * cs.VS then
			npc.xm = -1 * cs.VS
		end
		npc.ym = npc.ym + cs.div(cs.VS, 6)
		if npc.ym > 6 * cs.VS then
			npc.ym = 6 * cs.VS
		end
		npc.x = npc.x + npc.xm
		npc.y = npc.y + npc.ym
		if npc.y > 19 * cs.VS * cs.PARTSSIZE - npc.hit.bottom then
			npc.y = 19 * cs.VS * cs.PARTSSIZE - npc.hit.bottom
			npc.ym       =   0
			npc.act_no   = 201
			npc.act_wait =   0

			-- 踏み潰しダメージ
			for mc_no = 0, cs.gNumMyChar - 1 do
				if cs.gMC[1 + mc_no].y > npc.y + 56 * cs.VS then
					cs.DamageMyChar(mc_no, 16)
				end
				if cs.gMC[1 + mc_no].flag & cs.FLAG_HIT_BOTTOM ~= 0 then
					cs.gMC[1 + mc_no].ym = -cs.VS
				end
			end

			cs.SetQuake2(30)
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.SetNpChar(332, npc.x - 12 * cs.VS, npc.y + 52 * cs.VS, 0, 0, cs.DIR_LEFT,  nil, cs.div(cs.MAX_NPC, 2))
			cs.SetNpChar(332, npc.x + 12 * cs.VS, npc.y + 52 * cs.VS, 0, 0, cs.DIR_RIGHT, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_BOM, 1)
			for i = 0, 15 do
				x = npc.x + cs.Random(-40, 40) * cs.VS
				cs.SetNpChar(4, x, npc.y + 40 * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
		end
	elseif npc.act_no == 220 or npc.act_no == 221 then
		--やられ落下
		if npc.act_no == 220 then
			npc.act_no         =  221
			npc.life           = 1200
			cs.gBoss[2].act_no =  200 --close
			cs.gBoss[3].act_no =  200 --close
--			npc.ym             =    0
			npc.xm             =    0
			npc.ani_no         =    0
			npc.shock          =    0
			_flash             =    0
		end

		npc.ym = npc.ym + cs.div(cs.VS, 8)
		if npc.ym > 6 * cs.VS then
			npc.ym = 6 * cs.VS
		end
		npc.y = npc.y + npc.ym
		if npc.y > 19 * cs.VS * cs.PARTSSIZE - npc.hit.bottom then
			npc.y = 19 * cs.VS * cs.PARTSSIZE - npc.hit.bottom
			npc.ym       =   0
			npc.act_no   = 222
			npc.act_wait =   0
			cs.SetQuake2(30)
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			for i = 0, 15 do
				x = npc.x + cs.Random(-40, 40) * cs.VS
				cs.SetNpChar(4, x, npc.y + 40 * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
			for mc_no = 0, cs.gNumMyChar - 1 do
				if cs.gMC[1 + mc_no].flag & cs.FLAG_HIT_BOTTOM ~= 0 then
					cs.gMC[1 + mc_no].ym = -cs.VS
				end
			end
		end
	elseif npc.act_no == 222 then
		
	elseif npc.act_no == 300 or npc.act_no == 301 then
		-- ころがり -------------------------------------------
		if npc.act_no == 300 then
			npc.act_no   = 301
			npc.act_wait =   0
			for i = 0, 3 do
				cs.SetNpChar(342, npc.x, npc.y, 0, 0, i * 64      + 0x100 * cs.DIR_LEFT,  npc, 90)
				cs.SetNpChar(342, npc.x, npc.y, 0, 0, i * 64 + 32 + 0x100 * cs.DIR_RIGHT, npc, 90)
			end
			cs.SetNpChar(343, npc.x,              npc.y,              0, 0, cs.DIR_LEFT,  npc, 24)
			cs.SetNpChar(344, npc.x - 24 * cs.VS, npc.y - 36 * cs.VS, 0, 0, cs.DIR_LEFT,  npc, 32)
			cs.SetNpChar(344, npc.x + 24 * cs.VS, npc.y - 36 * cs.VS, 0, 0, cs.DIR_RIGHT, npc, 32)
		end

		-- サークル装着/浮遊
		npc.y = npc.y + cs.div(19 * cs.VS * cs.PARTSSIZE - 79 * cs.VS - npc.y, 8)
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 then
			npc.act_no   = 310
			npc.act_wait =   0
		end
	elseif npc.act_no == 310 then
		
	elseif npc.act_no == 311 then
		-- 左
		npc.direct = cs.DIR_LEFT
		npc.xm = -(cs.VS + cs.div(cs.VS * 5, 6))
		npc.ym = 0
		npc.x = npc.x + npc.xm
		if npc.x < 2 * cs.VS * cs.PARTSSIZE + 79 * cs.VS then
			npc.x = 2 * cs.VS * cs.PARTSSIZE + 79 * cs.VS
			npc.act_no = 312
		end
	elseif npc.act_no == 312 then
		-- 上
		npc.direct = cs.DIR_UP
		npc.ym     = -(cs.VS + cs.div(cs.VS * 5, 6))
		npc.xm     = 0
		npc.y      = npc.y + npc.ym
		if npc.y <  2 * cs.VS * cs.PARTSSIZE + 79 * cs.VS then
			npc.y =  2 * cs.VS * cs.PARTSSIZE + 79 * cs.VS
			npc.act_no = 313
		end
	elseif npc.act_no == 313 then
		-- 右
		npc.direct = cs.DIR_RIGHT
		npc.xm     = cs.VS + cs.div(cs.VS * 5, 6)
		npc.ym     = 0
		npc.x      = npc.x + npc.xm
		if npc.x > 37 * cs.VS * cs.PARTSSIZE - 79 * cs.VS then
			npc.x = 37 * cs.VS * cs.PARTSSIZE - 79 * cs.VS
			npc.act_no = 314
		end
		if npc.count1 ~= 0 then
			npc.count1 = npc.count1 - 1
		end
		if npc.count1 == 0 and npc.x > 19 * cs.VS * cs.PARTSSIZE and npc.x < 21 * cs.VS * cs.PARTSSIZE then
			npc.act_no = 400
		end
	elseif npc.act_no == 314 then
		-- 下
		npc.direct = cs.DIR_DOWN
		npc.ym     = cs.VS + cs.div(cs.VS * 5, 6)
		npc.xm     = 0
		npc.y      = npc.y + npc.ym
		if npc.y > 19 * cs.VS * cs.PARTSSIZE - 79 * cs.VS then
			npc.y = 19 * cs.VS * cs.PARTSSIZE - 79 * cs.VS
			npc.act_no = 311
		end
	elseif npc.act_no == 400 or npc.act_no == 401 then
		-- 浮遊 -------------------------------------------
		if npc.act_no == 400 then
			npc.act_no   = 401
			npc.act_wait =   0
			npc.xm       =   0
			npc.ym       =   0
--			npc.life       = BOSSLIFE
			cs.DeleteNpCharCode(339, false)
		end

		-- 真中へ
		npc.y = npc.y + cs.div(5 * cs.VS * cs.PARTSSIZE + 79 * cs.VS - npc.y, 8)
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 then
			npc.act_wait =   0
			npc.act_no   = 410
			local i
			i = 0
--			while i < 256 do
--				cs.SetNpChar(346, npc.x, npc.y, 0, 0, i, npc, 80)
--				i = i + 43
--			end
--			while i < 256 do
--				cs.SetNpChar(346, npc.x, npc.y, 0, 0, i, npc, 80)
--				i = i + 37
--			end
			while i < 256 do
				cs.SetNpChar(346, npc.x, npc.y, 0, 0, i, npc, 80)
				i = i + 32
			end
--			while i < 256 do
--				cs.SetNpChar(346, npc.x, npc.y, 0, 0, i, npc, 80)
--				i = i + 29
--			end
			cs.SetNpChar(343, npc.x,              npc.y,              0, 0, cs.DIR_LEFT,  npc, 24)
			cs.SetNpChar(344, npc.x - 24 * cs.VS, npc.y - 36 * cs.VS, 0, 0, cs.DIR_LEFT,  npc, 32)
			cs.SetNpChar(344, npc.x + 24 * cs.VS, npc.y - 36 * cs.VS, 0, 0, cs.DIR_RIGHT, npc, 32)
		end
	elseif npc.act_no == 410 then
		-- ブロック準備
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 then
			npc.act_wait   =   0
			npc.act_no     = 411
		end
	elseif npc.act_no == 411 then
		-- サークル吸着／
		npc.act_wait = npc.act_wait + 1
		if cs.mod(npc.act_wait, 30) == 1 then
			x = (2 + cs.div(npc.act_wait, 30) * 2) * cs.PARTSSIZE * cs.VS
			cs.SetNpChar(348, x, 21 * cs.VS * cs.PARTSSIZE, 0, 0, 0, nil, cs.div(cs.MAX_NPC * 3, 4))
		end
		if cs.mod(cs.div(npc.act_wait, 3), 2) ~= 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		end
		if npc.act_wait > 18 * 30 then
			npc.act_no = 420
		end
	elseif npc.act_no == 420 or npc.act_no == 421 then
		-- 開眼開始 ===================================
		if npc.act_no == 420 then
			npc.act_no   = 421
			npc.act_wait =   0
			npc.ani_wait =   0
			cs.SetQuake2(30)
			cs.PlaySoundObject(cs.WAVE_EXPLOSION, 1)
			cs.gBoss[2].act_no = 102 --open
			cs.gBoss[3].act_no = 102 --open
			for i = 0, 255 do
				x = npc.x + cs.Random(-60, 60) * cs.VS
				y = npc.y + cs.Random(-60, 60) * cs.VS
				cs.SetNpChar(4, x, y, 0, 0, cs.DIR_LEFT, nil, 0)
			end
		end

		-- 右回転２
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 10 * 50 then
			npc.ani_wait = 0
			npc.act_no = 422
		end
	elseif npc.act_no == 422 then
		-- 右回転１
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 4 * 50 then
			npc.ani_wait = 0
			npc.act_no = 423
		end
	elseif npc.act_no == 423 then
		-- 停止
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 20 then
			npc.ani_wait = 0
			npc.act_no = 424
		end
	elseif npc.act_no == 424 then
		-- 左回転１
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 4 * 50 then
			npc.ani_wait = 0
			npc.act_no = 425
		end
	elseif npc.act_no == 425 then
		-- 左回転２
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 10 * 50 then
			npc.ani_wait = 0
			npc.act_no = 426
		end
	elseif npc.act_no == 426 then
		-- 左回転１
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 4 * 50 then
			npc.ani_wait = 0
			npc.act_no = 427
		end
	elseif npc.act_no == 427 then
		-- 停止
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 20 then
			npc.ani_wait = 0
			npc.act_no = 428
		end
	elseif npc.act_no == 428 then
		-- 右回転１
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 4 * 50 then
			npc.ani_wait = 0
			npc.act_no = 421
		end
	elseif npc.act_no == 1000 or npc.act_no == 1001 then
		-- やられ =========================================
		if npc.act_no == 1000 then
			npc.act_no         = 1001
			npc.act_wait       =    0
			cs.gBoss[2].act_no =  300 --break
			cs.gBoss[3].act_no =  300 --break

			-- Fred: These two lines make absolutely no sense, so they have been disabled.
			--cs.gBoss[2].act_no =  cs.gBoss[2].act_no & ~(cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_MYCHAR2)
			--cs.gBoss[3].act_no =  cs.gBoss[3].act_no & ~(cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_MYCHAR2)
			cs.gBoss[1].bits =  cs.gBoss[1].bits & ~(cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_MYCHAR2)
			cs.gBoss[4].bits =  cs.gBoss[4].bits & ~(cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_MYCHAR2)
			cs.gBoss[5].bits =  cs.gBoss[5].bits & ~(cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_MYCHAR2)
			cs.gBoss[6].bits =  cs.gBoss[6].bits & ~(cs.BITS_BLOCK_MYCHAR | cs.BITS_BLOCK_MYCHAR2)
		end

		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.mod(cs.gBoss[1].act_wait, 12) == 0 then
			cs.PlaySoundObject(cs.WAVE_BOM, 1)
		end
		cs.SetDestroyNpChar(cs.gBoss[1].x + cs.Random(-60, 60) * cs.VS,
		                    cs.gBoss[1].y + cs.Random(-60, 60) * cs.VS, 1, 1)
		if cs.gBoss[1].act_wait > 50 * 3 then
			cs.gBoss[1].act_wait =  0
			cs.gBoss[1].act_no   = 1002
			cs.SetFlash(cs.gBoss[1].x, cs.gBoss[1].y, cs.FLASHMODE_EXPLOSION)
			cs.PlaySoundObject(cs.WAVE_EXPLOSION, 1)
		end
	elseif npc.act_no == 1002 then
		cs.SetQuake2(40)
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait == 50 then
			cs.gBoss[1].cond = 0
			cs.gBoss[2].cond = 0
			cs.gBoss[3].cond = 0
			cs.gBoss[4].cond = 0
			cs.gBoss[5].cond = 0
			cs.gBoss[6].cond = 0
			cs.DeleteNpCharCode(350, true)
			cs.DeleteNpCharCode(348, true)
		end
	end
	if npc.act_no > 420 and npc.act_no < 500 then
		-- 最終形態のアクション
--		if IsActiveEdgeBullet() then
--			cs.gBoss[4].bits = cs.gBoss[4].bits & ~cs.BITS_BANISH_DAMAGE
--			cs.gBoss[5].bits = cs.gBoss[5].bits & ~cs.BITS_BANISH_DAMAGE
--			cs.gBoss[6].bits = cs.gBoss[6].bits & ~cs.BITS_BANISH_DAMAGE
--		else
			cs.gBoss[4].bits = cs.gBoss[4].bits |  cs.BITS_BANISH_DAMAGE
			cs.gBoss[5].bits = cs.gBoss[5].bits |  cs.BITS_BANISH_DAMAGE
			cs.gBoss[6].bits = cs.gBoss[6].bits |  cs.BITS_BANISH_DAMAGE
--		end
		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 300 then
			npc.act_wait = 0
			for mc_no = 0, cs.gNumMyChar - 1 do
				if cs.gMC[1 + mc_no].x > npc.x then
					for i = 0, cs.div(8, cs.gNumMyChar) - 1 do
						x = cs.div((cs.Random(-1 * 4, 1 * 4) + 39 * 4) * cs.VS * cs.PARTSSIZE, 4)
						y = cs.div( cs.Random(2 * 4, 17 * 4)           * cs.VS * cs.PARTSSIZE, 4)
						cs.SetNpChar(350, x, y, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
					end
				else
					for i = 0, cs.div(8, cs.gNumMyChar) - 1 do
						x = cs.div((cs.Random(-1 * 4, 1 * 4) + 0 * 4) * cs.VS * cs.PARTSSIZE, 4)
						y = cs.div( cs.Random(2 * 4, 17 * 4)          * cs.VS * cs.PARTSSIZE, 4)
						cs.SetNpChar(350, x, y, 0, 0, cs.DIR_RIGHT, nil, cs.div(cs.MAX_NPC, 2))
					end
				end
			end
		end
		if npc.act_wait == 270 or npc.act_wait == 280 or npc.act_wait == 290 then
			cs.SetNpChar(353, npc.x, npc.y - 52 * cs.VS, 0, 0, cs.DIR_UP, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_POP, 1)
			for i = 0, 3 do
				cs.SetNpChar(4, npc.x, npc.y - 52 * cs.VS, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
		end
		if npc.life > cs.bossHPMultiply(500) then
			if cs.Random(0, 10) == 2 then
				x = npc.x + cs.Random(-40, 40) * cs.VS
				y = npc.y + cs.Random(  0, 40) * cs.VS
				cs.SetNpChar(270, x, y, 0, 0, cs.DIR_DOWN, nil, 0)
			end
		else
			if cs.Random(0, 4) == 2 then
				x = npc.x + cs.Random(-40, 40) * cs.VS
				y = npc.y + cs.Random(  0, 40) * cs.VS
				cs.SetNpChar(270, x, y, 0, 0, cs.DIR_DOWN, nil, 0)
			end
		end
	end

	-- フラッシュ
	if npc.shock ~= 0 then
		_flash = _flash + 1
		if cs.mod(cs.div(_flash, 2), 2) ~= 0 then
			cs.gBoss[4].ani_no = 1
		else
			cs.gBoss[4].ani_no = 0
		end
	else
		cs.gBoss[4].ani_no = 0
	end
	if npc.act_no > 420 then
		cs.gBoss[4].ani_no = cs.gBoss[4].ani_no + 2
	end

	_ActBossChar_Eye(  cs.gBoss[2])
	_ActBossChar_Eye(  cs.gBoss[3])
	_ActBossChar_Body( cs.gBoss[4])
	_ActBossChar_HITAI(cs.gBoss[5])
	_ActBossChar_HARA( cs.gBoss[6])
end

return ActBossChar_Ballos
