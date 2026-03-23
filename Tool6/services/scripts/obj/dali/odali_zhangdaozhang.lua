local class = require "class"
local define = require "define"
local script_base = require "script_base"
local odali_zhangdaozhang = class("odali_zhangdaozhang", script_base)
odali_zhangdaozhang.script_id = 002075
odali_zhangdaozhang.g_Ability = {}

odali_zhangdaozhang.g_Ability["aid"] = 39
odali_zhangdaozhang.g_Ability["nam"] = "咫尺天涯"
odali_zhangdaozhang.g_Ability["gld"] = 300000
odali_zhangdaozhang.g_LevMax = 3
odali_zhangdaozhang.g_Key = {}

odali_zhangdaozhang.g_Key["nul"] = 0
odali_zhangdaozhang.g_Key["stu"] = 1
odali_zhangdaozhang.g_Key["sty"] = 101
odali_zhangdaozhang.g_Key["stn"] = 100
odali_zhangdaozhang.g_Key["lup"] = 2
odali_zhangdaozhang.g_Key["upy"] = 201
odali_zhangdaozhang.g_Key["upn"] = 200
odali_zhangdaozhang.g_Key["des"] = 3
function odali_zhangdaozhang:OnDefaultEvent(selfId, targetId)
    local lev = self:QueryHumanAbilityLevel(selfId, self.g_Ability["aid"])
    self:BeginEvent(self.script_id)
    self:AddText("  我可以传授给你一种神奇的技能，利用这种技能制作出来的符文可以记录位置信息，以后你想再回到这个记录的地方，只要使用符文就可以了。")
    self:AddText("  请注意，越高级的符文可以使用的次数也会越来越多。")
    if self:GetLevel(selfId) >= 30 then
        if lev <= 0 then
            self:AddNumText("学习" .. self.g_Ability["nam"], 6, self.g_Key["stu"])
        else
            self:AddNumText("升级技能", 6, self.g_Key["lup"])
        end
        self:AddNumText("什么也不做", -1, self.g_Key["nul"])
    end
    self:AddNumText("定位符介绍", 11, self.g_Key["des"])
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_zhangdaozhang:OnEventRequest(selfId, targetId, arg, index)
    local key = index
    local lev = self:QueryHumanAbilityLevel(selfId, self.g_Ability["aid"])
    local exp = self:GetAbilityExp(selfId, self.g_Ability["aid"] )
    local ret, demandMoney, _, limitAbilityExp, limitAbilityExpShow, _, limitLevel =
        self:LuaFnGetAbilityLevelUpConfig(self.g_Ability["aid"], lev + 1)
    if key == self.g_Key["des"] then
        self:MsgBox(selfId, targetId, "#{function_help_020}")
    elseif key == self.g_Key["stu"] then
        if self:GetLevel(selfId) < 30 then
            return 0
        end
        self:OnAsk(selfId, targetId, self.g_Key["stu"], "  您学习这项技能需要消耗#{_EXCHG" .. demandMoney .. "}，是否继续？")
    elseif key == self.g_Key["sty"] then
        if self:GetLevel(selfId) < 30 then
            return 0
        end
        if lev > 0 then
            self:MsgBox(selfId, targetId, "  您已经学习过此技能了！")
            return 0
        end
        if self:LuaFnGetMoney(selfId) + self:GetMoneyJZ(selfId) < demandMoney then
            self:MsgBox(selfId, targetId, "  您身上的现金不足，无法学习此技能！")
            return 0
        end
        self:LuaFnCostMoneyWithPriority(selfId, demandMoney)
        self:SetHumanAbilityLevel(selfId, self.g_Ability["aid"], 1)
        self:SetMyPrescription(selfId, 1)
        self:MsgBox(selfId, targetId, "  恭喜您已经学会了" .. self.g_Ability["nam"] .. "，不过如果想制作使用次数更多的定位符，请升级您的技能。")
    elseif key == self.g_Key["lup"] then
        if self:GetLevel(selfId) < 30 then
            return 0
        end
        if lev >= self.g_LevMax then
            self:MsgBox(selfId, targetId, "  您的技能等级已经足够，不需要再次升级。")
            return 0
        end
        self:OnAsk(selfId, targetId, self.g_Key["lup"], "  您升级这项技能需要消耗#{_EXCHG" .. demandMoney .. "}，是否继续？")
    elseif key == self.g_Key["upy"] then
        if not ret then
            return 0
        end
        if self:GetLevel(selfId) < 30 then
            return 0
        end
        if lev < 1 then
            self:MsgBox(selfId, targetId, "  您还没有学习" .. self.g_Ability["nam"] .. "，等学会了1级技能之后再找我升级吧。")
            return 0
        end
        if lev >= self.g_LevMax then
            self:MsgBox(selfId, targetId, "  您的技能等级已经足够，不需要再次升级。")
            return 0
        end
        if exp < limitAbilityExp then
            self:MsgBox(selfId, targetId, "  需要" .. limitAbilityExpShow .. "点熟练度才能再次升级。")
            return 0
        end
        if self:LuaFnGetMoney(selfId) + self:GetMoneyJZ(selfId) < demandMoney then
            self:MsgBox(selfId, targetId, "  需要#{_EXCHG" .. demandMoney .. "}才能再次升级。")
            return 0
        end
        self:LuaFnCostMoneyWithPriority(selfId, demandMoney)
        self:SetHumanAbilityLevel(selfId, self.g_Ability["aid"], lev + 1)
        self:SetMyPrescription(selfId, lev + 1)
        self:MsgBox(selfId, targetId, "  您的技能已经成功的升级，恭喜您可以制造更高级的符文了。")
    else
        self:BeginUICommand()
        self:UICommand_AddInt(targetId)
        self:EndUICommand()
        self:DispatchUICommand(selfId, 1000)
    end
    return 1
end

function odali_zhangdaozhang:SetMyPrescription(selfId, lev)
    for i = 0, 5 do
        self:SetPrescription(selfId, 510 + (lev - 1) * 6 + i, 1)
    end
end

function odali_zhangdaozhang:OnAsk(selfId, targetId, key, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:AddNumText("是", -1, key * 100 + 1)
    self:AddNumText("否", -1, key * 100)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

function odali_zhangdaozhang:MsgBox(selfId, targetId, msg)
    self:BeginEvent(self.script_id)
    self:AddText(msg)
    self:EndEvent()
    self:DispatchEventList(selfId, targetId)
end

return odali_zhangdaozhang
