-- ひざ
local function ActBoss01_12()
	local rcLeft = {
		{left =  80, top =  56, right = 104, bottom =  72},
	}
	local rcRight = {
		{left = 104, top =  56, right = 128, bottom =  72},
	}

	for i = 1, 2 do
		cs.gBoss[1 + i].y = cs.div(cs.gBoss[1].y + cs.gBoss[1 + (i + 2)].y - 8 * cs.VS, 2)

		if cs.gBoss[1 + i].direct == cs.DIR_LEFT then
			cs.gBoss[1 + i].x = cs.gBoss[1].x - 16 * cs.VS
			cs.gBoss[1 + i].rect = rcLeft[1 + cs.gBoss[1 + i].ani_no]
		else
			cs.gBoss[1 + i].rect = rcRight[1 + cs.gBoss[1 + i].ani_no]
			cs.gBoss[1 + i].x = cs.gBoss[1].x + 16 * cs.VS
		end
	end
end

-- つま先
local function ActBoss01_34()
	local rcLeft = {
		{left =   0, top =  56, right =  40, bottom =  88},
		{left =  40, top =  56, right =  80, bottom =  88},
	}
	local rcRight = {
		{left =   0, top =  88, right =  40, bottom = 120},
		{left =  40, top =  88, right =  80, bottom = 120},
	}

	for i = 3, 4 do
		if cs.gBoss[1 + i].act_no == 0 or cs.gBoss[1 + i].act_no == 1 then
			--初期パラメータ
			if cs.gBoss[1 + i].act_no == 0 then
				cs.gBoss[1 + i].act_no = 1
			end

			--待機
			cs.gBoss[1 + i].y = cs.gBoss[1].y
			if i == 3 then
				cs.gBoss[1 + i].x = cs.gBoss[1].x - 16 * cs.VS
			end
			if i == 4 then
				cs.gBoss[1 + i].x = cs.gBoss[1].x + 16 * cs.VS
			end
		elseif cs.gBoss[1 + i].act_no == 2 then
			--出現
		elseif cs.gBoss[1 + i].act_no == 3 then
			--メイン
			cs.gBoss[1 + i].tgt_y = cs.gBoss[1].y + 24 * cs.VS
			if i == 3 then
				cs.gBoss[1 + i].x = cs.gBoss[1].x - 16 * cs.VS
			end
			if i == 4 then
				cs.gBoss[1 + i].x = cs.gBoss[1].x + 16 * cs.VS
			end

			--目標座標を追いかける。
--			if cs.gBoss[1 + i].x < cs.gBoss[1 + i].tgt_x then
--				cs.gBoss[1 + i].xm = cs.gBoss[1 + i].xm + cs.VS
--			end
--			if cs.gBoss[1 + i].x > cs.gBoss[1 + i].tgt_x then
--				cs.gBoss[1 + i].xm = cs.gBoss[1 + i].xm - cs.VS
--			end
--			if cs.gBoss[1 + i].y < cs.gBoss[1 + i].tgt_y then
--				cs.gBoss[1 + i].ym = cs.gBoss[1 + i].ym + cs.VS
--			end
--			if cs.gBoss[1 + i].y > cs.gBoss[1 + i].tgt_y then
--				cs.gBoss[1 + i].ym = cs.gBoss[1 + i].ym - cs.VS
--			end

--			if cs.gBoss[1 + i].xm >  cs.MAX_MOVE then
--				cs.gBoss[1 + i].xm =  cs.MAX_MOVE
--			end
--			if cs.gBoss[1 + i].xm < -cs.MAX_MOVE then
--				cs.gBoss[1 + i].xm = -cs.MAX_MOVE
--			end
--			if cs.gBoss[1 + i].ym >  cs.MAX_MOVE then
--				cs.gBoss[1 + i].ym =  cs.MAX_MOVE
--			end
--			if cs.gBoss[1 + i].ym < -cs.MAX_MOVE then
--				cs.gBoss[1 + i].ym = -cs.MAX_MOVE
--			end
--			cs.gBoss[1 + i].y = cs.gBoss[1 + i].y + cs.gBoss[1 + i].ym

			cs.gBoss[1 + i].y = cs.gBoss[1 + i].y + cs.div(cs.gBoss[1 + i].tgt_y - cs.gBoss[1 + i].y, 2)
		end

		-- 地面についているとき 離れてる時
		if cs.gBoss[1 + i].flag & cs.FLAG_HIT_BOTTOM ~= 0 or cs.gBoss[1 + i].y <= cs.gBoss[1 + i].tgt_y then
			cs.gBoss[1 + i].ani_no = 0
		else
			cs.gBoss[1 + i].ani_no = 1
		end

		if cs.gBoss[1 + i].direct == cs.DIR_LEFT then
			cs.gBoss[1 + i].rect = rcLeft[ 1 + cs.gBoss[1 + i].ani_no]
		else
			cs.gBoss[1 + i].rect = rcRight[1 + cs.gBoss[1 + i].ani_no]
		end
	end
