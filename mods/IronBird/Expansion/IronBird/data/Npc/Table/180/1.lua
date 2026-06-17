-- Curly AI (npc 180) - 修正版
local function ActNpc180(npc)
    -- 矩形定义（同前）
    local rcLeft = {
        {0, 96, 16, 112},
        {16, 96, 32, 112},
        {0, 96, 16, 112},
        {32, 96, 48, 112},
        {0, 96, 16, 112},
        {48, 96, 64, 112},
        {64, 96, 80, 112},
        {48, 96, 64, 112},
        {80, 96, 96, 112},
        {48, 96, 64, 112},
        {144, 96, 160, 112},
    }
    local rcRight = {
        {0, 112, 16, 128},
        {16, 112, 32, 128},
        {0, 112, 16, 128},
        {32, 112, 48, 128},
        {0, 112, 16, 128},
        {48, 112, 64, 128},
        {64, 112, 80, 128},
        {48, 112, 64, 128},
        {80, 112, 96, 128},
        {48, 112, 64, 128},
        {144, 112, 160, 128},
    }

    -- 获取主角
    local player = cs.gMC[1 + (npc.tgt_mc or 0)]

    -- 全局射击相关变量
    local gCurlyShoot_wait = cs.gCurlyShoot_wait or 0
    local gCurlyShoot_x = cs.gCurlyShoot_x or 0
    local gCurlyShoot_y = cs.gCurlyShoot_y or 0

    -- 计算目标点
    if npc.y < player.y - (10 * 16 * cs.VS) then
        if npc.y < 16 * 16 * cs.VS then
            npc.tgt_x = 320 * 16 * cs.VS
            npc.tgt_y = npc.y
        else
            npc.tgt_x = 0
            npc.tgt_y = npc.y
        end
    else
        if gCurlyShoot_wait ~= 0 then
            npc.tgt_x = gCurlyShoot_x
            npc.tgt_y = gCurlyShoot_y
        else
            npc.tgt_x = player.x
            npc.tgt_y = player.y
        end
    end

    -- 边界碰撞处理
    if npc.xm < 0 and (npc.flag & 1) ~= 0 then npc.xm = 0 end
    if npc.xm > 0 and (npc.flag & 4) ~= 0 then npc.xm = 0 end

    -- 状态机
    if npc.act_no == 20 then
        npc.x = player.x
        npc.y = player.y
        npc.act_no = 100
        npc.ani_no = 0
        cs.SetNpChar(183, 0, 0, 0, 0, 0, npc, 0x100)
        if cs.GetNPCFlag(563) ~= 0 then
            cs.SetNpChar(182, 0, 0, 0, 0, 0, npc, 0x100)
        else
            cs.SetNpChar(181, 0, 0, 0, 0, 0, npc, 0x100)
        end
    elseif npc.act_no == 40 then
        npc.act_no = 41
        npc.act_wait = 0
        npc.ani_no = 10
    end

    if npc.act_no == 41 then
        npc.act_wait = (npc.act_wait or 0) + 1
        if npc.act_wait == 750 then
            -- 清除可交互标志（假设 NPC_INTERACTABLE 数值为 0x20，请根据实际情况调整）
            local NPC_INTERACTABLE = 0x20
            npc.bits = npc.bits - (npc.bits & NPC_INTERACTABLE)
            npc.ani_no = 0
        end
        if npc.act_wait > 1000 then
            npc.act_no = 100
            npc.ani_no = 0
            cs.SetNpChar(183, 0, 0, 0, 0, 0, npc, 0x100)
            if cs.GetNPCFlag(563) ~= 0 then
                cs.SetNpChar(182, 0, 0, 0, 0, 0, npc, 0x100)
            else
                cs.SetNpChar(181, 0, 0, 0, 0, 0, npc, 0x100)
            end
        end
    elseif npc.act_no == 100 then
        npc.ani_no = 0
        npc.xm = (npc.xm * 7) // 8
        npc.count1 = 0
        if npc.x > npc.tgt_x + (16 * cs.VS) then
            npc.act_no = 200
            npc.ani_no = 1
            npc.direct = 0
            npc.act_wait = math.random(20, 60)
        elseif npc.x < npc.tgt_x - (16 * cs.VS) then
            npc.act_no = 300
            npc.ani_no = 1
            npc.direct = 2
            npc.act_wait = math.random(20, 60)
        end
    elseif npc.act_no == 200 then
        npc.xm = npc.xm - 0x20
        npc.direct = 0
        if (npc.flag & 1) ~= 0 then npc.count1 = npc.count1 + 1 else npc.count1 = 0 end
    elseif npc.act_no == 210 then
        npc.xm = npc.xm - 0x20
        npc.direct = 0
        if (npc.flag & 8) ~= 0 then npc.act_no = 100 end
    elseif npc.act_no == 300 then
        npc.xm = npc.xm + 0x20
        npc.direct = 2
        if (npc.flag & 4) ~= 0 then npc.count1 = npc.count1 + 1 else npc.count1 = 0 end
    elseif npc.act_no == 310 then
        npc.xm = npc.xm + 0x20
        npc.direct = 2
        if (npc.flag & 8) ~= 0 then npc.act_no = 100 end
    end

    -- 更新射击等待
    if gCurlyShoot_wait ~= 0 then
        gCurlyShoot_wait = gCurlyShoot_wait - 1
        cs.gCurlyShoot_wait = gCurlyShoot_wait
    end
    if gCurlyShoot_wait == 70 then npc.count2 = 10 end
    if gCurlyShoot_wait == 60 and (npc.flag & 8) ~= 0 and math.random(0, 2) ~= 0 then
        npc.count1 = 0
        npc.ym = -0x600
        npc.ani_no = 1
        -- 修正：将 cs.SOUND_MODE_PLAY 改为 0
        cs.PlaySoundObject(15, 0)
        if npc.x > npc.tgt_x then
            npc.act_no = 210
        else
            npc.act_no = 310
        end
    end

    -- 计算差值
    local xx = math.abs(npc.x - npc.tgt_x)
    local yy = math.abs(npc.y - npc.tgt_y)

    -- 动画选择
    if npc.act_no == 100 then
        if xx + (2 * cs.VS) < yy then npc.ani_no = 5 else npc.ani_no = 0 end
    end
    if npc.act_no == 210 or npc.act_no == 310 then
        if xx + (2 * cs.VS) < yy then npc.ani_no = 6 else npc.ani_no = 1 end
    end
    if npc.act_no == 200 or npc.act_no == 300 then
        npc.ani_wait = (npc.ani_wait or 0) + 1
        if xx + (2 * cs.VS) < yy then
            npc.ani_no = 6 + (npc.ani_wait // 4 % 4)
        else
            npc.ani_no = 1 + (npc.ani_wait // 4 % 4)
        end
        if npc.act_wait ~= 0 then
            npc.act_wait = npc.act_wait - 1
            if (npc.flag & 8) ~= 0 and npc.count1 > 10 then
                npc.count1 = 0
                npc.ym = -0x600
                npc.act_no = npc.act_no + 10
                npc.ani_no = 1
                cs.PlaySoundObject(15, 0)  -- 同样修正
            end
        else
            npc.act_no = 100
            npc.ani_no = 0
        end
    end

    -- 重力影响
    if npc.act_no >= 100 and npc.act_no < 500 then
        if npc.x < player.x - (80 * cs.VS) or npc.x > player.x + (80 * cs.VS) then
            if (npc.flag & 5) ~= 0 then
                npc.ym = npc.ym + (0x200 // 32)
            else
                npc.ym = npc.ym + (0x200 // 10)
            end
        else
            npc.ym = npc.ym + (0x200 // 10)
        end
    end

    -- 速度限制
    if npc.xm > 0x300 then npc.xm = 0x300 end
    if npc.xm < -0x300 then npc.xm = -0x300 end
    if npc.ym > 0x5FF then npc.ym = 0x5FF end

    -- 移动
    npc.x = npc.x + npc.xm
    npc.y = npc.y + npc.ym

    -- 最终动画修正
    if npc.act_no >= 100 and (npc.flag & 8) == 0 then
        if npc.ani_no ~= 1000 then
            if xx + (2 * cs.VS) < yy then npc.ani_no = 6 else npc.ani_no = 1 end
        end
    end

    -- 设置矩形
    if npc.direct == 0 then
        local r = rcLeft[npc.ani_no + 1]
        npc.rect = {left = r[1], top = r[2], right = r[3], bottom = r[4]}
    else
        local r = rcRight[npc.ani_no + 1]
        npc.rect = {left = r[1], top = r[2], right = r[3], bottom = r[4]}
    end
end

return ActNpc180