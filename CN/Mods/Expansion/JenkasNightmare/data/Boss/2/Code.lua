local function ActBossChar02_01()
	local boss
	local minus

	if cs.gBoss[1].direct == cs.DIR_LEFT then
		minus =  1
	else
		minus = -1
	end

	boss = cs.gBoss[2]

	if cs.gBoss[1].ani_no == 0 then
		-- 無機?
		boss.hit_voice   = cs.WAVE_NPC_LARGE
		boss.hit.front   = 16 * cs.VS
		boss.hit.top     = 16 * cs.VS
		boss.hit.back    = 16 * cs.VS
		boss.hit.bottom  = 16 * cs.VS
		boss.size = cs.NPCSIZE_LARGE
		boss.bits = cs.BITS_BLOCK_BULLET
	elseif cs.gBoss[1].ani_no == 1 then
		-- ノーマル
		boss.x = minus * (-24 * cs.VS) + cs.gBoss[1].x
		boss.y =         (-24 * cs.VS) + cs.gBoss[1].y
	elseif cs.gBoss[1].ani_no == 2 then
		-- 伏せ
		boss.x = minus * (-24 * cs.VS) + cs.gBoss[1].x
		boss.y =         (-20 * cs.VS) + cs.gBoss[1].y
	elseif cs.gBoss[1].ani_no == 3 or cs.gBoss[1].ani_no == 4 then
		-- 開口
		boss.x = minus * (-24 * cs.VS) + cs.gBoss[1].x
		boss.y =         (-16 * cs.VS) + cs.gBoss[1].y
	elseif cs.gBoss[1].ani_no == 5 then
		-- ジャンプ
		boss.x = minus * (-24 * cs.VS) + cs.gBoss[1].x
		boss.y =         (-43 * cs.VS) + cs.gBoss[1].y
	end
end

local function ActBossChar02_02()
	local boss

	boss = cs.gBoss[3]

	if cs.gBoss[1].ani_no == 0 then
		-- 無機?
		boss.hit_voice   = cs.WAVE_NPC_LARGE
		boss.hit.front   = 24 * cs.VS
		boss.hit.top     = 16 * cs.VS
		boss.hit.back    = 24 * cs.VS
		boss.hit.bottom  = 16 * cs.VS
		boss.size = cs.NPCSIZE_LARGE
		boss.bits = cs.BITS_BLOCK_BULLET
	elseif cs.gBoss[1].ani_no == 1 or cs.gBoss[1].ani_no == 2 or cs.gBoss[1].ani_no == 3 or cs.gBoss[1].ani_no == 4 or cs.gBoss[1].ani_no == 5 then
		-- ノーマル - Fred: Describes 'ani_no == 1'.
		-- 伏せ   - Fred: Describes 'ani_no == 2'.
		-- 開口   - Fred: Describes 'ani_no == 3 or ani_no == 4'.
		-- ジャンプ - Fred: Describes 'ani_no == 5'.
		boss.x      = cs.gBoss[1].x
		boss.y      = cs.gBoss[1].y
	end
end

local function ActBossChar_Frog()
	local deg
	local xm
	local ym

	local rcLeft = {
		{left =   0, top =   0, right =   0, bottom =   0},
		{left =   0, top =  48, right =  80, bottom = 112},
		{left =   0, top = 112, right =  80, bottom = 176},
		{left =   0, top = 176, right =  80, bottom = 240},
		{left = 160, top =  48, right = 240, bottom = 112}, -- Shock!
		{left = 160, top = 112, right = 240, bottom = 200}, -- ジャンプ
		{left = 200, top =   0, right = 240, bottom =  24}, --6 白目

		{left =  80, top =   0, right = 120, bottom =  24}, --7 銀かがみ
		{left = 120, top =   0, right = 160, bottom =  24}, --8 銀ジャンプ
	}

	local rcRight = {
		{left =   0, top =   0, right =   0, bottom =   0},
		{left =  80, top =  48, right = 160, bottom = 112},
		{left =  80, top = 112, right = 160, bottom = 176},
		{left =  80, top = 176, right = 160, bottom = 240},
		{left = 240, top =  48, right = 320, bottom = 112}, -- Shock!
		{left = 240, top = 112, right = 320, bottom = 200}, -- ジャンプ
		{left = 200, top =  24, right = 240, bottom =  48}, --6 白目

		{left =  80, top =  24, right = 120, bottom =  48}, --7 銀かがみ
		{left = 120, top =  24, right = 160, bottom =  48}, --8 銀ジャンプ
	}

	local boss

	boss = cs.gBoss[1]

	if boss.act_no == 0 or boss.act_no == 1 then
		-- 初期設定
		if boss.act_no == 0 then
			boss.x =  9 * cs.VS * cs.PARTSSIZE
			boss.y = 12 * cs.VS * cs.PARTSSIZE + cs.VS * 8
			boss.direct = cs.DIR_RIGHT
			boss.view.front  = 48 * cs.VS
			boss.view.top    = 48 * cs.VS
			boss.view.back   = 32 * cs.VS
			boss.view.bottom = 16 * cs.VS
			boss.hit_voice   = cs.WAVE_NPC_LARGE
			boss.hit.front   = 24 * cs.VS
			boss.hit.top     = 16 * cs.VS
			boss.hit.back    = 24 * cs.VS
			boss.hit.bottom  = 16 * cs.VS
			boss.size        = cs.NPCSIZE_LARGE
			boss.exp         = 1

			boss.code_event = 1000
			boss.bits       = boss.bits | (cs.BITS_EVENT_BREAK | cs.BITS_VIEWDAMAGE)

			boss.life = 400
		end

		-- 待機
	elseif boss.act_no == 10 or boss.act_no == 11 then
		-- 待機
		if boss.act_no == 10 then
			boss.act_no = 11
			boss.ani_no = 3
			boss.cond = cs.COND_ALIVE
			boss.rect = rcRight[1]
