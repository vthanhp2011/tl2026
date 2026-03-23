local class = require "class"
local define = require "define"
local script_base = require "script_base"
local xiaoxishuidan = class("xiaoxishuidan", script_base)
xiaoxishuidan.script_id = 300043
xiaoxishuidan.g_ItemId = 30008005
xiaoxishuidan.g_UseScriptId = 300053

function xiaoxishuidan:OnDefaultEvent(selfId)
    self:BeginEvent(self.script_id)
    self:AddText("#Y小洗髓丹")
    self:AddText("  使用之後可以将某一项属性已分配点数中的#Y5点#W变为潜能。")
    self:AddNumText("忘记5点力量", 0, 1)
    self:AddNumText("忘记5点灵气", 0, 2)
    self:AddNumText("忘记5点体力", 0, 3)
    self:AddNumText("忘记5点定力", 0, 4)
    self:AddNumText("忘记5点身法", 0, 5)
    self:AddNumText("以後再说", 0, 6)
    self:EndEvent()
    self:DispatchEventList(selfId, -1)
    return 0
end

function xiaoxishuidan:IsSkillLikeScript(selfId) return 0 end

function xiaoxishuidan:WashPoint(selfId, nType, nPoint, szStr)
    local ret = self:DelItem(selfId, self.g_ItemId, 1)
    if ret then
        local nNumber = self:LuaFnWashSomePoints(selfId, nType, nPoint)
        self:BeginEvent(self.script_id)
        self:AddText("#Y小洗髓丹")
        self:AddText("  您成功将#Y" .. tonumber(nNumber) .. "点#W已分配的#Y" .. szStr ..  "#W属性变为潜能。")
        self:EndEvent()
        self:DispatchEventList(selfId, -1)
    end
end

function xiaoxishuidan:OnEventRequest(selfId, targetId, arg, index)
    local str_list = {
        "力量", "灵气", "体力", "定力", "身法"
    }
    self:WashPoint(selfId, index, 5, str_list[index])
end

return xiaoxishuidan
