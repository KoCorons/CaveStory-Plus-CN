-- ミサイル赤
-- Projectile (Balrog missile)
local function ActNpc170(npc)
	local rcLeft = {
		{left = 112, top =  96, right = 128, bottom = 104},
		{left = 128, top =  96, right = 144, bottom = 104},
	}
	local rcRight = {
		{left = 112, top = 104, right = 128, bottom = 112},
		{left = 128, top = 104, right = 144, bottom = 112},
	}

	local bHit

	bHit = false

	if npc.direct == cs.DIR_LEFT and npc.flag & cs.FLAG_HIT_LEFT ~= 0 then
		bHit = true
	end
	if npc.direct == cs.DIR_RIGHT and npc.flag & cs.FLAG_HIT_RIGHT ~= 0 then
		bHit = true
	end
	if bHit then
		cs.PlaySoundObject(cs.WAVE_BOM, 1)
		cs.SetDestroyNpChar(npc.x, npc.y, 0, 3)
		cs.VanishNpChar(npc)
		return
	end

	if npc.act_no == 0 or npc.act_no == 1 then
		if npc.act_no == 0 then
			npc.act_no = 1
			if npc.direct == cs.DIR_LEFT then
				npc.xm = cs.Random( 1,  2) * cs.VS
			else
				npc.xm = cs.Random(-2, -1) * cs.VS
			end
			npc.ym = cs.Random(-2, 0) * cs.VS
			-- 修复：检查 pNpc 是否存在，避免 nil 错误
			if npc.pNpc then
				npc.tgt_mc = npc.pNpc.tgt_mc
			else
				npc.tgt_mc = 0  -- 默认目标索引 0，对应主角（后续使用 gMC[1 + tgt_mc]）
			end
		end
		npc.count1 = npc.count1 + 1
		if npc.direct == cs.DIR_LEFT then
			npc.xm = npc.xm - cs.div(cs.VS, 16)
			if cs.mod(npc.count1, 3) == 1 then
				cs.SetCaret(npc.x + 8 * cs.VS, npc.y, cs.CARET_MISSILE, cs.DIR_RIGHT)
			end
		else
			npc.xm = npc.xm + cs.div(cs.VS, 16)
			if cs.mod(npc.count1, 3) == 1 then
				cs.SetCaret(npc.x - 8 * cs.VS, npc.y, cs.CARET_MISSILE, cs.DIR_LEFT)
			end
		end

		if npc.count1 < 50 then
			if npc.y < cs.gMC[1 + npc.tgt_mc].y then
				npc.ym = npc.ym + cs.div(cs.VS, 16)
			else
				npc.ym = npc.ym - cs.div(cs.VS, 16)
			end
		else
			npc.ym = 0
		end

		npc.ani_no = npc.ani_no + 1
		if npc.ani_no > 1 then
			npc.ani_no = 0
		end
	end

	if npc.xm < -cs.VS * 2 then
		npc.xm = -cs.VS * 3
	end
	if npc.xm > cs.VS * 2 then
		npc.xm = cs.VS * 3
	end

	npc.x = npc.x + npc.xm
	npc.y = npc.y + npc.ym

	if npc.direct == cs.DIR_LEFT then
		npc.rect = rcLeft[ 1 + npc.ani_no]
	else
		npc.rect = rcRight[1 + npc.ani_no]
	end
end

return ActNpc170