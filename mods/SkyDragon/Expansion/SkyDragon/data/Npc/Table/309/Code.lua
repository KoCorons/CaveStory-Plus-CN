-- エンジェル（飛行）
-- bute
local function ActNpc309(npc)
	local rcLeft = {
		{left =   0, top =   0, right =  16, bottom =  16},
		{left =  16, top =   0, right =  32, bottom =  16},
	}
	local rcRight = {
		{left =   0, top =  16, right =  16, bottom =  32},
		{left =  16, top =  16, right =  32, bottom =  32},
	}
	local rcZero = {left = 0, top = 0, right = 0, bottom = 0}   -- 用于隐藏

	local skip_act = false

	-- act 0/1：待机（隐藏状态）
	if npc.act_no == 0 or npc.act_no == 1 then
		if npc.act_no == 0 then
			npc.act_no = 1
			-- 记录玩家初始侧向
			if cs.gMC[1].x > npc.x then
				npc.count1 = 1   -- 右侧
			else
				npc.count1 = 0   -- 左侧
			end
			-- 设置零矩形隐藏（立即生效）
			npc.rect = rcZero
			return
		else
			-- act_no == 1：检测玩家穿越
			local playerX = cs.gMC[1].x
			local npcX = npc.x
			local current_side
			if playerX > npcX then
				current_side = 1
			else
				current_side = 0
			end

			-- 如果当前侧与记录不同，说明穿越
			if current_side ~= npc.count1 then
				-- 触发！取消隐藏，进入追击
				npc.act_no = 10
				skip_act = true
			else
				-- 未穿越，更新记录，保持隐藏
				npc.count1 = current_side
				npc.rect = rcZero   -- 保持隐藏
				return
			end
		end
	end

	-- act 10/11：追击（出现并攻击）
	if not skip_act then
		if npc.act_no == 10 then
			npc.act_no = 11
			npc.bits   = npc.bits | cs.BITS_BANISH_DAMAGE
			npc.damage = 5
		end

		if npc.act_no == 11 then
			cs.NpCharSetNearestXTargetMC(npc)
			local target = cs.gMC[1 + npc.tgt_mc]

			if npc.x > target.x then
				npc.direct = cs.DIR_LEFT
			else
				npc.direct = cs.DIR_RIGHT
			end

			local speed_inc = cs.div(cs.VS, 32)
			if npc.direct == cs.DIR_LEFT then
				npc.xm2 = npc.xm2 - speed_inc
			else
				npc.xm2 = npc.xm2 + speed_inc
			end

			if npc.y > target.y then
				npc.ym2 = npc.ym2 - speed_inc
			else
				npc.ym2 = npc.ym2 + speed_inc
			end

			-- 壁反弹
			if npc.xm2 < 0 and (npc.flag & cs.FLAG_HIT_LEFT) ~= 0 then
				npc.xm2 = npc.xm2 * -1
			end
			if npc.xm2 > 0 and (npc.flag & cs.FLAG_HIT_RIGHT) ~= 0 then
				npc.xm2 = npc.xm2 * -1
			end
			if npc.ym2 < 0 and (npc.flag & cs.FLAG_HIT_TOP) ~= 0 then
				npc.ym2 = npc.ym2 * -1
			end
			if npc.ym2 > 0 and (npc.flag & cs.FLAG_HIT_BOTTOM) ~= 0 then
				npc.ym2 = npc.ym2 * -1
			end

			if npc.xm2 < -cs.MAX_MOVE then
				npc.xm2 = -cs.MAX_MOVE
			end
			if npc.xm2 > cs.MAX_MOVE then
				npc.xm2 = cs.MAX_MOVE
			end
			if npc.ym2 < -cs.MAX_MOVE then
				npc.ym2 = -cs.MAX_MOVE
			end
			if npc.ym2 > cs.MAX_MOVE then
				npc.ym2 = cs.MAX_MOVE
			end

			npc.x = npc.x + npc.xm2
			npc.y = npc.y + npc.ym2

			npc.ani_wait = npc.ani_wait + 1
			if npc.ani_wait > 1 then
				npc.ani_wait = 0
				npc.ani_no = npc.ani_no + 1
			end
			if npc.ani_no > 1 then
				npc.ani_no = 0
			end
		end
	end

	-- 设置矩形（追击状态正常显示）
	if npc.direct == cs.DIR_LEFT then
		npc.rect = rcLeft[1 + npc.ani_no]
	else
		npc.rect = rcRight[1 + npc.ani_no]
	end

	-- 生命值过低时切换形态
	if npc.life <= 996 then
		npc.code_char = 316
		npc.act_no    =   0
	end
end

return ActNpc309