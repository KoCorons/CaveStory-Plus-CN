local wait = {}
for mc_no = 1, cs.MAX_MYCHAR do
	wait[mc_no] = 0
end

-- Machinegun
local function ShootBullet_Machinegun1(mc_no, level)
	-- ★ 子弹数量上限改为极大值（实际无限）
	if cs.CountArmsBullet(mc_no, 4) > 9999 then
		return
	end

	local bul_no
	if level == 1 then
		bul_no = cs.BULLET_MACHINEGUN1
	elseif level == 2 then
		bul_no = cs.BULLET_MACHINEGUN2
	elseif level == 3 then
		bul_no = cs.BULLET_MACHINEGUN3
	end

	-- ★ 松开扳机时 rensha 归零（原版设为6，我们改为0避免累积）
	if cs.gKeyMC[1 + mc_no] & cs.gKeyShot == 0 then
		cs.gMC[1 + mc_no].rensha = 0
	end
	if cs.gKeyMC[1 + mc_no] & cs.gKeyShot ~= 0 then
		-- ★ 每帧增加 10（整数）
		cs.gMC[1 + mc_no].rensha = cs.gMC[1 + mc_no].rensha + 10

		-- ★ while 循环：当累积 >= 6 时发射并减去 6
		while cs.gMC[1 + mc_no].rensha >= 6 do
			-- 消耗1发弹药（逐发扣除）
			if cs.UseArmsEnergy(mc_no, 1) == false then
				cs.PlaySoundObject(cs.WAVE_ARMS_EMPTY, 1)
				if cs._empty[1 + mc_no] == 0 then
					cs.SetCaret(cs.gMC[1 + mc_no].x, cs.gMC[1 + mc_no].y, cs.CARET_EMPTY, cs.DIR_LEFT)
					cs._empty[1 + mc_no] = 50
				end
				cs.gMC[1 + mc_no].rensha = 0
				break
			end

			-- ★ 发射1颗子弹（原逻辑不变）
			local fired = false
			if cs.gMC[1 + mc_no].up then
				if level == 3 then
					cs.gMC[1 + mc_no].ym = cs.gMC[1 + mc_no].ym + math.modf(cs.VS / 2)
				end
				if cs.gMC[1 + mc_no].direct == cs.DIR_LEFT then
					local x = cs.gMC[1 + mc_no].x - 3 * cs.VS
					local y = cs.gMC[1 + mc_no].y - 8 * cs.VS
					cs.SetBullet(mc_no, bul_no, x, y, cs.DIR_UP)
					if not fired then cs.SetCaret(x, y, cs.CARET_FLASH, cs.DIR_LEFT) end
				else
					local x = cs.gMC[1 + mc_no].x + 3 * cs.VS
					local y = cs.gMC[1 + mc_no].y - 8 * cs.VS
					cs.SetBullet(mc_no, bul_no, x, y, cs.DIR_UP)
					if not fired then cs.SetCaret(x, y, cs.CARET_FLASH, cs.DIR_LEFT) end
				end
			elseif cs.gMC[1 + mc_no].down then
				if level == 3 then
					if cs.gMC[1 + mc_no].ym > 0 then
						cs.gMC[1 + mc_no].ym = math.modf(cs.gMC[1 + mc_no].ym / 2)
					end
					if cs.gMC[1 + mc_no].ym > -cs.VS * 2 then
						cs.gMC[1 + mc_no].ym = cs.gMC[1 + mc_no].ym - cs.VS
						if cs.gMC[1 + mc_no].ym < -2 * cs.VS then
							cs.gMC[1 + mc_no].ym = -2 * cs.VS
						end
					end
				end
				if cs.gMC[1 + mc_no].direct == cs.DIR_LEFT then
					local x = cs.gMC[1 + mc_no].x - 3 * cs.VS
					local y = cs.gMC[1 + mc_no].y + 8 * cs.VS
					cs.SetBullet(mc_no, bul_no, x, y, cs.DIR_DOWN)
					if not fired then cs.SetCaret(x, y, cs.CARET_FLASH, cs.DIR_LEFT) end
				else
					local x = cs.gMC[1 + mc_no].x + 3 * cs.VS
					local y = cs.gMC[1 + mc_no].y + 8 * cs.VS
					cs.SetBullet(mc_no, bul_no, x, y, cs.DIR_DOWN)
					if not fired then cs.SetCaret(x, y, cs.CARET_FLASH, cs.DIR_LEFT) end
				end
			else
				if cs.gMC[1 + mc_no].direct == cs.DIR_LEFT then
					local x = cs.gMC[1 + mc_no].x - 12 * cs.VS
					local y = cs.gMC[1 + mc_no].y + 3 * cs.VS
					cs.SetBullet(mc_no, bul_no, x, y, cs.DIR_LEFT)
					if not fired then cs.SetCaret(x, y, cs.CARET_FLASH, cs.DIR_LEFT) end
				else
					local x = cs.gMC[1 + mc_no].x + 12 * cs.VS
					local y = cs.gMC[1 + mc_no].y + 3 * cs.VS
					cs.SetBullet(mc_no, bul_no, x, y, cs.DIR_RIGHT)
					if not fired then cs.SetCaret(x, y, cs.CARET_FLASH, cs.DIR_LEFT) end
				end
			end

			-- 只播放一次音效和枪口闪光
			if not fired then
				if level == 3 then
					cs.PlaySoundObject(cs.WAVE_POLEST2, 1)
				else
					cs.PlaySoundObject(cs.WAVE_POLESTAR, 1)
				end
				cs.gMC[1 + mc_no].muzzle = cs.MUZZLE_FLASH_DURATION
				fired = true
			end

			-- ★ 减去阈值 6（整数）
			cs.gMC[1 + mc_no].rensha = cs.gMC[1 + mc_no].rensha - 6
		end
	else
		-- ★ 未射击时恢复弹药：每次恢复1发，频率普通10倍、涡轮20倍
		wait[1 + mc_no] = wait[1 + mc_no] + 1
		if cs.gMC[1 + mc_no].equip & cs.EQUIP_TURBOCHARGE ~= 0 then
			-- 涡轮：原每2帧恢复1发 → 20倍 → 每帧恢复10发（每次1发，循环10次）
			if wait[1 + mc_no] > 0 then
				wait[1 + mc_no] = 0
				for _ = 1, 10 do
					cs.ChargeArmsEnergy(mc_no, 1)
				end
			end
		else
			-- 普通：原每5帧恢复1发 → 10倍 → 每帧恢复2发（每次1发，循环2次）
			if wait[1 + mc_no] > 0 then
				wait[1 + mc_no] = 0
				for _ = 1, 2 do
					cs.ChargeArmsEnergy(mc_no, 1)
				end
			end
		end
	end
end

local ChargeCounter = 0

local function Idle(mc_no, level, slot)
	-- ★ 待机时恢复弹药：每次恢复1发，频率普通10倍、涡轮20倍
	if ChargeCounter == 0 then
		if cs.gMC[1 + mc_no].equip & cs.EQUIP_TURBOCHARGE ~= 0 then
			-- 涡轮：原每5帧恢复1发 → 20倍 → 每帧恢复4发（每次1发，循环4次）
			ChargeCounter = 1
			for _ = 1, 4 do
				cs.ChargeUnequippedEnergy(mc_no, slot, 1)
			end
		else
			-- 普通：原每10帧恢复1发 → 10倍 → 每帧恢复1发
			ChargeCounter = 1
			cs.ChargeUnequippedEnergy(mc_no, slot, 1)
		end
	end
	ChargeCounter = ChargeCounter - 1
end

return {
	weapon_fired = ShootBullet_Machinegun1,
	weapon_switched = nil,
	weapon_idle = Idle
}