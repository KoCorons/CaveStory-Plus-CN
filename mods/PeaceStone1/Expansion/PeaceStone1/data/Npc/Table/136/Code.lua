-- 小狗（被主角背着）
local function ActNpc136(npc)
    -- 矩形定义
    local rcLeft = {
        [0] = {48, 144, 64, 160},
        [1] = {64, 144, 80, 160}
    }
    local rcRight = {
        [0] = {48, 160, 64, 176},
        [1] = {64, 160, 80, 176}
    }

    -- 状态机
    if npc.act_no == 0 then
        -- 清除可交互标志（位运算兼容写法）
        -- 假设 NPC_INTERACTABLE 是一个数值，比如 0x20，需根据实际定义
        local NPC_INTERACTABLE = 0x20  -- 请替换为实际值，或直接注释掉这行
        npc.bits = npc.bits - (npc.bits & NPC_INTERACTABLE)  -- 清除特定位
        -- 或者使用 bit 库： npc.bits = bit.band(npc.bits, bit.bnot(NPC_INTERACTABLE))
        
        npc.act_no = 1
        npc.ani_no = 0
        npc.ani_wait = 0
    end

    if npc.act_no == 1 then
        if math.random(0, 120) == 10 then
            npc.act_no = 2
            npc.act_wait = 0
            npc.ani_no = 1
        end
    elseif npc.act_no == 2 then
        npc.act_wait = npc.act_wait + 1
        if npc.act_wait > 8 then
            npc.act_no = 1
            npc.ani_no = 0
        end
    end

    -- 获取主角（根据 npc.tgt_mc，默认 0 为主角）
    local playerIndex = 1 + (npc.tgt_mc or 0)
    local player = cs.gMC[playerIndex]
    if not player then
        return  -- 没有主角就不更新
    end

    -- 确定小狗方向（跟随主角朝向）
    if player.direct == 0 then
        npc.direct = 0
    else
        npc.direct = 2
    end

    -- 位置计算：cs.VS 相当于原 0x200 的单位量
    npc.y = player.y - cs.VS * 10

    if npc.direct == 0 then
        npc.x = player.x + cs.VS * 4
        local r = rcLeft[npc.ani_no]
        npc.rect = {left = r[1], top = r[2], right = r[3], bottom = r[4]}
    else
        npc.x = player.x - cs.VS * 4
        local r = rcRight[npc.ani_no]
        npc.rect = {left = r[1], top = r[2], right = r[3], bottom = r[4]}
    end

    -- 跟随主角走路动画（每两帧抖一下）
    if (player.ani_no % 2) == 1 then
        npc.rect.top = npc.rect.top + 1
    end
end

return ActNpc136