end

-- マイキャラ辺り判定。
local function ActBoss01_5()
	if cs.gBoss[6].act_no == 0 or cs.gBoss[6].act_no == 1 then
		if cs.gBoss[6].act_no == 0 then
			cs.gBoss[6].bits = cs.gBoss[6].bits | (cs.BITS_BLOCK_MYCHAR | cs.BITS_THROW_BLOCK)
			cs.gBoss[6].hit.front  = 20 * cs.VS
			cs.gBoss[6].hit.top    = 36 * cs.VS
			cs.gBoss[6].hit.back   = 20 * cs.VS
			cs.gBoss[6].hit.bottom = 16 * cs.VS
			cs.gBoss[6].act_no = 1
		end

		cs.gBoss[6].x = cs.gBoss[1].x
		cs.gBoss[6].y = cs.gBoss[1].y
	end
end

local function ActBossChar_Omega()
	if cs.gBoss[1].act_no == 0 or cs.gBoss[1].act_no == 10 then
		-- 初期設定
		if cs.gBoss[1].act_no == 0 then
			cs.gBoss[1].x = 219 * cs.VS * cs.PARTSSIZE
			cs.gBoss[1].y =  16 * cs.VS * cs.PARTSSIZE
			cs.gBoss[1].view.front  = 40 * cs.VS
			cs.gBoss[1].view.top    = 40 * cs.VS
			cs.gBoss[1].view.back   = 40 * cs.VS
			cs.gBoss[1].view.bottom = 16 * cs.VS
			cs.gBoss[1].tgt_x = cs.gBoss[1].x
			cs.gBoss[1].tgt_y = cs.gBoss[1].y
			cs.gBoss[1].hit_voice = cs.WAVE_NPC_LARGE
			cs.gBoss[1].hit.front  = 8 * cs.VS
			cs.gBoss[1].hit.top    = 24 * cs.VS
			cs.gBoss[1].hit.back   = 8 * cs.VS
			cs.gBoss[1].hit.bottom = 16 * cs.VS
			cs.gBoss[1].bits = cs.BITS_THROW_BLOCK | cs.BITS_EVENT_BREAK | cs.BITS_VIEWDAMAGE
			cs.gBoss[1].size = cs.NPCSIZE_LARGE
			cs.gBoss[1].exp  = 1

			cs.gBoss[1].code_event = 210

			cs.gBoss[1].life = 800

			--ひざ
			cs.gBoss[2].cond = cs.COND_ALIVE
			cs.gBoss[2].view.front  = 12 * cs.VS
			cs.gBoss[2].view.top    =  8 * cs.VS
			cs.gBoss[2].view.back   = 12 * cs.VS
			cs.gBoss[2].view.bottom =  8 * cs.VS
			cs.gBoss[2].bits = cs.BITS_THROW_BLOCK

			cs.gBoss[3] = cs.gBoss[2]

			cs.gBoss[2].direct = cs.DIR_LEFT
			cs.gBoss[3].direct = cs.DIR_RIGHT

			-- 足
			cs.gBoss[4].cond = cs.COND_ALIVE
			cs.gBoss[4].view.front  = 24 * cs.VS
			cs.gBoss[4].view.top    = 16 * cs.VS
			cs.gBoss[4].view.back   = 16 * cs.VS
			cs.gBoss[4].view.bottom = 16 * cs.VS
			cs.gBoss[4].hit_voice = cs.WAVE_NPC_LARGE
			cs.gBoss[4].hit.front  = 8 * cs.VS
			cs.gBoss[4].hit.top    = 8 * cs.VS
			cs.gBoss[4].hit.back   = 8 * cs.VS
			cs.gBoss[4].hit.bottom = 8 * cs.VS
			cs.gBoss[4].bits = cs.BITS_THROW_BLOCK

			cs.gBoss[4].x = cs.gBoss[1].x - 16 * cs.VS
			cs.gBoss[4].y = cs.gBoss[1].y
			cs.gBoss[4].direct = cs.DIR_LEFT

			cs.gBoss[5] = cs.gBoss[4]

			cs.gBoss[5].direct = cs.DIR_RIGHT
			cs.gBoss[4].x = cs.gBoss[1].x + 16 * cs.VS

			-- ボスブロック
			cs.gBoss[6].cond = cs.COND_ALIVE
		end

		-- 待機
	elseif cs.gBoss[1].act_no == 20 or cs.gBoss[1].act_no == 30 then
		-- 開始
		if cs.gBoss[1].act_no == 20 then
			cs.gBoss[1].act_no   = 30
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].ani_no   = 0
		end

		-- 地震出現
		cs.SetQuake(2)
		cs.gBoss[1].y = cs.gBoss[1].y - cs.VS
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.mod(cs.gBoss[1].act_wait, 4) == 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		end
		if cs.gBoss[1].act_wait == 48 then
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].act_no   = 40

			if cs.gBoss[1].life <= cs.bossHPMultiply(280) then
				---jamp-
				cs.gBoss[1].act_no   = 110
				cs.gBoss[1].bits = cs.gBoss[1].bits | cs.BITS_BANISH_DAMAGE
				cs.gBoss[1].bits = cs.gBoss[1].bits & ~cs.BITS_THROW_BLOCK
				cs.gBoss[4].bits = cs.gBoss[4].bits & ~cs.BITS_THROW_BLOCK
				cs.gBoss[5].bits = cs.gBoss[5].bits & ~cs.BITS_THROW_BLOCK
				cs.gBoss[4].act_no   = 3
				cs.gBoss[5].act_no   = 3

				cs.gBoss[6].hit.top  = 16 * cs.VS
			end
		end
	elseif cs.gBoss[1].act_no == 40 then
		-- 待機
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait == 48 then
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].act_no   = 50
			cs.gBoss[1].ani_wait = 0

			cs.gBoss[6].hit.top = 16 * cs.VS
			cs.PlaySoundObject(cs.WAVE_BAIT, 1)
		end
	elseif cs.gBoss[1].act_no == 50 then
		-- 開口
		cs.gBoss[1].ani_wait = cs.gBoss[1].ani_wait + 1
		if cs.gBoss[1].ani_wait > 2 then
			cs.gBoss[1].ani_wait = 0
			cs.gBoss[1].ani_no = cs.gBoss[1].ani_no + 1
		end
		if cs.gBoss[1].ani_no == 3 then
			cs.gBoss[1].act_no   = 60
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].bits = cs.gBoss[1].bits | cs.BITS_BANISH_DAMAGE
			cs.gBoss[1].hit.front  = 16 * cs.VS
			cs.gBoss[1].hit.back   = 16 * cs.VS
		end
	elseif cs.gBoss[1].act_no == 60 then
		-- 吐き出し
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait > 20 and cs.gBoss[1].act_wait < 80 and cs.mod(cs.gBoss[1].act_wait, 3) == 0 then
			if cs.Random(0, 9) < 8 then
				cs.SetNpChar(48, cs.gBoss[1].x, cs.gBoss[1].y - 16 * cs.VS, cs.Random(cs.div(-cs.VS, 2), cs.div(cs.VS, 2)), cs.div(-16 * cs.VS, 10), cs.DIR_LEFT,  nil, cs.div(cs.MAX_NPC, 2))
			else
				cs.SetNpChar(48, cs.gBoss[1].x, cs.gBoss[1].y - 16 * cs.VS, cs.Random(cs.div(-cs.VS, 2), cs.div(cs.VS, 2)), cs.div(-16 * cs.VS, 10), cs.DIR_RIGHT, nil, cs.div(cs.MAX_NPC, 2))
			end
			cs.PlaySoundObject(cs.WAVE_POP, 1)
		end

		if cs.gBoss[1].act_wait == 200 or cs.CountArmsBulletAll(6) ~= 0 then
			cs.gBoss[1].ani_wait = 0
			cs.gBoss[1].act_no   = 70
			cs.PlaySoundObject(cs.WAVE_BAIT, 1)
		end
	elseif cs.gBoss[1].act_no == 70 then
		-- 閉口
		cs.gBoss[1].ani_wait = cs.gBoss[1].ani_wait + 1
		if cs.gBoss[1].ani_wait > 2 then
			cs.gBoss[1].ani_wait = 0
			cs.gBoss[1].ani_no = cs.gBoss[1].ani_no - 1
		end
		if cs.gBoss[1].ani_no == 1 then
			cs.gBoss[1].damage = 20
		end
		if cs.gBoss[1].ani_no == 0 then
			cs.PlaySoundObject(cs.WAVE_BAIT, 0)
			cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			cs.gBoss[1].act_no   = 80
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].bits = cs.gBoss[1].bits & ~cs.BITS_BANISH_DAMAGE
			cs.gBoss[1].hit.front  = 24 * cs.VS
			cs.gBoss[1].hit.back   = 24 * cs.VS

			cs.gBoss[6].hit.top  = 36 * cs.VS
			cs.gBoss[1].damage  = 0
		end
	elseif cs.gBoss[1].act_no == 80 then
		-- 待機
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait == 48 then
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].act_no   = 90
		end
	elseif cs.gBoss[1].act_no == 90 then
		-- 地震沈没
		cs.SetQuake(2)
		cs.gBoss[1].y = cs.gBoss[1].y + cs.VS
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.mod(cs.gBoss[1].act_wait, 4) == 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		end
		if cs.gBoss[1].act_wait == 48 then
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].act_no   = 100
		end
	elseif cs.gBoss[1].act_no == 100 then
		-- 待機
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait == 120 then
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].act_no   = 30
			cs.gBoss[1].x = cs.gBoss[1].tgt_x + cs.Random(-64, 64) * cs.VS
			cs.gBoss[1].y = cs.gBoss[1].tgt_y
		end
