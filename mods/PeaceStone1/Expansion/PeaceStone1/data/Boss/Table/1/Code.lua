-- ひざ (knee)
local function ActBoss01_12()
	local rcLeft = {
		{left =  80, top =  56, right = 104, bottom =  72},
	}
	local rcRight = {
		{left = 104, top =  56, right = 128, bottom =  72},
	}

	for i = 1, 2 do
		local boss = cs.gBoss[1 + i]   -- gBoss[1], gBoss[2]
		local boss0 = cs.gBoss[1]      -- gBoss[0]
		local boss2 = cs.gBoss[1 + (i + 2)]  -- gBoss[3] (i=1时 gBoss[4])? 原C++: gBoss[i].y = (gBoss[0].y + gBoss[i+2].y - 8*0x200)/2
		boss.y = cs.div(boss0.y + cs.gBoss[1 + (i + 2)].y - 8 * cs.VS, 2)

		if boss.direct == 0 then  -- DIR_LEFT
			boss.x = boss0.x - 16 * cs.VS
			boss.rect = rcLeft[1 + boss.ani_no]
		else
			boss.x = boss0.x + 16 * cs.VS
			boss.rect = rcRight[1 + boss.ani_no]
		end
	end
end

-- つま先 (toes)
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
		local boss = cs.gBoss[1 + i]   -- gBoss[3], gBoss[4]
		local boss0 = cs.gBoss[1]

		if boss.act_no == 0 then
			boss.act_no = 1
			-- fallthrough
		end

		if boss.act_no == 1 then
			boss.y = boss0.y
			if i == 3 then
				boss.x = boss0.x - 16 * cs.VS
			end
			if i == 4 then
				boss.x = boss0.x + 16 * cs.VS
			end
		elseif boss.act_no == 3 then
			boss.tgt_y = boss0.y + 24 * cs.VS
			if i == 3 then
				boss.x = boss0.x - 16 * cs.VS
			end
			if i == 4 then
				boss.x = boss0.x + 16 * cs.VS
			end
			boss.y = boss.y + cs.div(boss.tgt_y - boss.y, 2)
		end

		-- アニメーション
		if (boss.flag & 8) ~= 0 or boss.y <= boss.tgt_y then
			boss.ani_no = 0
		else
			boss.ani_no = 1
		end

		if boss.direct == 0 then
			boss.rect = rcLeft[1 + boss.ani_no]
		else
			boss.rect = rcRight[1 + boss.ani_no]
		end
	end
end

-- マイキャラ辺り判定 (player collision)
local function ActBoss01_5()
	local boss = cs.gBoss[6]   -- gBoss[5]
	local boss0 = cs.gBoss[1]

	if boss.act_no == 0 then
		boss.bits = (boss.bits or 0) | (cs.BITS_BLOCK_MYCHAR | cs.BITS_THROW_BLOCK)
		boss.hit.front = 20 * cs.VS
		boss.hit.top   = 36 * cs.VS
		boss.hit.back  = 20 * cs.VS
		boss.hit.bottom = 16 * cs.VS
		boss.act_no = 1
		-- fallthrough
	end

	if boss.act_no == 1 then
		boss.x = boss0.x
		boss.y = boss0.y
	end
end

