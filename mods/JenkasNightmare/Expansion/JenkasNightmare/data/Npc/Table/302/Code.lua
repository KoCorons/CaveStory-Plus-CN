-- フォーカスマン
local function ActNpc302(npc)
	if npc.act_no == 0 then
		
	elseif npc.act_no == 10 then
		-- 落石よけステージ用
		npc.x = cs.gMC[1 + npc.tgt_mc].x
		npc.y = cs.gMC[1 + npc.tgt_mc].y - cs.VS * cs.PARTSSIZE * 2
	elseif npc.act_no == 20 then
		if npc.direct == 0 then
			npc.x = npc.x - cs.VS * 2
		elseif npc.direct == 1 then
			npc.y = npc.y - cs.VS * 2
		elseif npc.direct == 2 then
			npc.x = npc.x + cs.VS * 2
		elseif npc.direct == 3 then
			npc.y = npc.y + cs.VS * 2
		end
		cs.gMC[1 + npc.tgt_mc].x = npc.x
		cs.gMC[1 + npc.tgt_mc].y = npc.y
	elseif npc.act_no == 30 then
		--
		npc.x = cs.gMC[1 + npc.tgt_mc].x
		npc.y = cs.gMC[1 + npc.tgt_mc].y + cs.VS * cs.PARTSSIZE * 5
	elseif npc.act_no == 100 or npc.act_no == 101 then
		-- 指定のNPCとマイキャラの間に位置する（ただしXだけプレイヤーに追従）
		if npc.act_no == 100 then
			npc.act_no = 101
			if npc.direct ~= 0 then
				local n = cs.FindNpCharByEvent(npc.direct, cs.div(cs.MAX_NPC, 3))
				if n == cs.MAX_NPC then
					npc.cond = 0
					return
				else
					npc.pNpc = cs.gNPC[1 + n]
				end
			else
				npc.pNpc = cs.gBoss[1]
			end
		end
		-- X 跟随玩家，Y 保持原中点计算
		npc.x = cs.gMC[1 + npc.tgt_mc].x
		npc.y = cs.div(cs.gMC[1 + npc.tgt_mc].y + npc.pNpc.y, 2)
	end
end

return ActNpc302