--------------------------------------
	elseif cs.gBoss[1].act_no == 110 then
		-- 開口→待機
		cs.gBoss[1].ani_wait = cs.gBoss[1].ani_wait + 1
		if cs.gBoss[1].ani_wait > 2 then
			cs.gBoss[1].ani_wait = 0
			cs.gBoss[1].ani_no = cs.gBoss[1].ani_no + 1
		end
		if cs.gBoss[1].ani_no == 3 then
			cs.gBoss[1].act_no   = 120
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].hit.front  = 16 * cs.VS
			cs.gBoss[1].hit.back   = 16 * cs.VS
		end
	elseif cs.gBoss[1].act_no == 120 then
		-- 開きっぱなし
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait == 50 or cs.CountArmsBulletAll(6) ~= 0 then
			cs.gBoss[1].act_no   = 130
			cs.PlaySoundObject(cs.WAVE_BAIT, 1)
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].ani_wait = 0
		end
		if cs.gBoss[1].act_wait < 30 and cs.mod(cs.gBoss[1].act_wait, 5) == 0 then
			cs.SetNpChar(48, cs.gBoss[1].x, cs.gBoss[1].y - 16 * cs.VS, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.div(-16 * cs.VS, 10), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_POP, 1)
		end
	elseif cs.gBoss[1].act_no == 130 then
		-- 閉口 →ジャンプ
		cs.gBoss[1].ani_wait = cs.gBoss[1].ani_wait + 1
		if cs.gBoss[1].ani_wait > 2 then
			cs.gBoss[1].ani_wait = 0
			cs.gBoss[1].ani_no = cs.gBoss[1].ani_no - 1
		end
		if cs.gBoss[1].ani_no == 1 then
			cs.gBoss[1].damage = 20
		end
		if cs.gBoss[1].ani_no == 0 then
			cs.gBoss[1].act_no   = 140
			cs.gBoss[1].bits = cs.gBoss[1].bits | cs.BITS_BANISH_DAMAGE
			cs.gBoss[1].hit.front  = 16 * cs.VS
			cs.gBoss[1].hit.back   = 16 * cs.VS
			--jump
			cs.gBoss[1].ym = -cs.MAX_MOVE
			cs.PlaySoundObject(cs.WAVE_BAIT,   0)
			cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			cs.PlaySoundObject(cs.WAVE_BUNRET, 1)
			cs.NpCharSetNearestXTargetMC(cs.gBoss[1])
			if cs.gBoss[1].x < cs.gMC[1 + cs.gBoss[1].tgt_mc].x then
				cs.gBoss[1].xm = cs.div(cs.VS, 2)
			end
			if cs.gBoss[1].x > cs.gMC[1 + cs.gBoss[1].tgt_mc].x then
				cs.gBoss[1].xm = cs.div(-cs.VS, 2)
			end
			cs.gBoss[1].damage   = 0
			cs.gBoss[6].hit.top  = 36 * cs.VS
		end
	elseif cs.gBoss[1].act_no == 140 then
		-- 滞空
		for mc_no = 0, cs.gNumMyChar - 1 do
			if cs.gMC[1 + mc_no].flag & cs.FLAG_HIT_BOTTOM ~= 0 and cs.gBoss[1].ym > 0 then
				cs.gBoss[6].damage_mc[1 + mc_no] = 20
			else
				cs.gBoss[6].damage_mc[1 + mc_no] =  0
			end
		end

		cs.gBoss[1].ym = cs.gBoss[1].ym + cs.div(cs.VS, 14)
		if cs.gBoss[1].ym > cs.MAX_MOVE then
			cs.gBoss[1].ym = cs.MAX_MOVE
		end
		cs.gBoss[1].y = cs.gBoss[1].y + cs.gBoss[1].ym
		cs.gBoss[1].x = cs.gBoss[1].x + cs.gBoss[1].xm
		if cs.gBoss[1].flag & cs.FLAG_HIT_BOTTOM ~= 0 then
			cs.gBoss[1].act_no   = 110
			cs.gBoss[1].act_wait = 0
			cs.gBoss[1].ani_wait = 0
			cs.gBoss[6].hit.top  = 16 * cs.VS
			for mc_no = 0, cs.gNumMyChar - 1 do
				cs.gBoss[6].damage_mc[1 + mc_no] = 0
			end
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.PlaySoundObject(cs.WAVE_BREAK1, 1)

			cs.SetQuake(30)
		end
	elseif cs.gBoss[1].act_no == 150 then
		-- やられ-------
		cs.gBoss[1].bits = cs.gBoss[1].bits & ~cs.BITS_BANISH_DAMAGE
		cs.SetQuake(2)
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.mod(cs.gBoss[1].act_wait, 12) == 0 then
			cs.PlaySoundObject(cs.WAVE_NPC_LARGE, 1)
		end
		cs.SetDestroyNpChar(cs.gBoss[1].x + cs.Random(-48, 48) * cs.VS, cs.gBoss[1].y + cs.Random(-48, 24) * cs.VS, 1, 1)
		if cs.gBoss[1].act_wait > 50 * 2 then
			cs.gBoss[1].act_wait =  0
			cs.gBoss[1].act_no   = 160
			cs.SetFlash(cs.gBoss[1].x, cs.gBoss[1].y, cs.FLASHMODE_EXPLOSION)
			cs.PlaySoundObject(cs.WAVE_EXPLOSION, 1)
		end
	elseif cs.gBoss[1].act_no == 160 then
		cs.gBoss[1].bits = cs.gBoss[1].bits & ~cs.BITS_BANISH_DAMAGE
		cs.SetQuake(40)
		cs.gBoss[1].act_wait = cs.gBoss[1].act_wait + 1
		if cs.gBoss[1].act_wait > 50 then
			cs.gBoss[1].cond = 0
			cs.gBoss[2].cond = 0
			cs.gBoss[3].cond = 0
			cs.gBoss[4].cond = 0
			cs.gBoss[5].cond = 0
			cs.gBoss[6].cond = 0
		end
	end

	local rect = {
		{left =   0, top =   0, right =  80, bottom =  56},
		{left =  80, top =   0, right = 160, bottom =  56},
		{left = 160, top =   0, right = 240, bottom =  56},
		{left =  80, top =   0, right = 160, bottom =  56},
	}

	cs.gBoss[1].rect = rect[1 + cs.gBoss[1].ani_no]

	cs.gBoss[2].shock = cs.gBoss[1].shock
	cs.gBoss[3].shock = cs.gBoss[1].shock
	cs.gBoss[4].shock = cs.gBoss[1].shock
	cs.gBoss[5].shock = cs.gBoss[1].shock

	--そのほか。
	ActBoss01_34()
	ActBoss01_12()
	ActBoss01_5()

	-- やられ
	if cs.gBoss[1].life == 0 and cs.gBoss[1].act_no < 150 then
		cs.gBoss[1].act_no = 150
		cs.gBoss[1].act_wait = 0
		cs.gBoss[1].damage = 0
		for mc_no = 0, cs.gNumMyChar - 1 do
			cs.gBoss[6].damage_mc[1 + mc_no] = 0
		end

		cs.DeleteNpCharCode(48, true)
	end
end

return ActBossChar_Omega
