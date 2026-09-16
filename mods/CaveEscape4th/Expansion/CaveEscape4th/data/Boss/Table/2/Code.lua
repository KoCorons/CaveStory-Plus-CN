-- Balfrog Boss AI (C++ to Lua 直接转换，使用数字常量，无 cs.DIR_AUTO)
local function ActBossChar02_01()
	local boss
	local minus

	if cs.gBoss[1].direct == 0 then   -- DIR_LEFT = 0
		minus = 1
	else
		minus = -1
	end

	boss = cs.gBoss[2]

	if cs.gBoss[1].ani_no == 0 then
		boss.hit_voice = cs.WAVE_NPC_LARGE
		boss.hit.front = 16 * cs.VS
		boss.hit.top = 16 * cs.VS
		boss.hit.back = 16 * cs.VS
		boss.hit.bottom = 16 * cs.VS
		boss.size = cs.NPCSIZE_LARGE
		boss.bits = cs.BITS_BLOCK_BULLET
	elseif cs.gBoss[1].ani_no == 1 then
		boss.x = cs.gBoss[1].x + (-24 * cs.VS) * minus
		boss.y = cs.gBoss[1].y + (-24 * cs.VS)
	elseif cs.gBoss[1].ani_no == 2 then
		boss.x = cs.gBoss[1].x + (-24 * cs.VS) * minus
		boss.y = cs.gBoss[1].y + (-20 * cs.VS)
	elseif cs.gBoss[1].ani_no == 3 or cs.gBoss[1].ani_no == 4 then
		boss.x = cs.gBoss[1].x + (-24 * cs.VS) * minus
		boss.y = cs.gBoss[1].y + (-16 * cs.VS)
	elseif cs.gBoss[1].ani_no == 5 then
		boss.x = cs.gBoss[1].x + (-24 * cs.VS) * minus
		boss.y = cs.gBoss[1].y + (-43 * cs.VS)
	end
end

local function ActBossChar02_02()
	local boss = cs.gBoss[3]

	if cs.gBoss[1].ani_no == 0 then
		boss.hit_voice = cs.WAVE_NPC_LARGE
		boss.hit.front = 24 * cs.VS
		boss.hit.top = 16 * cs.VS
		boss.hit.back = 24 * cs.VS
		boss.hit.bottom = 16 * cs.VS
		boss.size = cs.NPCSIZE_LARGE
		boss.bits = cs.BITS_BLOCK_BULLET
	elseif cs.gBoss[1].ani_no == 1 or cs.gBoss[1].ani_no == 2 or cs.gBoss[1].ani_no == 3 or cs.gBoss[1].ani_no == 4 or cs.gBoss[1].ani_no == 5 then
		boss.x = cs.gBoss[1].x
		boss.y = cs.gBoss[1].y
	end
end

