--マシンガン（射程无限，偏移量 1280）
function ActBullet_MachineGun(bul, level)
	local move
	local rect1 = {
		{left =  64, top =   0, right =  80, bottom =  16},
		{left =  80, top =   0, right =  96, bottom =  16},
		{left =  96, top =   0, right = 112, bottom =  16},
		{left = 112, top =   0, right = 128, bottom =  16},
	}
	local rect2 = {
		{left =  64, top =  16, right =  80, bottom =  32},
		{left =  80, top =  16, right =  96, bottom =  32},
		{left =  96, top =  16, right = 112, bottom =  32},
		{left = 112, top =  16, right = 128, bottom =  32},
	}
	local rect3 = {
		{left =  64, top =  32, right =  80, bottom =  48},
		{left =  80, top =  32, right =  96, bottom =  48},
		{left =  96, top =  32, right = 112, bottom =  48},
		{left = 112, top =  32, right = 128, bottom =  48},
	}

	-- ★ 寿命结束 → 重置计时器（射程无限）
	bul.count1 = bul.count1 + 1
	if bul.count1 > bul.life_count then
		bul.count1 = 0
		return
	end

	-- 初始化（只执行一次）
	if bul.act_no == 0 then
		if level == 1 then
			move = 8 * cs.VS
		elseif level == 2 then
			move = 8 * cs.VS
		elseif level == 3 then
			move = 8 * cs.VS
		end
		bul.act_no = 1
		-- ★ 偏移范围 1280（十进制）
		if bul.direct == cs.DIR_LEFT then
			bul.xm = -move
			bul.ym = cs.Random(-1280, 1280)
		elseif bul.direct == cs.DIR_UP then
			bul.ym = -move
			bul.xm = cs.Random(-1280, 1280)
		elseif bul.direct == cs.DIR_RIGHT then
			bul.xm = move
			bul.ym = cs.Random(-1280, 1280)
		elseif bul.direct == cs.DIR_DOWN then
			bul.ym = move
			bul.xm = cs.Random(-1280, 1280)
		end
	else
		-- 移动
		bul.x = bul.x + bul.xm
		bul.y = bul.y + bul.ym
		if level == 1 then
			bul.rect = rect1[1 + bul.direct]
		elseif level == 2 then
			bul.rect = rect2[1 + bul.direct]
			if bul.direct == cs.DIR_UP or bul.direct == cs.DIR_DOWN then
				cs.SetNpChar(127, bul.x, bul.y, 0, 0, cs.DIR_UP,   nil, cs.div(cs.MAX_NPC, 2))
			else
				cs.SetNpChar(127, bul.x, bul.y, 0, 0, cs.DIR_LEFT, nil, cs.div(cs.MAX_NPC, 2))
			end
		elseif level == 3 then
			bul.rect = rect3[1 + bul.direct]
			cs.SetNpChar(128, bul.x, bul.y, 0, 0, bul.direct, nil, cs.div(cs.MAX_NPC, 2))
		end
	end
end

local function ActBullet_MachineGun1(bul)
	ActBullet_MachineGun(bul, 1)
end
return ActBullet_MachineGun1