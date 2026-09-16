local wait = {}
for mc_no = 1, cs.MAX_MYCHAR do
	wait[mc_no] = 0
end

-- Machinegun
local function ShootBullet_Machinegun1(mc_no, level)
	local bul_no
	if cs.CountArmsBullet(mc_no, 4) > 4 then
		return
	end

	if level == 1 then
		bul_no = cs.BULLET_MACHINEGUN1
	elseif level == 2 then
		bul_no = cs.BULLET_MACHINEGUN2
	elseif level == 3 then
		bul_no = cs.BULLET_MACHINEGUN3
	end

	if cs.gKeyMC[1 + mc_no] & cs.gKeyShot == 0 then
		cs.gMC[1 + mc_no].rensha = 6
	end
	if cs.gKeyMC[1 + mc_no] & cs.gKeyShot ~= 0 then
		cs.gMC[1 + mc_no].rensha = cs.gMC[1 + mc_no].rensha + 1
		if cs.gMC[1 + mc_no].rensha < 6 then
			return
		end
		cs.gMC[1 + mc_no].rensha = 0

		if cs.UseArmsEnergy(mc_no, 1) == false then
			cs.PlaySoundObject(cs.WAVE_ARMS_EMPTY, 1)
			if cs._empty[1 + mc_no] == 0 then
				cs.SetCaret(cs.gMC[1 + mc_no].x, cs.gMC[1 + mc_no].y, cs.CARET_EMPTY, cs.DIR_LEFT)
				cs._empty[1 + mc_no] = 50
			end
			return
		end
		if cs.gMC[1 + mc_no].up then
			if level == 3 then
				cs.gMC[1 + mc_no].ym = cs.gMC[1 + mc_no].ym + math.modf(cs.VS / 2)
			end
			if cs.gMC[1 + mc_no].direct == cs.DIR_LEFT then
				cs.SetBullet(mc_no, bul_no, cs.gMC[1 + mc_no].x - 3 * cs.VS, cs.gMC[1 + mc_no].y - 8 * cs.VS, cs.DIR_UP)
				cs.SetCaret(                cs.gMC[1 + mc_no].x - 3 * cs.VS, cs.gMC[1 + mc_no].y - 8 * cs.VS, cs.CARET_FLASH, cs.DIR_LEFT)
			else
				cs.SetBullet(mc_no, bul_no, cs.gMC[1 + mc_no].x + 3 * cs.VS, cs.gMC[1 + mc_no].y - 8 * cs.VS, cs.DIR_UP)
				cs.SetCaret(                cs.gMC[1 + mc_no].x + 3 * cs.VS, cs.gMC[1 + mc_no].y - 8 * cs.VS, cs.CARET_FLASH, cs.DIR_LEFT)
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
--					if cs.gMC[1 + mc_no].ym < -2 * cs.VS then
--						cs.gMC[1 + mc_no].ym = cs.div(cs.gMC[1 + mc_no].ym, 2) -- -2 * cs.VS
--					end
				end
			end
			if cs.gMC[1 + mc_no].direct == cs.DIR_LEFT then
				cs.SetBullet(mc_no, bul_no, cs.gMC[1 + mc_no].x - 3 * cs.VS, cs.gMC[1 + mc_no].y + 8 * cs.VS, cs.DIR_DOWN)
				cs.SetCaret(                cs.gMC[1 + mc_no].x - 3 * cs.VS, cs.gMC[1 + mc_no].y + 8 * cs.VS, cs.CARET_FLASH, cs.DIR_LEFT)
			else
				cs.SetBullet(mc_no, bul_no, cs.gMC[1 + mc_no].x + 3 * cs.VS, cs.gMC[1 + mc_no].y + 8 * cs.VS, cs.DIR_DOWN)
				cs.SetCaret(                cs.gMC[1 + mc_no].x + 3 * cs.VS, cs.gMC[1 + mc_no].y + 8 * cs.VS, cs.CARET_FLASH, cs.DIR_LEFT)
			end
		else
			if cs.gMC[1 + mc_no].direct == cs.DIR_LEFT then
--				if level == 3 then
--					cs.gMC[1 + mc_no].xm = cs.gMC[1 + mc_no].xm + cs.div(cs.VS, 2)
--				end
				cs.SetBullet(mc_no, bul_no, cs.gMC[1 + mc_no].x - 12 * cs.VS, cs.gMC[1 + mc_no].y + 3 * cs.VS, cs.DIR_LEFT)
				cs.SetCaret(                cs.gMC[1 + mc_no].x - 12 * cs.VS, cs.gMC[1 + mc_no].y + 3 * cs.VS, cs.CARET_FLASH, cs.DIR_LEFT)
			else
--				if level == 3 then
--					cs.gMC[1 + mc_no].xm = cs.gMC[1 + mc_no].xm - cs.div(cs.VS, 2)
--				end
				cs.SetBullet(mc_no, bul_no, cs.gMC[1 + mc_no].x + 12 * cs.VS, cs.gMC[1 + mc_no].y + 3 * cs.VS, cs.DIR_RIGHT)
				cs.SetCaret(                cs.gMC[1 + mc_no].x + 12 * cs.VS, cs.gMC[1 + mc_no].y + 3 * cs.VS, cs.CARET_FLASH, cs.DIR_LEFT)
			end
		end
		if level == 3 then
			cs.PlaySoundObject(cs.WAVE_POLEST2,  1)
		else
			cs.PlaySoundObject(cs.WAVE_POLESTAR, 1)
		end
		cs.gMC[1 + mc_no].muzzle = cs.MUZZLE_FLASH_DURATION
	else
		wait[1 + mc_no] = wait[1 + mc_no] + 1
		if cs.gMC[1 + mc_no].equip & cs.EQUIP_TURBOCHARGE ~= 0 then
			if wait[1 + mc_no] > 1 then
				wait[1 + mc_no] = 0
				cs.ChargeArmsEnergy(mc_no, 1)
			end
		else
			if wait[1 + mc_no] > 4 then
				wait[1 + mc_no] = 0
				cs.ChargeArmsEnergy(mc_no, 1)
			end
		end
	end
end

local ChargeCounter = 0

local function Idle(mc_no, level, slot)
	-- Machine Gun
	if ChargeCounter == 0 then
		ChargeCounter = cs.gMC[1 + mc_no].equip & cs.EQUIP_TURBOCHARGE ~= 0 and 5 or 10
		cs.ChargeUnequippedEnergy(mc_no, slot, 1)
	end
	ChargeCounter = ChargeCounter - 1
end

return {
	weapon_fired = ShootBullet_Machinegun1,
	weapon_switched = nil,
	weapon_idle = Idle
}
