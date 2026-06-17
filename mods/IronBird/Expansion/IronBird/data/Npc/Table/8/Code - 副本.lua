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
		local frame_x = cs.GetFramePositionX()
		local frame_y = cs.GetFramePositionY()
		frame_x = frame_x + cs.div(cs.SURFACE_WIDTH * cs.VS, 2)
		frame_y = frame_y + cs.div(cs.SURFACE_HEIGHT * cs.VS, 2)
		if frame_x < npc.x + 1 * cs.PARTSSIZE * cs.VS and frame_x > npc.x - 1 * cs.PARTSSIZE * cs.VS then
			npc.bits   = npc.bits | (cs.BITS_BANISH_DAMAGE | cs.BITS_BLOCK_MYCHAR)
			npc.ym     = cs.div(-cs.VS, 2)
			npc.tgt_y  = npc.y
			npc.act_no = 1
			npc.damage = 2
			if npc.direct == cs.DIR_LEFT then
				npc.x = frame_x + 16 * cs.PARTSSIZE * cs.VS
				npc.xm = cs.div(-cs.MAX_MOVE, 2)
			else
				npc.x = frame_x - 16 * cs.PARTSSIZE * cs.VS
				npc.xm = cs.div(cs.MAX_MOVE, 2)
			end
		elseif npc.act_no == 0 then
			npc.bits       = npc.bits & ~(cs.BITS_BANISH_DAMAGE | cs.BITS_BLOCK_MYCHAR)
			npc.rect.right = 0
			npc.damage     = 0
			npc.xm         = 0
			npc.ym         = 0
			return
		end
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
		if npc.xm > cs.div(cs.MAX_MOVE, 2) then
			npc.xm = cs.div(cs.MAX_MOVE, 2)
		end
		if npc.xm < cs.div(-cs.MAX_MOVE, 2) then
			npc.xm = cs.div(-cs.MAX_MOVE, 2)
		end

		if npc.y < npc.tgt_y then
			npc.ym = npc.ym + 8
		else
			npc.ym = npc.ym - 8
		end
		if npc.ym > cs.div(cs.VS, 2) then
			npc.ym = cs.div(cs.VS, 2)
		end
		if npc.ym < cs.div(-cs.VS, 2) then
			npc.ym = cs.div(-cs.VS, 2)
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

return ActNpc008