--			boss->act_no = 100;

			cs.gBoss[2].cond = cs.COND_ALIVE | cs.COND_ZEROINDEXDAMAGE
			cs.gBoss[2].code_event = 1000
			cs.gBoss[3].cond = cs.COND_ALIVE
			cs.gBoss[2].damage = 5
			cs.gBoss[3].damage = 5
			for i = 0, 7 do
				cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
		end
	elseif boss.act_no == 20 or boss.act_no == 21 then
		-- 登場点滅
		if boss.act_no == 20 then
			boss.act_no   = 21
			boss.act_wait = 0
		end

		boss.act_wait = boss.act_wait + 1
		if cs.mod(cs.div(boss.act_wait, 2), 2) ~= 0 then
			boss.ani_no = 3
		else
			boss.ani_no = 0
		end
--		if boss.act_wait > 50 then
--			boss.act_no = 10
--		end
	-- ピョンピョン ===================
	elseif boss.act_no == 100 or boss.act_no == 101 then
		-- 待機
		if boss.act_no == 100 then
			boss.act_no   = 101
			boss.act_wait =   0
			boss.ani_no   =   1
			boss.xm       =   0
--			boss.bits = cs.BITS_BLOCK_BULLET;
		end

		-- 停止
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 50 then
			boss.act_no   = 102
			boss.ani_wait =  0
			boss.ani_no   =  2
		end
	elseif boss.act_no == 102 then
		-- かがみ
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 10 then
			boss.act_no   = 103
			boss.ani_wait =  0
			boss.ani_no   =  1
		end
	elseif boss.act_no == 103 then
		-- to Jump
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 4 then
			boss.act_no = 104
			boss.ani_no =   5
			boss.ym     = -cs.VS * 2
			cs.PlaySoundObject(cs.WAVE_BUNRET, 1)
			if boss.direct == cs.DIR_LEFT then
				boss.xm = -cs.VS
			else
				boss.xm =  cs.VS
			end
			boss.view.top    = 64 * cs.VS
			boss.view.bottom = 24 * cs.VS
		end
	elseif boss.act_no == 104 then
		-- 滞空
		if boss.direct == cs.DIR_LEFT and boss.flag & cs.FLAG_HIT_LEFT ~= 0 then
			-- ■←
			boss.direct = cs.DIR_RIGHT
			boss.xm = cs.VS
		end
		if boss.direct == cs.DIR_RIGHT and boss.flag & cs.FLAG_HIT_RIGHT ~= 0 then
			-- ■←
			boss.direct = cs.DIR_LEFT
			boss.xm = -cs.VS
		end
		-- 着陸
		if boss.flag & cs.FLAG_HIT_BOTTOM ~= 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.SetQuake(30)
			boss.act_no      = 100
			boss.ani_no      = 1
			boss.view.top    = 48 * cs.VS
			boss.view.bottom = 16 * cs.VS
			local turned = 0
			for mc_no = 0, cs.gNumMyChar - 1 do
				if boss.direct == cs.DIR_LEFT and boss.x < cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
				if boss.direct == cs.DIR_RIGHT and boss.x > cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
			end

			if turned >= cs.gNumMyChar then
				-- all players are on the other side
				boss.act_no = 110
				boss.direct = boss.direct == cs.DIR_LEFT and cs.DIR_RIGHT or cs.DIR_LEFT
			end
			cs.SetNpChar(110, cs.PARTSSIZE * cs.VS * cs.Random(7, 19), cs.PARTSSIZE * cs.VS * cs.Random(0, 4), 0, 0, 4, nil, cs.div(cs.MAX_NPC, 4))
			for i = 0, 3 do
				cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + boss.hit.bottom, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
		end
	-- 泡吐き ==============================
	elseif boss.act_no == 110 or boss.act_no == 111 then
		-- 口開く
		if boss.act_no == 110 then
			boss.ani_no   = 1
			boss.act_wait = 0
			boss.act_no   = 111
		end

		boss.act_wait = boss.act_wait + 1
		boss.xm = cs.div(boss.xm * 8, 9)
		if boss.act_wait > 50 then
			boss.ani_no   = 2
			boss.ani_wait = 0
			boss.act_no   = 112
		end
	elseif boss.act_no == 112 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 4 then
			boss.act_no      = 113
			boss.act_wait    =  0
			boss.ani_no      =  3
			boss.count1      = 16
			cs.gBoss[2].bits = cs.gBoss[2].bits | cs.BITS_BANISH_DAMAGE
			boss.tgt_x       = boss.life
		end
	elseif boss.act_no == 113 then
		-- ダメージ点滅
		if boss.shock ~= 0 then
			if cs.mod(cs.div(boss.count2, 2), 2) ~= 0 then
				boss.ani_no = 4
			else
				boss.ani_no = 3
			end
			boss.count2 = boss.count2 + 1
		else
			boss.count2 = 0
			boss.ani_no = 3
		end

		boss.xm = cs.div(boss.xm * 10, 11)
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 16 then
			boss.act_wait = 0
			boss.count1 = boss.count1 - 1
			local mc_no = cs.mod(boss.count1, cs.gNumMyChar)
			if boss.direct == cs.DIR_LEFT then
				deg = cs.GetArktan(boss.x - 32 * cs.VS - cs.gMC[1 + mc_no].x, boss.y - 8 * cs.VS - cs.gMC[1 + mc_no].y)
			else
				deg = cs.GetArktan(boss.x + 32 * cs.VS - cs.gMC[1 + mc_no].x, boss.y - 8 * cs.VS - cs.gMC[1 + mc_no].y)
			end
			deg = deg + cs.Random(-16, 16) & 0xFF

			ym = cs.GetSin(deg) * 1
			xm = cs.GetCos(deg) * 1
			if boss.direct == cs.DIR_LEFT then
				cs.SetNpChar(108, boss.x - 32 * cs.VS, boss.y - 8 * cs.VS, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			else
				cs.SetNpChar(108, boss.x + 32 * cs.VS, boss.y - 8 * cs.VS, xm, ym, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end

			cs.PlaySoundObject(cs.WAVE_POP, 1)
			if boss.count1 == 0 or boss.life < boss.tgt_x - cs.bossHPMultiply(90) then
				boss.act_no = 114
				boss.act_wait = 0
				boss.ani_no = 2
				boss.ani_wait = 0
				cs.gBoss[2].bits = cs.gBoss[2].bits & ~cs.BITS_BANISH_DAMAGE
			end
		end
	elseif boss.act_no == 114 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 10 then
			cs.gBoss[2].count1 = cs.gBoss[2].count1 + 1
			if cs.gBoss[2].count1 > 2 then
				cs.gBoss[2].count1 = 0
				boss.act_no = 120
			else
				boss.act_no = 100
			end
			boss.ani_wait = 0
			boss.ani_no   = 1
		end
	-- カエルの雨 ========================
	elseif boss.act_no == 120 or boss.act_no == 121 then
		-- 待機
		if boss.act_no == 120 then
			boss.act_no   = 121
			boss.act_wait =   0
			boss.ani_no   =   1
			boss.xm       =   0
		end

		-- 停止
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 50 then
			boss.act_no   = 122
			boss.ani_wait =  0
			boss.ani_no   =  2
		end
	elseif boss.act_no == 122 then
		-- かがみ
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 20 then
			boss.act_no   = 123
			boss.ani_wait =  0
			boss.ani_no   =  1
		end
	elseif boss.act_no == 123 then
		-- to Jump
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 4 then
			boss.act_no = 124
			boss.ani_no =   5
			boss.ym     = -cs.VS * 5
			boss.view.top    = 64 * cs.VS
			boss.view.bottom = 24 * cs.VS
			cs.PlaySoundObject(cs.WAVE_BUNRET, 1)
		end
	elseif boss.act_no == 124 then
		-- 着陸
		if boss.flag & cs.FLAG_HIT_BOTTOM ~= 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.SetQuake(60)
			boss.act_no      = 100
			boss.ani_no      = 1
			boss.view.top    = 48 * cs.VS
			boss.view.bottom = 16 * cs.VS

			for i = 0, 1 do
				cs.SetNpChar(104, cs.PARTSSIZE * cs.VS * cs.Random(7, 19), cs.PARTSSIZE * cs.VS * cs.Random(0, 4), 0, 0, 4, nil, cs.div(cs.MAX_NPC, 4))
			end
			for i = 0, 5 do
				cs.SetNpChar(110, cs.PARTSSIZE * cs.VS * cs.Random(7, 19), cs.PARTSSIZE * cs.VS * cs.Random(0, 4), 0, 0, 4, nil, cs.div(cs.MAX_NPC, 4))
			end
			for i = 0, 7 do
				cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + boss.hit.bottom, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
			local turned = 0
			for mc_no = 0, cs.gNumMyChar - 1 do
				if boss.direct == cs.DIR_LEFT and boss.x < cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
				if boss.direct == cs.DIR_RIGHT and boss.x > cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
			end
			if turned >= cs.gNumMyChar then
				-- all players are on the other side
				boss.act_no = 110
				boss.direct = boss.direct == cs.DIR_LEFT and cs.DIR_RIGHT or cs.DIR_LEFT
			end
		end
	-- がたがた ========================
	elseif boss.act_no == 130 or boss.act_no == 131 then
		if boss.act_no == 130 then
			boss.act_no   = 131
			boss.ani_no   = 3
			boss.act_wait = 0
			boss.xm       = 0
			cs.PlaySoundObject(cs.WAVE_DESTROY_LARGE, 1)
			for i = 0, 7 do
				cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
			cs.gBoss[2].cond = 0
			cs.gBoss[3].cond = 0
		end

		--ぶるぶる
		boss.act_wait = boss.act_wait + 1
		if cs.mod(boss.act_wait, 5) == 0 then
			cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end

		if cs.mod(cs.div(boss.act_wait, 2), 2) ~= 0 then
			boss.x = boss.x - cs.VS
		else
			boss.x = boss.x + cs.VS
		end

		if boss.act_wait > 100 then
			boss.act_wait = 0
			boss.act_no   = 132
		end
	elseif boss.act_no == 132 then
		--ちいさく
		boss.act_wait = boss.act_wait + 1
		if cs.mod(cs.div(boss.act_wait, 2), 2) ~= 0 then
			boss.view.front  = 20 * cs.VS
			boss.view.top    = 12 * cs.VS
			boss.view.back   = 20 * cs.VS
			boss.view.bottom = 12 * cs.VS
			boss.ani_no = 6
		else
			boss.view.front  = 48 * cs.VS
			boss.view.top    = 48 * cs.VS
			boss.view.back   = 32 * cs.VS
			boss.view.bottom = 16 * cs.VS
			boss.ani_no = 3
		end

		if cs.mod(boss.act_wait, 9) == 0 then
			cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS, cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
		end

		if boss.act_wait > 150 then
			boss.act_no     = 140
			boss.hit.bottom = 12 * cs.VS
		end
	-- 落下/退散 ===================
	elseif boss.act_no == 140 or boss.act_no == 141 then
		if boss.act_no == 140 then
			boss.act_no = 141
		end

		if boss.flag & cs.FLAG_HIT_BOTTOM ~= 0 then
			boss.act_no = 142
			boss.act_wait = 0
			boss.ani_no = 7
		end
	elseif boss.act_no == 142 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 30 then
			boss.ani_no = 8
			boss.ym     = -5 * cs.VS
			boss.bits   = boss.bits | cs.BITS_THROW_BLOCK
			boss.act_no = 143
		end
	elseif boss.act_no == 143 then
		boss.ym     = -5 * cs.VS
		if boss.y < 0 then
			boss.cond = 0
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.SetQuake(30)
		end
	end

	-- 重力
	boss.ym = boss.ym + cs.div(cs.VS, 8)
	if boss.ym > cs.MAX_MOVE then
		boss.ym = cs.MAX_MOVE
	end

	boss.x = boss.x + boss.xm
	boss.y = boss.y + boss.ym

	-- RECT
	if boss.direct == cs.DIR_LEFT then
		boss.rect = rcLeft[ 1 + boss.ani_no]
	else
		boss.rect = rcRight[1 + boss.ani_no]
	end

	ActBossChar02_01()
	ActBossChar02_02()
end

return ActBossChar_Frog
