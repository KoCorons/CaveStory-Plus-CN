-- ムーンゴースト
-- Ghost (wall)
local function ActNpc213(npc)
	cs.NpCharSetNearestXYTargetMC(npc)
	local rect = {
		{left =   0, top =   0, right =   0, bottom =   0}, --

		{left =   0, top =   0, right =  48, bottom =  48}, --1
		{left =  48, top =   0, right =  96, bottom =  48},
		{left =  96, top =   0, right = 144, bottom =  48},

		{left = 144, top =   0, right = 192, bottom =  48}, --4 溜め
		{left = 192, top =   0, right = 240, bottom =  48},
		{left = 240, top =   0, right = 288, bottom =  48},

		{left =   0, top =  48, right =  48, bottom =  96}, --7 発射
		{left =  48, top =  48, right =  96, bottom =  96},
		{left =  96, top =  48, right = 144, bottom =  96},
	}

	if npc.act_no == 0 or npc.act_no == 1 then
		if npc.act_no == 0 then
			npc.ani_no = 0
			npc.tgt_x  = npc.x
			npc.tgt_y  = npc.y
		end

		--待機
		--local frame_x = cs.GetFramePositionX() + cs.div(cs.SURFACE_WIDTH * cs.VS, 2)
		--local frame_y = cs.GetFramePositionY() + cs.div(cs.SURFACE_HEIGHT * cs.VS, 2)
		if cs.gMC[1 + npc.tgt_mc].y > npc.y - (cs.VS * 8) and cs.gMC[1 + npc.tgt_mc].y < npc.y + (cs.VS * 8) then
			if npc.direct == cs.DIR_LEFT then
				npc.y = npc.y - cs.VS * cs.PARTSSIZE * 15
			else
				npc.y = npc.y + cs.VS * cs.PARTSSIZE * 15
			end
			npc.act_no   = 10
			npc.act_wait = 0
			npc.ani_no   = 1
			npc.ym       = 0
			npc.bits     = npc.bits | cs.BITS_BANISH_DAMAGE
		end
	elseif npc.act_no == 10 then
		-- 自キャラに向かう
		--ani
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 3 then
			npc.ani_no = 1
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 200 then
			npc.act_no   = 20
			npc.act_wait =  0
			npc.ani_no   =  4
		end
	elseif npc.act_no == 20 then
		-- 溜め
		--ani
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 6 then
			npc.ani_no = 4
		end

		npc.act_wait = npc.act_wait + 1
		if npc.act_wait > 50 then
			npc.act_no   = 30
			npc.act_wait =  0
			npc.ani_no   =  7
		end
	elseif npc.act_no == 30 then
		-- 発射
		--ani
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 9 then
			npc.ani_no = 7
		end

		npc.act_wait = npc.act_wait + 1

		if cs.mod(npc.act_wait, 5) == 1 then
			cs.SetNpChar(214, npc.x, npc.y, cs.div(cs.Random(cs.div(4, 2), 4 * 3) * cs.VS, 4), cs.Random(-cs.VS, cs.VS), cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			cs.PlaySoundObject(cs.WAVE_SPLASH, 1)
		end

		if npc.act_wait > 50 then
			npc.act_no   = 10
			npc.act_wait =  0
			npc.ani_no   =  1
			cs.NpCharSetNearestYTargetMC(npc)
		end
	elseif npc.act_no == 40 then
		-- 帰る
		if npc.y < npc.tgt_y then
			npc.ym = npc.ym + cs.div(cs.VS, 8)
		else
			npc.ym = npc.ym - cs.div(cs.VS, 8)
		end
		if npc.ym < -cs.VS * 2 then
			npc.ym = -cs.VS * 2
		end
		if npc.ym > cs.VS * 2 then
			npc.ym = cs.VS * 2
		end
		if npc.shock ~= 0 then
			npc.y = npc.y + cs.div(npc.ym, 2)
		else
			npc.y = npc.y + npc.ym
		end

		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 6 then
			npc.ani_no = 4
		end

		for mc_no = 0, cs.gNumMyChar - 1 do
			if cs.gMC[1 + mc_no].y < npc.tgt_y + 15 * cs.VS * cs.PARTSSIZE and cs.gMC[1 + mc_no].y > npc.tgt_y - 15 * cs.VS * cs.PARTSSIZE then
				npc.act_no   = 20
				npc.act_wait =  0
				npc.ani_no   =  4
				break
			end
		end
	end
	if npc.act_no >= 10 and npc.act_no <= 30 then
		if npc.y < cs.gMC[1 + npc.tgt_mc].y then
			npc.ym = npc.ym + cs.div(cs.VS, 20)
		else
			npc.ym = npc.ym - cs.div(cs.VS, 20)
		end
		if npc.ym < -cs.VS * 2 then
			npc.ym = -cs.VS * 2
		end
		if npc.ym >  cs.VS * 2 then
			npc.ym =  cs.VS * 2
		end

		if npc.flag & cs.FLAG_HIT_TOP ~= 0 then
			npc.ym =  cs.VS
		end
		if npc.flag & cs.FLAG_HIT_BOTTOM ~= 0 then
			npc.ym = -cs.VS
		end

		if npc.shock ~= 0 then
			npc.y = npc.y + cs.div(npc.ym, 2)
		else
			npc.y = npc.y + npc.ym
		end

		local mc_outside = 0
		for mc_no = 0, cs.gNumMyChar - 1 do
			if cs.gMC[1 + mc_no].y > npc.tgt_y + 15 * cs.VS * cs.PARTSSIZE or cs.gMC[1 + mc_no].y < npc.tgt_y - 15 * cs.VS * cs.PARTSSIZE then
				mc_outside = mc_outside + 1
			end
		end
		if mc_outside >= cs.gNumMyChar then
			npc.act_no = 40
		end
	end

	npc.rect = rect[1 + npc.ani_no]
end

return ActNpc213