function ActBossChar_Frog()
	local deg, xm, ym
	local i

	local rcLeft = {
		{left =   0, top =   0, right =   0, bottom =   0},
		{left =   0, top =  48, right =  80, bottom = 112},
		{left =   0, top = 112, right =  80, bottom = 176},
		{left =   0, top = 176, right =  80, bottom = 240},
		{left = 160, top =  48, right = 240, bottom = 112},
		{left = 160, top = 112, right = 240, bottom = 200},
		{left = 200, top =   0, right = 240, bottom =  24},
		{left =  80, top =   0, right = 120, bottom =  24},
		{left = 120, top =   0, right = 160, bottom =  24},
	}
	local rcRight = {
		{left =   0, top =   0, right =   0, bottom =   0},
		{left =  80, top =  48, right = 160, bottom = 112},
		{left =  80, top = 112, right = 160, bottom = 176},
		{left =  80, top = 176, right = 160, bottom = 240},
		{left = 240, top =  48, right = 320, bottom = 112},
		{left = 240, top = 112, right = 320, bottom = 200},
		{left = 200, top =  24, right = 240, bottom =  48},
		{left =  80, top =  24, right = 120, bottom =  48},
		{left = 120, top =  24, right = 160, bottom =  48},
	}

	local boss = cs.gBoss[1]

	if boss.act_no == 0 then
		boss.x = 6 * cs.VS * 16
		boss.y = 12 * cs.VS * 16 + 8 * cs.VS
		boss.direct = 2   -- DIR_RIGHT
		boss.view.front = 48 * cs.VS
		boss.view.top = 48 * cs.VS
		boss.view.back = 32 * cs.VS
		boss.view.bottom = 16 * cs.VS
		boss.hit_voice = cs.WAVE_NPC_LARGE
		boss.hit.front = 24 * cs.VS
		boss.hit.top = 16 * cs.VS
		boss.hit.back = 24 * cs.VS
		boss.hit.bottom = 16 * cs.VS
		boss.size = cs.NPCSIZE_LARGE
		boss.exp = 1
		boss.code_event = 1000
		boss.bits = (boss.bits or 0) | (cs.BITS_EVENT_BREAK | cs.BITS_VIEWDAMAGE)
		boss.life = 300

	elseif boss.act_no == 10 then
		boss.act_no = 11
		boss.ani_no = 3
		boss.cond = cs.COND_ALIVE
		boss.rect = rcRight[1]

		cs.gBoss[2].cond = cs.COND_ALIVE | cs.COND_ZEROINDEXDAMAGE
		cs.gBoss[2].code_event = 1000
		cs.gBoss[3].cond = cs.COND_ALIVE
		cs.gBoss[2].damage = 5
		cs.gBoss[3].damage = 5

		for i = 0, 7 do
			cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS,
				cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0),
				0, nil, cs.div(cs.MAX_NPC, 2))
		end

	elseif boss.act_no == 20 then
		boss.act_no = 21
		boss.act_wait = 0
	end

	if boss.act_no == 21 then
		boss.act_wait = boss.act_wait + 1
		if cs.mod(cs.div(boss.act_wait, 2), 2) ~= 0 then
			boss.ani_no = 3
		else
			boss.ani_no = 0
		end

	elseif boss.act_no == 100 then
		boss.act_no = 101
		boss.act_wait = 0
		boss.ani_no = 1
		boss.xm = 0
	end

	if boss.act_no == 101 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 50 then
			boss.act_no = 102
			boss.ani_wait = 0
			boss.ani_no = 2
		end

	elseif boss.act_no == 102 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 10 then
			boss.act_no = 103
			boss.ani_wait = 0
			boss.ani_no = 1
		end

	elseif boss.act_no == 103 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 4 then
			boss.act_no = 104
			boss.ani_no = 5
			boss.ym = -2 * cs.VS
			cs.PlaySoundObject(25, 1)
			if boss.direct == 0 then
				boss.xm = -cs.VS
			else
				boss.xm = cs.VS
			end
			boss.view.top = 64 * cs.VS
			boss.view.bottom = 24 * cs.VS
		end

	elseif boss.act_no == 104 then
		if boss.direct == 0 and (boss.flag & 1) ~= 0 then
			boss.direct = 2
			boss.xm = cs.VS
		end
		if boss.direct == 2 and (boss.flag & 4) ~= 0 then
			boss.direct = 0
			boss.xm = -cs.VS
		end
		if (boss.flag & 8) ~= 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.SetQuake(30)
			boss.act_no = 100
			boss.ani_no = 1
			boss.view.top = 48 * cs.VS
			boss.view.bottom = 16 * cs.VS

			local turned = 0
			for mc_no = 0, cs.gNumMyChar - 1 do
				if boss.direct == 0 and boss.x < cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
				if boss.direct == 2 and boss.x > cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
			end
			if turned >= cs.gNumMyChar then
				boss.act_no = 110
				boss.direct = (boss.direct == 0) and 2 or 0
			end

			cs.SetNpChar(110, cs.Random(4, 16) * cs.VS * 16, cs.Random(0, 4) * cs.VS * 16, 0, 0, 4, nil, cs.div(cs.MAX_NPC, 4))
			for i = 0, 3 do
				cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + boss.hit.bottom,
					cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0),
					0, nil, cs.div(cs.MAX_NPC, 2))
			end
		end

	elseif boss.act_no == 110 then
		boss.ani_no = 1
		boss.act_wait = 0
		boss.act_no = 111
	end

	if boss.act_no == 111 then
		boss.act_wait = boss.act_wait + 1
		boss.xm = cs.div(boss.xm * 8, 9)
		if boss.act_wait > 50 then
			boss.ani_no = 2
			boss.ani_wait = 0
			boss.act_no = 112
		end

	elseif boss.act_no == 112 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 4 then
			boss.act_no = 113
			boss.act_wait = 0
			boss.ani_no = 3
			boss.count1 = 16
			cs.gBoss[2].bits = (cs.gBoss[2].bits or 0) | cs.BITS_BANISH_DAMAGE
			boss.tgt_x = boss.life
		end

	elseif boss.act_no == 113 then
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
			if boss.direct == 0 then
				deg = cs.GetArktan(boss.x - 2 * cs.VS * 16 - cs.gMC[1 + mc_no].x, boss.y - 8 * cs.VS - cs.gMC[1 + mc_no].y)
			else
				deg = cs.GetArktan(boss.x + 2 * cs.VS * 16 - cs.gMC[1 + mc_no].x, boss.y - 8 * cs.VS - cs.gMC[1 + mc_no].y)
			end
			deg = (deg + cs.Random(-16, 16)) & 0xFF

			ym = cs.GetSin(deg)
			xm = cs.GetCos(deg)
			if boss.direct == 0 then
				cs.SetNpChar(108, boss.x - 2 * cs.VS * 16, boss.y - 8 * cs.VS, xm, ym, 0, nil, cs.div(cs.MAX_NPC, 2))
			else
				cs.SetNpChar(108, boss.x + 2 * cs.VS * 16, boss.y - 8 * cs.VS, xm, ym, 0, nil, cs.div(cs.MAX_NPC, 2))
			end

			cs.PlaySoundObject(cs.WAVE_POP, 1)
			if boss.count1 == 0 or boss.life < boss.tgt_x - cs.bossHPMultiply(90) then
				boss.act_no = 114
				boss.act_wait = 0
				boss.ani_no = 2
				boss.ani_wait = 0
				cs.gBoss[2].bits = (cs.gBoss[2].bits or 0) & ~cs.BITS_BANISH_DAMAGE
			end
		end

	elseif boss.act_no == 114 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 10 then
			cs.gBoss[2].count1 = (cs.gBoss[2].count1 or 0) + 1
			if cs.gBoss[2].count1 > 2 then
				cs.gBoss[2].count1 = 0
				boss.act_no = 120
			else
				boss.act_no = 100
			end
			boss.ani_wait = 0
			boss.ani_no = 1
		end

	elseif boss.act_no == 120 then
		boss.act_no = 121
		boss.act_wait = 0
		boss.ani_no = 1
		boss.xm = 0
	end

	if boss.act_no == 121 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 50 then
			boss.act_no = 122
			boss.ani_wait = 0
			boss.ani_no = 2
		end

	elseif boss.act_no == 122 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 20 then
			boss.act_no = 123
			boss.ani_wait = 0
			boss.ani_no = 1
		end

	elseif boss.act_no == 123 then
		boss.ani_wait = boss.ani_wait + 1
		if boss.ani_wait > 4 then
			boss.act_no = 124
			boss.ani_no = 5
			boss.ym = -5 * cs.VS
			boss.view.top = 64 * cs.VS
			boss.view.bottom = 24 * cs.VS
			cs.PlaySoundObject(cs.WAVE_BUNRET, 1)
		end

	elseif boss.act_no == 124 then
		if (boss.flag & 8) ~= 0 then
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.SetQuake(60)
			boss.act_no = 100
			boss.ani_no = 1
			boss.view.top = 48 * cs.VS
			boss.view.bottom = 16 * cs.VS

			for i = 0, 1 do
				cs.SetNpChar(104, cs.Random(4, 16) * cs.VS * 16, cs.Random(0, 4) * cs.VS * 16, 0, 0, 4, nil, cs.div(cs.MAX_NPC, 4))
			end
			for i = 0, 5 do
				cs.SetNpChar(110, cs.Random(4, 16) * cs.VS * 16, cs.Random(0, 4) * cs.VS * 16, 0, 0, 4, nil, cs.div(cs.MAX_NPC, 4))
			end
			for i = 0, 7 do
				cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + boss.hit.bottom,
					cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0),
					0, nil, cs.div(cs.MAX_NPC, 2))
			end

			local turned = 0
			for mc_no = 0, cs.gNumMyChar - 1 do
				if boss.direct == 0 and boss.x < cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
				if boss.direct == 2 and boss.x > cs.gMC[1 + mc_no].x then
					turned = turned + 1
				end
			end
			if turned >= cs.gNumMyChar then
				boss.act_no = 110
				boss.direct = (boss.direct == 0) and 2 or 0
			end
		end

	elseif boss.act_no == 130 then
		boss.act_no = 131
		boss.ani_no = 3
		boss.act_wait = 0
		boss.xm = 0
		cs.PlaySoundObject(cs.WAVE_DESTROY_LARGE, 1)
		for i = 0, 7 do
			cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS,
				cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0),
				0, nil, cs.div(cs.MAX_NPC, 2))
		end
		cs.gBoss[2].cond = 0
		cs.gBoss[3].cond = 0
	end

	if boss.act_no == 131 then
		boss.act_wait = boss.act_wait + 1
		if cs.mod(boss.act_wait, 5) == 0 then
			cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS,
				cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0),
				0, nil, cs.div(cs.MAX_NPC, 2))
		end
		if cs.mod(cs.div(boss.act_wait, 2), 2) ~= 0 then
			boss.x = boss.x - cs.VS
		else
			boss.x = boss.x + cs.VS
		end
		if boss.act_wait > 100 then
			boss.act_wait = 0
			boss.act_no = 132
		end

	elseif boss.act_no == 132 then
		boss.act_wait = boss.act_wait + 1
		if cs.mod(cs.div(boss.act_wait, 2), 2) ~= 0 then
			boss.view.front = 20 * cs.VS
			boss.view.top = 12 * cs.VS
			boss.view.back = 20 * cs.VS
			boss.view.bottom = 12 * cs.VS
			boss.ani_no = 6
		else
			boss.view.front = 48 * cs.VS
			boss.view.top = 48 * cs.VS
			boss.view.back = 32 * cs.VS
			boss.view.bottom = 16 * cs.VS
			boss.ani_no = 3
		end
		if cs.mod(boss.act_wait, 9) == 0 then
			cs.SetNpChar(4, boss.x + cs.Random(-12, 12) * cs.VS, boss.y + cs.Random(-12, 12) * cs.VS,
				cs.Random(cs.div(-cs.VS * 2, 3), cs.div(cs.VS * 2, 3)), cs.Random(-3 * cs.VS, 0),
				0, nil, cs.div(cs.MAX_NPC, 2))
		end
		if boss.act_wait > 150 then
			boss.act_no = 140
			boss.hit.bottom = 12 * cs.VS
		end

	elseif boss.act_no == 140 then
		boss.act_no = 141
	end

	if boss.act_no == 141 then
		if (boss.flag & 8) ~= 0 then
			boss.act_no = 142
			boss.act_wait = 0
			boss.ani_no = 7
		end

	elseif boss.act_no == 142 then
		boss.act_wait = boss.act_wait + 1
		if boss.act_wait > 30 then
			boss.ani_no = 8
			boss.ym = -5 * cs.VS
			boss.bits = (boss.bits or 0) | cs.BITS_THROW_BLOCK
			boss.act_no = 143
		end

	elseif boss.act_no == 143 then
		boss.ym = -5 * cs.VS
		if boss.y < 0 then
			boss.cond = 0
			cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
			cs.SetQuake(30)
		end
	end

	-- 重力与移动
	boss.ym = boss.ym + cs.div(cs.VS, 8)
	if boss.ym > cs.MAX_MOVE then
		boss.ym = cs.MAX_MOVE
	end

	boss.x = boss.x + (boss.xm or 0)
	boss.y = boss.y + (boss.ym or 0)

	-- 矩形设置
	local idx = (boss.ani_no or 0) + 1
	if boss.direct == 0 then
		boss.rect = rcLeft[idx]
	else
		boss.rect = rcRight[idx]
	end

	ActBossChar02_01()
	ActBossChar02_02()
end

return ActBossChar_Frog