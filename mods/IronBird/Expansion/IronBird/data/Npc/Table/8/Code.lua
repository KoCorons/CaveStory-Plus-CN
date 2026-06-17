-- パゴット
-- Beetle
local function ActNpc008(npc)
	local rcLeft = {
		{left =  80, top =  80, right =  96, bottom =  96},
		{left =  96, top =  80, right = 112, bottom =  96},
	}
	local rcRight = {
		{left =  80, top =  96, right =  96, bottom = 112},
		{left =  96, top =  96, right = 112, bottom = 112},
	}

	if npc.act_no == 0 then
		cs.NpCharSetNearestXYTargetMC(npc)
		if cs.gMC[1 + npc.tgt_mc].x < npc.x + (cs.PARTSSIZE * cs.VS) and cs.gMC[1 + npc.tgt_mc].x > npc.x - (cs.PARTSSIZE * cs.VS) then
			npc.bits     = npc.bits | (cs.BITS_BANISH_DAMAGE | cs.BITS_BLOCK_MYCHAR)
			npc.ym       = cs.div(-cs.VS, 2)
			npc.tgt_x    = npc.x --最初の座標を記憶
			npc.tgt_y    = npc.y
			npc.act_no   = 1
			npc.act_wait = 0
			npc.count1   = npc.direct -- 方向を保存
			npc.count2   = 0
			npc.damage   = 2
			if npc.direct == cs.DIR_LEFT then
				npc.x = cs.gMC[1 + npc.tgt_mc].x + (16 * cs.PARTSSIZE) * cs.VS
				npc.xm = cs.div(-cs.MAX_MOVE, 2)
			else
				npc.x = cs.gMC[1 + npc.tgt_mc].x - (16 * cs.PARTSSIZE) * cs.VS
				npc.xm = cs.div(cs.MAX_MOVE, 2)
			end
			return
		end
		npc.rect.right = 0
		npc.damage     = 0
		npc.xm         = 0
		npc.ym         = 0
		npc.bits       = npc.bits & ~(cs.BITS_BANISH_DAMAGE | cs.BITS_BLOCK_MYCHAR)
		return
	elseif npc.act_no == 1 then
		--左向き
		cs.NpCharSetNearestXYTargetMC(npc)
		if npc.x > cs.gMC[1 + npc.tgt_mc].x then
			npc.direct = cs.DIR_LEFT
			npc.xm = npc.xm - 16
		else
			npc.direct = cs.DIR_RIGHT
			npc.xm = npc.xm + 16
		end

		if npc.flag & cs.FLAG_HIT_LEFT ~= 0 then
			npc.xm = cs.VS
		end
		if npc.flag & cs.FLAG_HIT_RIGHT ~= 0 then
			npc.xm = -cs.VS
		end

		if npc.y < npc.tgt_y then
			npc.ym = npc.ym + 8
		else
			npc.ym = npc.ym - 8
		end

		-- max move
		if npc.xm > cs.div(cs.MAX_MOVE, 2) then
			npc.xm = cs.div(cs.MAX_MOVE, 2)
		end
		if npc.xm < cs.div(-cs.MAX_MOVE, 2) then
			npc.xm = cs.div(-cs.MAX_MOVE, 2)
		end
		if npc.ym > cs.div(cs.VS, 2) then
			npc.ym = cs.div(cs.VS, 2)
		end
		if npc.ym < cs.div(-cs.VS, 2) then
			npc.ym = cs.div(-cs.VS, 2)
		end

		-- damage move
		if npc.shock ~= 0 then
			npc.x = npc.x + cs.div(npc.xm, 2)
			npc.y = npc.y + cs.div(npc.ym, 2)
		else
			npc.x = npc.x + npc.xm
			npc.y = npc.y + npc.ym
		end

		if cs.gMC[1 + npc.tgt_mc].x > npc.x + 25 * cs.PARTSSIZE * cs.VS or cs.gMC[1 + npc.tgt_mc].x < npc.x - 25 * cs.PARTSSIZE * cs.VS then
			npc.act_no     = 0
			npc.xm         = 0
			npc.direct     = npc.count1
			npc.x          = npc.tgt_x --元の座標へ
			npc.rect.right = 0 --表示もしない
			npc.damage     = 0 --ダメージ無し
			return
		end
	end

	npc.ani_wait = npc.ani_wait + 1
	if npc.ani_wait > 1 then
		npc.ani_wait = 0
		npc.ani_no = npc.ani_no + 1
	end
	if npc.ani_no > 1 then
		npc.ani_no = 0
	end

	if npc.direct == cs.DIR_LEFT then
		npc.rect = rcLeft[1 + npc.ani_no]
	else
		npc.rect = rcRight[1 + npc.ani_no]
	end
end

return ActNpc008