-- Omega boss main
function ActBossChar_Omega()
	local boss = cs.gBoss[1]   -- gBoss[0]

	if boss.act_no == 0 then
		-- 初期設定
		boss.x = 219 * cs.VS * cs.PARTSSIZE
		boss.y = 16 * cs.VS * cs.PARTSSIZE
		boss.view.front = 40 * cs.VS
		boss.view.top   = 40 * cs.VS
		boss.view.back  = 40 * cs.VS
		boss.view.bottom = 16 * cs.VS
		boss.tgt_x = boss.x
		boss.tgt_y = boss.y
		boss.hit_voice = cs.WAVE_NPC_LARGE
		boss.hit.front = 8 * cs.VS
		boss.hit.top   = 24 * cs.VS
		boss.hit.back  = 8 * cs.VS
		boss.hit.bottom = 16 * cs.VS
		boss.bits = cs.BITS_THROW_BLOCK | cs.BITS_EVENT_BREAK | cs.BITS_VIEWDAMAGE
		boss.size = cs.NPCSIZE_LARGE
		boss.exp = 1
		boss.code_event = 210
		boss.life = 400

		-- ひざ (knees)
		cs.gBoss[2].cond = cs.COND_ALIVE
		cs.gBoss[2].view.front = 12 * cs.VS
		cs.gBoss[2].view.top   = 8 * cs.VS
		cs.gBoss[2].view.back  = 12 * cs.VS
		cs.gBoss[2].view.bottom = 8 * cs.VS
		cs.gBoss[2].bits = cs.BITS_THROW_BLOCK

		cs.gBoss[3] = cs.gBoss[2]   -- gBoss[2]
		cs.gBoss[2].direct = 0      -- LEFT
		cs.gBoss[3].direct = 2      -- RIGHT

		-- 足 (feet)
		cs.gBoss[4].cond = cs.COND_ALIVE
		cs.gBoss[4].view.front = 24 * cs.VS
		cs.gBoss[4].view.top   = 16 * cs.VS
		cs.gBoss[4].view.back  = 16 * cs.VS
		cs.gBoss[4].view.bottom = 16 * cs.VS
		cs.gBoss[4].hit_voice = cs.WAVE_NPC_LARGE
		cs.gBoss[4].hit.front = 8 * cs.VS
		cs.gBoss[4].hit.top   = 8 * cs.VS
		cs.gBoss[4].hit.back  = 8 * cs.VS
		cs.gBoss[4].hit.bottom = 8 * cs.VS
		cs.gBoss[4].bits = cs.BITS_THROW_BLOCK

		cs.gBoss[4].x = boss.x - 16 * cs.VS
		cs.gBoss[4].y = boss.y
		cs.gBoss[4].direct = 0

		cs.gBoss[5] = cs.gBoss[4]   -- gBoss[4]
		cs.gBoss[5].direct = 2
		cs.gBoss[5].x = boss.x + 16 * cs.VS   -- 注意原C++中 gBoss[3].x = gBoss[0].x + 16*0x200，这里gBoss[5]对应C++的gBoss[4]（索引4），但在C++中gBoss[3]是左足，gBoss[4]是右足；为了对应，左足用gBoss[4]，右足用gBoss[5]
		-- 但原C++中左足是gBoss[3]（索引3），右足是gBoss[4]（索引4）。这里我们已用cs.gBoss[4]为左足，cs.gBoss[5]为右足，正确。

		-- ボスブロック (collision block)
		cs.gBoss[6].cond = cs.COND_ALIVE

	elseif boss.act_no == 20 then
		boss.act_no = 30
		boss.act_wait = 0
		boss.ani_no = 0
		-- fallthrough
	end

	if boss.act_no == 30 then
		cs.SetQuake(2)
		boss.y = boss.y - cs.VS
		boss.act_wait = boss.act_wait + 1
		if cs.mod(boss.act_wait, 4) == 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		end
		if boss.act_wait == 48 then
			boss.act_wait = 0
			boss.act_no = 40
			if boss.life > 280 then
				-- 通常
			else
				boss.act_no = 110
				boss.bits = boss.bits | cs.BITS_BANISH_DAMAGE
				boss.bits = boss.bits & ~cs.BITS_THROW_BLOCK
				cs.gBoss[4].bits = cs.gBoss[4].bits & ~cs.BITS_THROW_BLOCK   -- 左足
				cs.gBoss[5].bits = cs.gBoss[5].bits & ~cs.BITS_THROW_BLOCK   -- 右足
				cs.gBoss[4].act_no = 3
				cs.gBoss[5].act_no = 3
				cs.gBoss[6].hit.top = 16 * cs.VS
			end
		end
	elseif boss.act_no == 40 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait == 48 then
			boss.act_wait = 0
			boss.act_no = 50
			boss.ani_wait = 0   -- count1? 原C++使用count1作为动画计时，这里用ani_wait
			cs.gBoss[6].hit.top = 16 * cs.VS
			cs.PlaySoundObject(cs.WAVE_BAIT, 1)
		end
	elseif boss.act_no == 50 then
		boss.ani_wait = (boss.ani_wait or 0) + 1
		if boss.ani_wait > 2 then
			boss.ani_wait = 0
			boss.count2 = (boss.count2 or 0) + 1   -- 动画帧计数
		end
		if boss.count2 == 3 then
			boss.act_no = 60
			boss.act_wait = 0
			boss.bits = boss.bits | cs.BITS_BANISH_DAMAGE
			boss.hit.front = 16 * cs.VS
			boss.hit.back  = 16 * cs.VS
		end
	elseif boss.act_no == 60 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 20 and boss.act_wait < 80 and cs.mod(boss.act_wait, 3) == 0 then
			if cs.Random(0, 9) < 8 then
				cs.SetNpChar(48, boss.x, boss.y - 16 * cs.VS, cs.Random(cs.div(-cs.VS, 2), cs.div(cs.VS, 2)), cs.div(-16 * cs.VS, 10), 0, nil, cs.div(cs.MAX_NPC, 2))
			else
				cs.SetNpChar(48, boss.x, boss.y - 16 * cs.VS, cs.Random(cs.div(-cs.VS, 2), cs.div(cs.VS, 2)), cs.div(-16 * cs.VS, 10), 2, nil, cs.div(cs.MAX_NPC, 2))
			end
			cs.PlaySoundObject(cs.WAVE_POP, 1)
		end
		if boss.act_wait == 200 or cs.CountArmsBulletAll(6) ~= 0 then
			boss.ani_wait = 0   -- count1
			boss.act_no = 70
			cs.PlaySoundObject(cs.WAVE_BAIT, 1)
		end
	elseif boss.act_no == 70 then
		boss.ani_wait = (boss.ani_wait or 0) + 1
		if boss.ani_wait > 2 then
			boss.ani_wait = 0
			boss.count2 = (boss.count2 or 0) - 1
		end
		if boss.count2 == 1 then
			boss.damage = 20
		end
		if boss.count2 == 0 then
			cs.PlaySoundObject(cs.WAVE_BAIT, 0)
			cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			boss.act_no = 80
			boss.act_wait = 0
			boss.bits = boss.bits & ~cs.BITS_BANISH_DAMAGE
			boss.hit.front = 24 * cs.VS
			boss.hit.back  = 24 * cs.VS
			cs.gBoss[6].hit.top = 36 * cs.VS
			boss.damage = 0
		end
	elseif boss.act_no == 80 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait == 48 then
			boss.act_wait = 0
			boss.act_no = 90
		end
	elseif boss.act_no == 90 then
		cs.SetQuake(2)
		boss.y = boss.y + cs.VS
		boss.act_wait = boss.act_wait + 1
		if cs.mod(boss.act_wait, 4) == 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
		end
		if boss.act_wait == 48 then
			boss.act_wait = 0
			boss.act_no = 100
		end
	elseif boss.act_no == 100 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait == 120 then
			boss.act_wait = 0
			boss.act_no = 30
			boss.x = boss.tgt_x + cs.Random(-64, 64) * cs.VS
			boss.y = boss.tgt_y
		end
	elseif boss.act_no == 110 then
		boss.ani_wait = (boss.ani_wait or 0) + 1
		if boss.ani_wait > 2 then
			boss.ani_wait = 0
			boss.count2 = (boss.count2 or 0) + 1
		end
		if boss.count2 == 3 then
			boss.act_no = 120
			boss.act_wait = 0
			boss.hit.front = 16 * cs.VS
			boss.hit.back  = 16 * cs.VS
		end
	elseif boss.act_no == 120 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait == 50 or cs.CountArmsBulletAll(6) ~= 0 then
			boss.act_no = 130
			cs.PlaySoundObject(cs.WAVE_BAIT, 1)
			boss.act_wait = 0
			boss.ani_wait = 0   -- count1
		end
		if boss.act_wait < 30 and cs.mod(boss.act_wait, 5) == 0 then
			cs.SetNpChar(48, boss.x, boss.y - 16 * cs.VS, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.div(-16 * cs.VS, 10), 0, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_POP, 1)
		end
	elseif boss.act_no == 130 then
		boss.ani_wait = (boss.ani_wait or 0) + 1
		if boss.ani_wait > 2 then
			boss.ani_wait = 0
			boss.count2 = (boss.count2 or 0) - 1
		end
		if boss.count2 == 1 then
			boss.damage = 20
		end
		if boss.count2 == 0 then
			boss.act_no = 140
			boss.bits = boss.bits | cs.BITS_BANISH_DAMAGE
			boss.hit.front = 16 * cs.VS
			boss.hit.back  = 16 * cs.VS
			boss.ym = -cs.MAX_MOVE
			cs.PlaySoundObject(cs.WAVE_BAIT, 0)
			cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			cs.PlaySoundObject(cs.WAVE_BUNRET, 1)
			cs.NpCharSetNearestXTargetMC(boss)
			if boss.x < cs.gMC[1 + boss.tgt_mc].x then
				boss.xm = cs.div(cs.VS, 2)
			end
			if boss.x > cs.gMC[1 + boss.tgt_mc].x then
				boss.xm = cs.div(-cs.VS, 2)
			end
			boss.damage = 0
			cs.gBoss[6].hit.top = 36 * cs.VS
		end
	elseif boss.act_no == 140 then
		-- 着地ダメージ
		for mc_no = 0, cs.gNumMyChar - 1 do
			local player = cs.gMC[1 + mc_no]
			if (player.flag & 8) ~= 0 and boss.ym > 0 then
				cs.gBoss[6].damage_mc[1 + mc_no] = 20
			else
				cs.gBoss[6].damage_mc[1 + mc_no] = 0
			end
		end

		boss.ym = boss.ym + cs.div(cs.VS, 14)   -- 0x24? 原C++ 0x24 = 36, 36/0x200 = 36/512 ≈ 0.0703, 但cs.div(cs.VS,14)约等于 0x200/14≈36.57，接近。
		if boss.ym > cs.MAX_MOVE then
			boss.ym = cs.MAX_MOVE
		end
		boss.x = boss.x + boss.xm
		boss.y = boss.y + boss.ym
		if (boss.flag & 8) ~= 0 then
			boss.act_no = 110
			boss.act_wait = 0
			boss.ani_wait = 0
			cs.gBoss[6].hit.top = 16 * cs.VS
			for mc_no = 0, cs.gNumMyChar - 1 do
				cs.gBoss[6].damage_mc[1 + mc_no] = 0
			end
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.PlaySoundObject(cs.WAVE_BREAK1, 1)
			cs.SetQuake(30)
		end
	elseif boss.act_no == 150 then
		boss.bits = boss.bits & ~cs.BITS_BANISH_DAMAGE
		cs.SetQuake(2)
		boss.act_wait = boss.act_wait + 1
		if cs.mod(boss.act_wait, 12) == 0 then
			cs.PlaySoundObject(cs.WAVE_NPC_LARGE, 1)
		end
		cs.SetDestroyNpChar(boss.x + cs.Random(-48, 48) * cs.VS, boss.y + cs.Random(-48, 24) * cs.VS, 1, 1)
		if boss.act_wait > 100 then
			boss.act_wait = 0
			boss.act_no = 160
			cs.SetFlash(boss.x, boss.y, 0)   -- FLASH_MODE_EXPLOSION
			cs.PlaySoundObject(cs.WAVE_EXPLOSION, 1)
		end
	elseif boss.act_no == 160 then
		boss.bits = boss.bits & ~cs.BITS_BANISH_DAMAGE
		cs.SetQuake(40)
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 50 then
			boss.cond = 0
			cs.gBoss[2].cond = 0
			cs.gBoss[3].cond = 0
			cs.gBoss[4].cond = 0
			cs.gBoss[5].cond = 0
			cs.gBoss[6].cond = 0
		end
	end

	-- 矩形
	local rect = {
		{left =   0, top =   0, right =  80, bottom =  56},
		{left =  80, top =   0, right = 160, bottom =  56},
		{left = 160, top =   0, right = 240, bottom =  56},
		{left =  80, top =   0, right = 160, bottom =  56},
	}
	boss.rect = rect[1 + (boss.count2 or 0)]

	-- 同期 shock
	cs.gBoss[2].shock = boss.shock
	cs.gBoss[3].shock = boss.shock
	cs.gBoss[4].shock = boss.shock
	cs.gBoss[5].shock = boss.shock

	-- 子部品更新
	ActBoss01_34()
	ActBoss01_12()
	ActBoss01_5()

	-- 死亡処理
	if boss.life == 0 and boss.act_no < 150 then
		boss.act_no = 150
		boss.act_wait = 0
		boss.damage = 0
		for mc_no = 0, cs.gNumMyChar - 1 do
			cs.gBoss[6].damage_mc[1 + mc_no] = 0
		end
		cs.DeleteNpCharCode(48, true)
	end
end

return ActBossChar_Omega