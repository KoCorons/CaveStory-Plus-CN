-- パタパタバルログ（飛行ロジックを飛竜212に完全準拠、画面外判定なし）
local function ActNpc356(npc)
	local rcRight = {
		{left = 240, top = 128, right = 280, bottom = 152},
		{left = 240, top = 152, right = 280, bottom = 176},
	}

	if npc.act_no == 0 or npc.act_no == 11 then
		--
		if npc.act_no == 0 then
			npc.act_no   = 11
			npc.ani_wait = 0
			npc.tgt_y    = npc.y - cs.VS * 16
			npc.tgt_x    = npc.x - cs.VS * 6
			npc.ym       = 0
			if cs.gNumMyChar > 1 and cs.gQuoteOutfitP2 ~= cs.P2_OUTFIT_CURLY_NORMAL then
				cs.SetNpChar(355, 0, 0, 0, 0, 5, npc, cs.div(cs.MAX_NPC, 3))
			end
			cs.SetNpChar(355, 0, 0, 0, 0, 3, npc, cs.div(cs.MAX_NPC, 3))
			cs.SetNpChar(355, 0, 0, 0, 0, 2, npc, cs.div(cs.MAX_NPC, 3))
		end

		-- 滞空（元のまま）
		if npc.x < npc.tgt_x then
			npc.xm = npc.xm + cs.div(cs.VS, 64)
		else
			npc.xm = npc.xm - cs.div(cs.VS, 64)
		end
		if npc.y < npc.tgt_y then
			npc.ym = npc.ym + cs.div(cs.VS, 64)
		else
			npc.ym = npc.ym - cs.div(cs.VS, 64)
		end
		npc.x = npc.x + npc.xm
		npc.y = npc.y + npc.ym

	elseif npc.act_no == 20 or npc.act_no == 21 then
		-- 完全に212の20/21分支をコピー（画面外判定削除）
		if npc.act_no == 20 then
			npc.act_no = 21
			-- 212では速度を再初期化しないので何もしない
		end

		-- 212 の移動計算（加速・減速・上限）
		if npc.y < npc.tgt_y then
			npc.ym = npc.ym + cs.div(cs.VS, 32)
		else
			npc.ym = npc.ym - cs.div(cs.VS, 32)
		end
		npc.xm = npc.xm + cs.div(cs.VS, 16)
		if npc.xm > cs.VS * 3 then
			npc.xm = cs.VS * 3
		end
		if npc.xm < -cs.VS * 3 then
			npc.xm = -cs.VS * 3
		end
		npc.x = npc.x + npc.xm
		npc.y = npc.y + npc.ym

		-- 画面外判定を削除（212と同様に無限飛行）

	elseif npc.act_no == 22 then
		npc.xm = 0
		npc.ym = 0
	end

	-- アニメーション（356の元の2フレームを維持）
	npc.ani_wait = npc.ani_wait + 1
	if npc.ani_wait > 4 then
		npc.ani_wait = 0
		npc.ani_no = npc.ani_no + 1
	end
	if npc.ani_no > 1 then
		npc.ani_no = 0
	end

	npc.rect = rcRight[1 + npc.ani_no]
end

return ActNpc356