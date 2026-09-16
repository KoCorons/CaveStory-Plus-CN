-- プレス
-- Press
local function ActNpc114(npc)
	local rcLeft = {
		{left = 144, top = 112, right = 160, bottom = 136},
		{left = 160, top = 112, right = 176, bottom = 136},
		{left = 176, top = 112, right = 192, bottom = 136},
	}

	if npc.act_no == 0 or npc.act_no == 1 then
		if npc.act_no == 0 then
			npc.act_no = 1
			npc.y = npc.y - 4 * cs.VS
		end

		-- 待機／着地チェック
		if npc.flag & cs.FLAG_HIT_BOTTOM ~= 0 then
			-- 元のコードではここに何もない
		else
			npc.act_no = 10
			npc.ani_wait = 0
			npc.ani_no = 1
		end
	elseif npc.act_no == 10 then
		-- アニメーション更新
		npc.ani_wait = npc.ani_wait + 1
		if npc.ani_wait > 2 then
			npc.ani_wait = 0
			npc.ani_no = npc.ani_no + 1
		end
		if npc.ani_no > 2 then
			npc.ani_no = 2
		end

		-- プレイヤーとの当たり判定（ダメージ・ソリッド）
		if cs.gMC[1].y > npc.y then
			npc.bits = npc.bits & ~cs.BITS_BLOCK_MYCHAR2
			npc.damage = 127
		else
			npc.bits = npc.bits | cs.BITS_BLOCK_MYCHAR2
			npc.damage = 0
		end

		-- 着地したときの処理
		if npc.flag & cs.FLAG_HIT_BOTTOM ~= 0 then
			if npc.ani_no > 1 then
				for i = 0, 3 do
					cs.SetNpChar(4, npc.x, npc.y,
						cs.Random(-341, 341),
						cs.Random(-3 * cs.VS, 0),
						0, nil, 0x100)
				end
				cs.PlaySoundObject(cs.WAVE_QUAKE, 1)
				cs.SetQuake(10)
			end
			npc.act_no = 1
			npc.ani_no = 0
			npc.damage = 0
			npc.bits = npc.bits | cs.BITS_BLOCK_MYCHAR2
		end
	end

	-- 物理演算（重力・移動）
	npc.ym = npc.ym + cs.div(cs.VS, 16)
	if npc.ym > cs.MAX_MOVE then
		npc.ym = cs.MAX_MOVE
	end
	npc.y = npc.y + npc.ym

	npc.rect = rcLeft[1 + npc.ani_no]
end

return ActNpc114