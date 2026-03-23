local class = require "class"
local define = require "define"
local script_base = require "script_base"
local owudang_motaichong = class("owudang_motaichong", script_base)
owudang_motaichong.script_id = 012009
owudang_motaichong.g_xuanWuDaoId = 400918
owudang_motaichong.g_mpInfo = {}

owudang_motaichong.g_mpInfo[0] = {"星宿", 16, 96, 152, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XINGXIU}

owudang_motaichong.g_mpInfo[1] = {"逍遥", 14, 67, 145, define.MENPAI_ATTRIBUTE.MATTRIBUTE_XIAOYAO}

owudang_motaichong.g_mpInfo[2] = {"少林", 9, 95, 137, define.MENPAI_ATTRIBUTE.MATTRIBUTE_SHAOLIN}

owudang_motaichong.g_mpInfo[3] = {"天山", 17, 95, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_TIANSHAN}

owudang_motaichong.g_mpInfo[4] = {"天龙", 13, 96, 120, define.MENPAI_ATTRIBUTE.MATTRIBUTE_DALI}

owudang_motaichong.g_mpInfo[5] = {"峨嵋", 15, 89, 144, define.MENPAI_ATTRIBUTE.MATTRIBUTE_EMEI}

owudang_motaichong.g_mpInfo[6] = {"武当", 12, 103, 140, define.MENPAI_ATTRIBUTE.MATTRIBUTE_WUDANG}

owudang_motaichong.g_mpInfo[7] = {"明教", 11, 98, 167, define.MENPAI_ATTRIBUTE.MATTRIBUTE_MINGJIAO}

owudang_motaichong.g_mpInfo[8] = {"丐帮", 10, 91, 116, define.MENPAI_ATTRIBUTE.MATTRIBUTE_GAIBANG}

function owudang_motaichong:OnDefaultEvent(selfId, targetId)
    self:BeginEvent(self.script_id)
    self:AddText("#{MPXL_090113_04}")
    if self:GetLevel(selfId) >= 10 then
        self:AddNumText("洛阳", 9, 0)
        self:AddNumText("苏州", 9, 1)
        self:AddNumText("洛阳 - 九州商会", 9, 3)
        self:AddNumText("苏州 - 铁匠铺", 9, 4)
    end
    if self:GetLevel(selfId) >= 20 then
        self:AddNumText("束河古镇", 9, 6)
    end
    if self:GetLevel(selfId) >= 75 then
        self:AddNumText("#{MPCSLL_80925_01}", 9, 5)
    end
    self:AddNumText("大理", 9, 2)
    self:CallScriptFunction(self.g_xuanWuDaoId, "OnEnumerate", self, selfId, targetId)
    self:AddNumText("带我去其他门派吧", 9, 11)
    self:AddNumText("我怎样才能去敦煌和嵩山", 11, 2000)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function owudang_motaichong:OnEventRequest(selfId, targetId, arg, index)
    if index == self.g_xuanWuDaoId then
        self:CallScriptFunction(self.g_xuanWuDaoId, "OnDefaultEvent", selfId, targetId)
        return
    end
    if index == 2000 then
        self:BeginEvent(self.script_id)
        self:AddText("#{GOTO_DUNHUANF_SONGSHAN}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
    if index == 11 then
        self:BeginEvent(self.script_id)
        for i = 0, 8 do
            self:AddNumText("门派 - " .. self.g_mpInfo[i][1], 9, i + 12)
        end
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
   local  num = index
    if num > 11 then
        if self:LuaFnHaveImpactOfSpecificDataIndex(selfId, 113) == 1 then
            self:BeginEvent(self.script_id)
            self:AddText("  处于漕运，跑商状态是不能从我这里传送的")
            self:EndEvent()
            self:DispatchEventList(selfId, targetId)
            return
        end
        local i = num - 12
        self:CallScriptFunction(
            (400900),
            "TransferFuncFromNpc",
            selfId,
            self.g_mpInfo[i][2],
            self.g_mpInfo[i][3],
            self.g_mpInfo[i][4]
        )
        return
    end
    if index == 0 then
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 0, 132, 183, 10)
    elseif index == 1 then
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 1, 114, 162, 10)
    elseif index == 3 then
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 0, 234, 132, 10)
    elseif index == 4 then
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 1, 235, 132, 10)
    elseif index == 2 then
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 2, 241, 141)
    elseif index == 5 then
        self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 186, 288, 136, 75)
    end
    if index == 6 then
        self:BeginUICommand()
        self:UICommand_AddInt(self.script_id)
        self:UICommand_AddInt(targetId)
        self:UICommand_AddStr("GotoShuHeGuZhen")
        self:UICommand_AddStr("束河古镇为不加杀气场景，请注意安全。你确认要进入吗？")
        self:EndUICommand()
        self:DispatchUICommand(selfId, 24)
        return
    end
    if index == 2000 then
        self:BeginEvent(self.script_id)
        self:AddText("#{GOTO_DUNHUANF_SONGSHAN}")
        self:EndEvent()
        self:DispatchEventList(selfId, targetId)
        return
    end
end

function owudang_motaichong:GotoShuHeGuZhen(selfId, targetId)
    self:CallScriptFunction((400900), "TransferFuncFromNpc", selfId, 420, 200, 211, 20)
    return
end

return owudang_motaichong
