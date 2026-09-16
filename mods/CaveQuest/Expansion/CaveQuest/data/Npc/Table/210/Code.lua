-- パゴットLV2
local function ActNpc210(npc)
	cs.NpCharSetNearestXYTargetMC(npc)
	local rcLeft = {
		{left =   0, top = 112, right =  16, bottom = 128},
		{left =  16, top = 112, right =  32, bottom = 128},
	}

	local rcRight = {
		{left =  32, top = 112, right =  48, bottom = 128},
		{left =  48, top = 112, right =  64, bottom = 128},
	}

	if npc.act_no == 0 then
		-- 定位到最近的玩家，而不是摄像头
		local target_x = cs.gMC[1 + npc.tgt_mc].x
		if target_x < npc.x + 1 * cs.PARTSSIZE * cs.VS and target_x > npc.x - 1 * cs.PARTSSIZE * cs.VS then
			npc.bits   = npc.bits | (cs.BITS_BANISH_DAMAGE | cs.BITS_BLOCK_MYCHAR)
			npc.ym     = -cs.VS
			npc.tgt_y  = npc.y
			npc.act_no = 1
			npc.damage = 2
			if npc.direct == cs.DIR_LEFT then
				npc.x = target_x + 16 * cs.PARTSSIZE * cs.VS
				npc.xm = cs.div(-cs.MAX_MOVE, 2)
			else
				npc.x = target_x - 16 * cs.PARTSSIZE * cs.VS
				npc.xm = cs.div(cs.MAX_MOVE, 2)
			end
		else
			if npc.act_no == 0 then
				npc.bits       = npc.bits & ~(cs.BITS_BANISH_DAMAGE | cs.BITS_BLOCK_MYCHAR)
				npc.rect.right = 0
				npc.damage     = 0
				npc.xm         = 0
				npc.ym         = 0
				return
			end
		end
	elseif npc.act_no == 1 then
		--左向き
		if npc.x > cs.gMC[1 + npc.tgt_mc].x then
			npc.direct = cs.DIR_LEFT
			npc.xm = npc.xm - 16
		else
			npc.direct = cs.DIR_RIGHT
			npc.xm = npc.xm + 16
		end
		if npc.xm > cs.div( cs.MAX_MOVE, 2) then
			npc.xm = cs.div( cs.MAX_MOVE, 2)
		end
		if npc.xm < cs.div(-cs.MAX_MOVE, 2) then
			npc.xm = cs.div(-cs.MAX_MOVE, 2)
		end

		if npc.y < npc.tgt_y then
			npc.ym = npc.ym + 8
		else
			npc.ym = npc.ym - 8
		end
		if npc.ym >  cs.VS then
			npc.ym =  cs.VS
		end
		if npc.ym < -cs.VS then
			npc.ym = -cs.VS
		end

		if npc.shock ~= 0 then
			npc.x = npc.x + cs.div(npc.xm, 2)
			npc.y = npc.y + cs.div(npc.ym, 2)
		else
			npc.x = npc.x + npc.xm
			npc.y = npc.y + npc.ym
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

return ActNpc210